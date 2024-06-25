import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eol/Subjects/sub-lit/subject_lit.dart';
import 'package:eol/Subjects/utils/app_assets.dart';
import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/constant/link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class UnitView extends StatefulWidget {
  const UnitView({Key? key, required this.index});

  final int index;

  static const List<String> unitItemTitles = [
    "Book",
    "Quiz",
  ];

  static const List<IconData> unitItemIcons = [
    Icons.book,
    Icons.question_answer,
  ];

  @override
  _UnitViewState createState() => _UnitViewState();
}

class _UnitViewState extends State<UnitView> {
  late Future<LessonModel> futureLesson;
  late Future<List<Map<String, dynamic>>> futureQuiz;

  Future<LessonModel> fetchLesson() async {
    final response = await http.post(
      Uri.parse(linkLesson),
      body: {
        'unitid': widget.index.toString(),
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        return LessonModel.fromJson(jsonResponse['data'][0]);
      } else {
        throw Exception('Failed to load lesson');
      }
    } else {
      throw Exception('Failed to load lesson');
    }
  }

  Future<List<Map<String, dynamic>>> fetchQuiz(int unitId) async {
    final response = await http.post(
      Uri.parse(linkQuiz),
      body: {
        'unitid': unitId.toString(),
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        return List<Map<String, dynamic>>.from(jsonResponse['data']);
      } else {
        throw Exception('Failed to load quiz');
      }
    } else {
      throw Exception('Failed to load quiz');
    }
  }

  @override
  void initState() {
    super.initState();
    futureLesson = fetchLesson();
    futureQuiz =
        fetchQuiz(widget.index); // Fetch quiz data for the current unit
  }

  void _openPdf(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(url: url),
      ),
    );
  }

  void _openQuiz(List<Map<String, dynamic>> questions) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(questions: questions),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<LessonModel>(
          future: futureLesson,
          builder: (context, lessonSnapshot) {
            if (lessonSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (lessonSnapshot.hasError) {
              return Center(child: Text('Error: ${lessonSnapshot.error}'));
            } else if (!lessonSnapshot.hasData) {
              return Center(child: Text('No lesson data found'));
            } else {
              final lesson = lessonSnapshot.data!;
              final videoId = YoutubePlayer.convertUrlToId(lesson.videoUrl);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_sharp),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Unit ${widget.index}",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36),
                    if (videoId != null)
                      YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: videoId!,
                          flags: YoutubePlayerFlags(
                            autoPlay: false,
                            mute: false,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                      ),
                    SizedBox(height: 36),
                    Column(
                      children: List.generate(
                        UnitView.unitItemTitles.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: InkWell(
                              onTap: () {
                                if (index == 0) {
                                  String encodedFileName =
                                      encodeFileName(lesson.pdfUrl);

                                  _openPdf(
                                      '$linkServerName/upload/$encodedFileName');
                                } else if (index == 1) {
                                  futureQuiz.then((quizData) {
                                    _openQuiz(quizData);
                                  }).catchError((error) {
                                    print('Error loading quiz: $error');
                                  });
                                }
                              },
                              child: CustomUnitItem(
                                icon: UnitView.unitItemIcons[index],
                                title: UnitView.unitItemTitles[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class CustomUnitItem extends StatelessWidget {
  const CustomUnitItem({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.yellow,
          radius: 24,
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  final String url;

  const PdfViewerScreen({super.key, required this.url});

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf();
  }

  Future<void> _downloadAndSavePdf() async {
    try {
      // Decode the URL before using it
      final decodedUrl = Uri.decodeFull(widget.url);
      final uri = Uri.parse(decodedUrl);

      // Check if URL is valid
      if (!uri.hasScheme || uri.host.isEmpty) {
        throw Exception("Invalid URL: Scheme or host is missing");
      }

      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/downloaded_pdf.pdf';

      await Dio().download(uri.toString(), filePath);

      if (mounted) {
        setState(() {
          localFilePath = filePath;
        });
      }
    } catch (e) {
      print("Error downloading PDF: $e");
      // Handle error here, e.g., show error message to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
      ),
      body: localFilePath == null
          ? Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: localFilePath!,
            ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  const QuizScreen({Key? key, required this.questions}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // To store the selected answer index for each question
  List<int?> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    // Initialize the selectedAnswers list with null values
    selectedAnswers = List<int?>.filled(widget.questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: ListView.builder(
        itemCount: widget.questions.length,
        itemBuilder: (context, index) {
          final question = widget.questions[index];
          final answers = [
            question['right_answer'],
            question['incorrect_answer_1'],
            question['incorrect_answer_2'],
            question['incorrect_answer_3']
          ];
          // answers.shuffle();

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question['questions_text'] ?? 'N/A',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...List.generate(answers.length, (answerIndex) {
                    return RadioListTile<int>(
                      title: Text(answers[answerIndex] ?? 'N/A'),
                      value: answerIndex,
                      groupValue: selectedAnswers[index],
                      onChanged: (int? value) {
                        setState(() {
                          selectedAnswers[index] = value;
                        });
                      },
                    );
                  }),
                  if (selectedAnswers[index] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Correct Answer: ${question['right_answer'] ?? 'N/A'}',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LessonModel {
  final int id;
  final String name;
  final String videoUrl;
  final String pdfUrl;
  final int unitId;

  LessonModel({
    required this.id,
    required this.name,
    required this.videoUrl,
    required this.pdfUrl,
    required this.unitId,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['lessons_id'],
      name: json['lessons_name'],
      videoUrl: json['lessons_video_url'],
      pdfUrl: json['lessons_pdf'],
      unitId: json['units_id'],
    );
  }
}

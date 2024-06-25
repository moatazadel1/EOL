import 'dart:convert';

import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/Subjects/utils/fonts.dart';
import 'package:eol/plan/planonly/ScedulePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChoicePlan extends StatefulWidget {
  @override
  _ChoicePlanState createState() => _ChoicePlanState();
}

class _ChoicePlanState extends State<ChoicePlan> {
  String? selectedAnswer;
  int? time;
  double? reset;
  String? timeStudy;

  List<String> subjects = [
    'لغة عربية',
    'لغة إنجليزية',
    'لغة ثانية',
    'كيمياء',
    'فيزياء',
    'أحياء',
    'جيولوجيا',
    'رياضيات (باحثة)',
    'رياضيات (تطبيقية)',
    'علم نفس واجتماع',
    'تاريخ',
    'جغرافيا',
    'فلسفة ومنطق'
  ];

  List<String> currentSubjects = [];
  Map<String, int?> subjectLevels = {};

  @override
  void initState() {
    super.initState();
    _loadDepartment();
  }

  Future<void> _loadDepartment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedAnswer = prefs.getString('department');
      if (selectedAnswer != null) {
        updateSubjects(selectedAnswer!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' اختار خطتك',
          style: TextStyle(fontSize: 45, fontFamily: Appfonts.fontfamilymont),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 60.0, right: 30, top: 60, bottom: 90),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.bluelight,
                    ),
                    child: Center(
                      child: const Text(
                        'ما هي شعبتك',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RadioListTile<String>(
                    title: const Text('علوم'),
                    value: 'علوم',
                    groupValue: selectedAnswer,
                    onChanged: selectedAnswer == null
                        ? (value) {
                            setState(() {
                              selectedAnswer = value;
                              updateSubjects(value!);
                            });
                          }
                        : null,
                  ),
                  RadioListTile<String>(
                    title: const Text('ادبي'),
                    value: 'ادبي',
                    groupValue: selectedAnswer,
                    onChanged: selectedAnswer == null
                        ? (value) {
                            setState(() {
                              selectedAnswer = value;
                              updateSubjects(value!);
                            });
                          }
                        : null,
                  ),
                  RadioListTile<String>(
                    title: const Text('رياضة'),
                    value: 'رياضة',
                    groupValue: selectedAnswer,
                    onChanged: selectedAnswer == null
                        ? (value) {
                            setState(() {
                              selectedAnswer = value;
                              updateSubjects(value!);
                            });
                          }
                        : null,
                  ),
                  const SizedBox(height: 20),
                  if (selectedAnswer != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.bluelight,
                          ),
                          child: Center(
                            child: const Text(
                              'ما هي مدة الدراسة',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RadioListTile<int>(
                          title: const Text('ساعاتان'),
                          value: 2,
                          groupValue: time,
                          onChanged: (value) {
                            setState(() {
                              time = value;
                            });
                          },
                        ),
                        RadioListTile<int>(
                          title: const Text('ثلاث ساعات'),
                          value: 3,
                          groupValue: time,
                          onChanged: (value) {
                            setState(() {
                              time = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.bluelight,
                          ),
                          child: Center(
                            child: const Text(
                              'ما هي مدة الاستراحة',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RadioListTile<double>(
                          title: const Text('نصف ساعة'),
                          value: 0.5,
                          groupValue: reset,
                          onChanged: (value) {
                            setState(() {
                              reset = value;
                            });
                          },
                        ),
                        RadioListTile<double>(
                          title: const Text('ساعة'),
                          value: 1,
                          groupValue: reset,
                          onChanged: (value) {
                            setState(() {
                              reset = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.bluelight,
                          ),
                          child: Center(
                            child: const Text(
                              'ما هو وقت الدراسة',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RadioListTile<String>(
                          title: const Text('صباحاً'),
                          value: 'صباحاً',
                          groupValue: timeStudy,
                          onChanged: (value) {
                            setState(() {
                              timeStudy = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('مساءاً'),
                          value: 'مساءاً',
                          groupValue: timeStudy,
                          onChanged: (value) {
                            setState(() {
                              timeStudy = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  if (currentSubjects.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: currentSubjects.map((subject) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.bluelight,
                              ),
                              child: Center(
                                child: Text(
                                  'ما مستواك في $subject',
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            RadioListTile<int>(
                              title: const Text('جيد'),
                              value: 1,
                              groupValue: subjectLevels[subject],
                              onChanged: (value) {
                                setState(() {
                                  subjectLevels[subject] = value;
                                });
                              },
                            ),
                            RadioListTile<int>(
                              title: const Text('ضعيف'),
                              value: 0,
                              groupValue: subjectLevels[subject],
                              onChanged: (value) {
                                setState(() {
                                  subjectLevels[subject] = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isSubmitEnabled() ? submitAnswer : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey;
                          }
                          return Color(
                              0xFF102C57); // اللون الافتراضي عندما يكون الزر مفعل
                        },
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                    ),
                    child: const Text(
                      'Submit Answer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateSubjects(String value) {
    setState(() {
      currentSubjects.clear();
      subjectLevels.clear();
      if (value == 'علوم') {
        currentSubjects.addAll([
          'لغة عربية',
          'لغة إنجليزية',
          'لغة ثانية',
          'كيمياء',
          'فيزياء',
          'أحياء',
          'جيولوجيا',
        ]);
      } else if (value == 'ادبي') {
        currentSubjects.addAll([
          'لغة عربية',
          'لغة إنجليزية',
          'لغة ثانية',
          'علم نفس واجتماع',
          'تاريخ',
          'جغرافيا',
          'فلسفة ومنطق'
        ]);
      } else if (value == 'رياضة') {
        currentSubjects.addAll([
          'لغة عربية',
          'لغة إنجليزية',
          'لغة ثانية',
          'فيزياء',
          'كيمياء',
          'رياضيات (باحثة)',
          'رياضيات (تطبيقية)',
        ]);
      }
    });
  }

  bool _isSubmitEnabled() {
    return selectedAnswer != null &&
        time != null &&
        reset != null &&
        timeStudy != null &&
        subjectLevels.isNotEmpty &&
        currentSubjects.every((subject) => subjectLevels.containsKey(subject));
  }

  void submitAnswer() async {
    if (_isSubmitEnabled()) {
      var data = {
        'الشعبة': selectedAnswer!,
        'مدة_الدراسة': time!,
        'الاستراحه': reset!,
        'الوقت': timeStudy!,
        'ضعيف_لغه_عربيه': 0,
        'ضعيف_لغه_انجليزيه': 0,
        'ضعيف_لغه_تانيه': 0,
        'ضعيف_كيمياء': 0,
        'ضعيف_فيزياء': 0,
        'ضعيف_احياء': 0,
        'ضعيف_جيولوجيا': 0,
        'ضعيف_رياضيات_باحتة': 0,
        'ضعيف_رياضيات_تطبيقيه': 0,
        'ضعيف_علم_نفس_واجتماع': 0,
        'ضعيف_تاريخ': 0,
        'ضعيف_جغرافيا': 0,
        'ضعيف_فلسفة_ومنطق': 0,
      };

      // إضافة مستويات المواد إلى البيانات
      currentSubjects.forEach((subject) {
        var key = 'ضعيف_' + subject.replaceAll(' ', '_');
        data[key] = subjectLevels[subject] == 0 ? 1 : 0;
      });

      // تحويل البيانات إلى JSON
      String jsonData = jsonEncode(data);

      // طباعة شكل الطلب
      print('Request body: $jsonData');

      var url = Uri.parse('https://predict-3.onrender.com/predict/');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonData,
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        int planNumber = responseData['predictions'][0];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SchedulePage(
              planNumber: planNumber,
              selectedAnswer: selectedAnswer!,
              time: time!,
              reset: reset!,
              timeStudy: timeStudy!,
              subjectLevels: subjectLevels,
            ),
          ),
        );
      } else {
        print('فشل في إرسال الإجابة');
      }
    } else {
      print('لم يتم اختيار أي إجابة');
    }
  }
}

import 'dart:convert';

import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SchedulePage extends StatefulWidget {
  final int planNumber;
  final String selectedAnswer;
  final int time;
  final double reset;
  final String timeStudy;
  final Map<String, int?> subjectLevels;

  SchedulePage({
    required this.planNumber,
    required this.selectedAnswer,
    required this.time,
    required this.reset,
    required this.timeStudy,
    required this.subjectLevels,
  });

  static List<Map<String, dynamic>> scheduleData = [];

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // static List<Map<String, dynamic>> scheduleData = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchScheduleData();
  }

  void fetchScheduleData() async {
    try {
      int planNumber = widget.planNumber;
      var url = Uri.parse('http://192.168.1.5:8080/eol/plans/view.php');
      var response = await http.post(
        url,
        body: {
          "plan_num": planNumber.toString(),
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        setState(() {
          SchedulePage.scheduleData =
              List<Map<String, dynamic>>.from(responseData['data']);
          isLoading = false;
        });
      } else {
        print('Failed to load schedule data: ${response.body}');
        setState(() {
          isLoading = false;
          error = 'Failed to load data. Please try again later.';
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
        error = 'Error occurred. Please check your internet connection.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'جدول دراسي',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.blue,
        centerTitle: true,
      ),
      backgroundColor: AppColors.blue,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: const Color.fromARGB(255, 58, 132, 243),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 16.0,
                        columns: const [
                          DataColumn(
                              label: SizedBox(
                            width: 120,
                            child: Text(
                              'الوقت/اليوم',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          )),
                          DataColumn(
                              label: SizedBox(
                            width: 120,
                            child: Text(
                              'الى : من',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          )),
                          DataColumn(
                              label: SizedBox(
                            width: 120,
                            child: Text(
                              'المادة 1',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          )),
                          DataColumn(
                              label: SizedBox(
                            width: 120,
                            child: Text(
                              'الى : من',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          )),
                          DataColumn(
                              label: SizedBox(
                            width: 120,
                            child: Text(
                              'المادة 2',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          )),
                          DataColumn(
                              label: SizedBox(
                            width: 120,
                            child: Text(
                              'الى : من',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          )),
                          DataColumn(
                              label: SizedBox(
                            width: 120,
                            child: Text(
                              'المادة 3',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          )),
                          DataColumn(
                              label: SizedBox(
                            width: 120,
                            child: Text(
                              'الى : من',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          )),
                          DataColumn(
                              label: SizedBox(
                            width: 120,
                            child: Text(
                              'المادة 4',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          )),
                        ],
                        rows: SchedulePage.scheduleData.map((data) {
                          return DataRow(cells: [
                            DataCell(Container(
                                child: Center(child: Text(data['plans_day'])))),
                            DataCell(Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 116, 200, 240),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: 50.0,
                                width: 120,
                                child:
                                    Center(child: Text(data['plans_time_1'])))),
                            DataCell(Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 116, 200, 240),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: 50.0,
                                width: 120,
                                child: Center(
                                    child: Text(data['plans_subject_1'])))),
                            DataCell(Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 116, 200, 240),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: 50.0,
                                width: 120,
                                child:
                                    Center(child: Text(data['plans_time_2'])))),
                            DataCell(Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 116, 200, 240),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: 50.0,
                                width: 120,
                                child: Center(
                                    child: Text(data['plans_subject_2'])))),
                            DataCell(Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 116, 200, 240),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: 50.0,
                                width: 120,
                                child:
                                    Center(child: Text(data['plans_time_3'])))),
                            DataCell(Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 116, 200, 240),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: 50.0,
                                width: 120,
                                child: Center(
                                    child: Text(data['plans_subject_3'])))),
                            DataCell(Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 116, 200, 240),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: 50.0,
                                width: 120,
                                child:
                                    Center(child: Text(data['plans_time_4'])))),
                            DataCell(Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 116, 200, 240),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                height: 50.0,
                                width: 120,
                                child: Center(
                                    child: Text(data['plans_subject_4'])))),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
    );
  }
}

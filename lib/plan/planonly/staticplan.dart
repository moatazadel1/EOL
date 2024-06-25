import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/plan/planonly/ScedulePage.dart';
import 'package:flutter/material.dart';

class StaticPaln extends StatefulWidget {
  const StaticPaln({super.key});

  @override
  State<StaticPaln> createState() => _StaticPalnState();
}

class _StaticPalnState extends State<StaticPaln> {
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
      body: Padding(
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
                  DataCell(
                      Container(child: Center(child: Text(data['plans_day'])))),
                  DataCell(Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 116, 200, 240),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 50.0,
                      width: 120,
                      child: Center(child: Text(data['plans_time_1'])))),
                  DataCell(Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 116, 200, 240),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 50.0,
                      width: 120,
                      child: Center(child: Text(data['plans_subject_1'])))),
                  DataCell(Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 116, 200, 240),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 50.0,
                      width: 120,
                      child: Center(child: Text(data['plans_time_2'])))),
                  DataCell(Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 116, 200, 240),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 50.0,
                      width: 120,
                      child: Center(child: Text(data['plans_subject_2'])))),
                  DataCell(Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 116, 200, 240),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 50.0,
                      width: 120,
                      child: Center(child: Text(data['plans_time_3'])))),
                  DataCell(Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 116, 200, 240),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 50.0,
                      width: 120,
                      child: Center(child: Text(data['plans_subject_3'])))),
                  DataCell(Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 116, 200, 240),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 50.0,
                      width: 120,
                      child: Center(child: Text(data['plans_time_4'])))),
                  DataCell(Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 116, 200, 240),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 50.0,
                      width: 120,
                      child: Center(child: Text(data['plans_subject_4'])))),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

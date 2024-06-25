import 'dart:convert';
import 'package:eol/constant/link.dart';
import 'package:eol/models/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'unit_view.dart';

class UnitsListView extends StatefulWidget {
  const UnitsListView({
    super.key,
    required this.item,
  });

  final SubjectModel item;

  @override
  _UnitsListViewState createState() => _UnitsListViewState();
}

class _UnitsListViewState extends State<UnitsListView> {
  late Future<List<UnitModel>> futureUnits;

  Future<List<UnitModel>> fetchUnits() async {
    final response = await http.post(
      Uri.parse(linkUnits),
      body: {
        'subjectid': widget.item.subjectsId.toString(),
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        List<dynamic> unitsJson = jsonResponse['data'];
        return unitsJson.map((json) => UnitModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load units');
      }
    } else {
      throw Exception('Failed to load units');
    }
  }

  @override
  void initState() {
    super.initState();
    futureUnits = fetchUnits();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 238, 74, 74),
                    Color.fromARGB(255, 219, 204, 73),
                  ],
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          widget.item.subjectName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Expanded(
                  //     child: Text(
                  //       "0/100",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<UnitModel>>(
                future: futureUnits,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No units found'));
                  } else {
                    final units = snapshot.data!;
                    return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(20),
                      itemCount: units.length,
                      itemBuilder: (context, index) {
                        final unit = units[index];
                        return _UnitItem(index: unit.id, name: unit.name);
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitItem extends StatelessWidget {
  const _UnitItem({required this.index, required this.name});

  final int index;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnitView(index: index),
          ),
        );
      },
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Unit-$index : $name",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "0/100",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UnitModel {
  final int id;
  final String name;
  final int subjectId;

  UnitModel({required this.id, required this.name, required this.subjectId});

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['units_id'],
      name: json['units_name'],
      subjectId: json['units_subjects'],
    );
  }
}

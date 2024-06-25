import 'dart:convert';
import 'dart:developer';
import 'package:eol/componet/crud.dart';
import 'package:eol/constant/link.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/Subjects/utils/fonts.dart';
import 'package:eol/homes/home_literary.dart';
import 'package:eol/homes/home_mathematics.dart';
import 'package:eol/homes/home_scientific.dart';
import 'package:http/http.dart' as http;

class ChooseDepartment extends StatefulWidget {
  const ChooseDepartment({super.key});

  @override
  State<ChooseDepartment> createState() => _ChooseDepartmentState();
}

class _ChooseDepartmentState extends State<ChooseDepartment> with Crud {
  List<Map<String, dynamic>> departments = [];

  @override
  void initState() {
    super.initState();
    _fetchDepartments();
  }

  _fetchDepartments() async {
    try {
      const url = linkDepartment;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          var responseData = json.decode(response.body);
          if (responseData['status'] == 'success') {
            departments = List<Map<String, dynamic>>.from(responseData['data']);
            log('Departments List: $departments');
          } else {
            throw Exception('Failed to load departments');
          }
        });
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Failed to load departments (Exception: $e)');
    }
  }

  void saveDepartment(int departmentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('departmentId', departmentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluelight,
      appBar: AppBar(
        backgroundColor: AppColors.bluelight,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'EOL',
          style: TextStyle(
            color: Colors.white,
            fontSize: 70,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
            fontFamily: Appfonts.fontfamilymont,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 60.0),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: 450,
            child: departments.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const Center(
                        child: Text(
                          'Choose your department',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: Appfonts.fontfamilymont,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...departments.map((department) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: _buildDepartmentButton(
                            context,
                            _getDepartmentIcon(department['departments_id']),
                            department['departments_name'],
                            () {
                              saveDepartment(department['departments_id']);
                              _navigateToHome(department['departments_id']);
                            },
                          ),
                        );
                      }).toList(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildDepartmentButton(
    BuildContext context,
    String imagePath,
    String text,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90.0),
      child: Container(
        width: 500,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFF102C57)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          onPressed: onPressed,
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 80,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDepartmentIcon(int departmentId) {
    switch (departmentId) {
      case 1:
        return 'images/microscope.png';
      case 2:
        return 'images/tools.png';
      case 3:
        return 'images/books.png';
      default:
        return 'images/default.png'; // Default icon if department ID does not match
    }
  }

  void _navigateToHome(int departmentId) {
    Widget homeWidget;
    switch (departmentId) {
      case 1:
        homeWidget = HomeScientific(departmentId: departmentId);
        break;
      case 2:
        homeWidget = HomeMathematics(departmentId: departmentId);
        break;
      case 3:
        homeWidget = HomeLiterary(departmentId: departmentId);
        break;
      default:
        homeWidget = HomeScientific(
            departmentId:
                departmentId); // Default home widget if department ID does not match
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => homeWidget,
      ),
    );
  }
}

import 'package:eol/Subjects/utils/app_assets.dart';
import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/models/subject_model.dart';
import 'package:flutter/material.dart';

class MathView extends StatelessWidget {
  const MathView({super.key});

  static const List<SubjectModel> subjects = [
    // SubjectModel(subjectName: "Algebra", subjectImg: Assets.imagesBooks),
    // SubjectModel(subjectName: "Dynamics", subjectImg: Assets.imagesBooks),
    // SubjectModel(subjectName: "Statics", subjectImg: Assets.imagesBooks),
    // SubjectModel(subjectName: "Calculus ", subjectImg: Assets.imagesBooks),
    // SubjectModel(subjectName: "Integration ", subjectImg: Assets.imagesBooks),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_sharp)),
                const Spacer(),
                const Text(
                  "Mathematics",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 46,
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: subjects.length,
                itemBuilder: (context, index) =>
                    CustomSubjectItem(item: subjects[index]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSubjectItem extends StatelessWidget {
  const CustomSubjectItem({super.key, required this.item});

  final SubjectModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(item.subjectImg),
              SizedBox(
                width: 10,
              ),
              Text(
                item.subjectName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

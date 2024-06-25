import 'dart:io';

import 'package:eol/Subjects/sub-lit/subject_lit.dart';
import 'package:eol/Subjects/sub-sci/views/units_list_view.dart';
import 'package:eol/constant/link.dart';
import 'package:flutter/material.dart';
import 'package:eol/models/subject_model.dart';

class SubjectViewsci extends StatelessWidget {
  final List<SubjectModel> subjects;

  const SubjectViewsci({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120,
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
                    Color.fromARGB(255, 219, 204, 73)
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
                      )),
                  SizedBox(
                    width: 4,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hello,",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Good Morning",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                "Explore Subjects",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: subjects.length,
                itemBuilder: (context, index) =>
                    _GridItem(item: subjects[index])),
          ],
        ),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({
    super.key,
    required this.item,
  });

  final SubjectModel item;

  @override
  Widget build(BuildContext context) {
    String encodedFileName = encodeFileName(item.subjectImg);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnitsListView(
              item: item,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset(8, 8),
              ),
            ],
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                '$linkServerName/upload/$encodedFileName',
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset('images/books.png');
                },
              ),
              // child: Image.network(
              //   "https:${item.subjectImg}",
              //   // item.imgPath,
              //   fit: BoxFit.fill,
              // ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              item.subjectName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

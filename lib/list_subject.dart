import 'package:flutter/material.dart';

class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white10,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu_outlined),
              color: Colors.blue,
            ),
            title: Center(
                child: Text(
              'Subject  Name',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            )),
            actions: [
              IconButton(
                icon: Text(
                  'EOL',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 13,
                  ),
                ),
                onPressed: () {
                  // إضافة السلوك عند النقر على زر الإعدادات
                },
              ),
            ]),
        body: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: buildCustomElevatedButton('plans for every subject'),
            ),
            Expanded(
              child: buildCustomElevatedButton('Material &books'),
            ),
            Expanded(
              child: buildCustomElevatedButton('Question bank'),
            ),
            Expanded(
              child: buildCustomElevatedButton('Summaries'),
            ),
            Expanded(
              child: buildCustomElevatedButton('Revision'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomElevatedButton(String label) {
    return SizedBox(
      height: 80,
      width: 600,
      child: IconButton(
          onPressed: () {},
          icon: Container(
              height: 60,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
              ),
              child: Text(
                '           ' + label,
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ))),
    );
  }
}

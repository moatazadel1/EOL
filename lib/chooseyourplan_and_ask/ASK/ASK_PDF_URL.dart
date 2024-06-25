import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/Subjects/utils/fonts.dart';
import 'package:eol/chooseyourplan_and_ask/ASK/chat_url.dart';
import 'package:flutter/material.dart';

class Ask_Page extends StatelessWidget {
  const Ask_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluelight,
      appBar: AppBar(
        backgroundColor: AppColors.bluelight,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              const Text('Ask Me',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: Appfonts.fontfamilymont)),
              const SizedBox(
                height: 140,
              ),
              Container(
                height: 90,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue // Background color
                      ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("chatpdf");
                  },
                  child: const Text(
                    'pdf',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontFamily: Appfonts.fontfamilymont),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 90,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue, // Background color
                  ),
                  onPressed: () async {
                    String? url = await _getUrlFromUser(context);
                    if (url != null && url.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage2(url: url),
                        ),
                      );
                    }
                  },
                  child: const Text('url',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontFamily: Appfonts.fontfamilymont)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _getUrlFromUser(BuildContext context) async {
    TextEditingController urlController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter URL'),
          content: TextField(
            controller: urlController,
            decoration: InputDecoration(hintText: "Enter URL here"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(urlController.text);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

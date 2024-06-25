import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/Subjects/utils/fonts.dart';
import 'package:flutter/material.dart';

class ChoicePlanAsk extends StatefulWidget {
  const ChoicePlanAsk({super.key});

  @override
  State<ChoicePlanAsk> createState() => _ChoicePlanAskState();
}

class _ChoicePlanAskState extends State<ChoicePlanAsk> {
  bool isHovered1 = false;
  bool isHovered2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'EOL',
          style: TextStyle(
              color: Colors.white,
              fontSize: 70,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
              fontFamily: Appfonts.fontfamilymont),
        ),
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
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                onEnter: (_) => setState(() => isHovered1 = true),
                onExit: (_) => setState(() => isHovered1 = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: isHovered1 ? 110 : 95,
                  width: isHovered1 ? 350 : 300,
                  decoration: BoxDecoration(
                    color: AppColors.bluelight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("chooseplan");
                    },
                    child: const Text(
                      "Make Your Plan",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.2,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40, // Adjust the height as per your requirement
              ),
              MouseRegion(
                onEnter: (_) => setState(() => isHovered2 = true),
                onExit: (_) => setState(() => isHovered2 = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: isHovered2 ? 110 : 95,
                  width: isHovered2 ? 350 : 300,
                  decoration: BoxDecoration(
                    color: AppColors.bluelight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("AskPage");
                    },
                    child: const Text(
                      "Send PDF Or URL and Ask",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.2,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

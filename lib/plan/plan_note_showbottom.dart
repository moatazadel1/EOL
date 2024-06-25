import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:flutter/material.dart';

class plan_note extends StatelessWidget {
  const plan_note({
    required this.title,
    required this.icon,
    required this.onpress,
    super.key,
  });

  final String title;

  final IconData icon;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onpress,
      leading: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.blue.withOpacity(0.4),
        ),
        child: Icon(
          icon,
          size: 35,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 35, fontFamily: 'EBGaramond-Italic-VariableFont_wght'),
      ),
      //
    );
  }
}

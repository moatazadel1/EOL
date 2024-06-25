import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:flutter/material.dart';

class cardnote extends StatelessWidget {
  final void Function()? ontap;
  final String title;
  final String content;
  final void Function()? ondelete;

  const cardnote(
      {super.key,
      required this.ontap,
      required this.title,
      required this.content,
      this.ondelete});

  get backgroundColor => null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Container(
          height: 200,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.blue.withOpacity(0.4),
          ),
          child: Expanded(
              flex: 1,
              child: ListTile(
                title: Text("$title"),
                subtitle: Text("$content "),
                trailing:
                    IconButton(onPressed: ondelete, icon: Icon(Icons.delete)),
              )),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class custtextform extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroller;

  final String? Function(String?)? valid;

  custtextform(
      {super.key,
      required this.hint,
      required this.mycontroller,
      required this.valid});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: valid,
          controller: mycontroller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            //hintStyle: TextStyle(fontWeight: FontWeight.bold)
          ),
        ),
      ],
    );
  }
}

import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/componet/crud.dart';
import 'package:eol/componet/valid.dart';
import 'package:eol/constant/link.dart';
import 'package:eol/plan/note/custtextform.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final notes;

  const EditNote({super.key, this.notes});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  Crud crudedite = Crud();
  bool isLoading = false;

  EditNote() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crudedite.postRequest(linkUpdateNote, {
        "title": title.text,
        "content": content.text,
        "id": widget.notes['notes_id'].toString(),
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context).pop();
      } else {
        //
      }
    }
  }

  @override
  void initState() {
    title.text = widget.notes['notes_title'];
    content.text = widget.notes['notes_content'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edite note"),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    custtextform(
                      hint: "title",
                      mycontroller: title,
                      valid: (val) {
                        return validinput(val!, 1, 40);
                      },
                    ),
                    custtextform(
                      hint: "new content",
                      mycontroller: content,
                      valid: (val) {
                        return validinput(val!, 5, 255);
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            await EditNote();
                          },
                          child: Text("edite"),
                          textColor: Colors.white,
                          color: AppColors.blue.withOpacity(0.4),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

import 'package:eol/componet/crud.dart';
import 'package:eol/componet/valid.dart';
import 'package:eol/constant/link.dart';
import 'package:eol/login/sign/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();
  bool isLoading = false;

  TextEditingController firstName = TextEditingController();

  TextEditingController email = TextEditingController();
  var dateController = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  signup() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(
        linkSignUp,
        {
          "username": firstName.text,
          "email": email.text,
          "password": password.text,
          "date_of_birth": dateController.text,
          "phone_number": phone.text,
        },
      );
      setState(() {
        isLoading = false;
      });
      if (response['status'] == "success") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("id", response['data']['id'].toString());
        await prefs.setString("username", response['data']['username']);
        await prefs.setString("email", response['data']['email']);
        if (!mounted) return;

        Navigator.of(context)
            .pushNamedAndRemoveUntil("choose_department", (route) => false);
      } else {
        print("signup fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, right: 25, left: 25),
                child: Form(
                  key: formstate,
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          'EOL',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 70,
                              fontFamily: 'Smooch-Regular'),
                        ),
                      ),
                      Center(
                          child: Text(
                        'Create an account',
                        style: TextStyle(
                            color: Color(0xFF102C57),
                            fontSize: 30,
                            fontFamily: 'Ephesis-Regular'),
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            return validinput(value!, 3, 20);
                          },
                          controller: firstName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF102C57), width: 1.5),
                                  borderRadius: BorderRadius.circular(50)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(50)),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              label: Text("First Name",
                                  style:
                                      Theme.of(context).textTheme.bodySmall)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          return validinput(value!, 5, 40);
                        },
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF102C57), width: 1.5),
                                borderRadius: BorderRadius.circular(50)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(50)),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            label: Text(
                              "Email",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF102C57), width: 1.5),
                                borderRadius: BorderRadius.circular(50)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(50)),
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: Colors.black,
                            ),
                            label: Text(
                              "Date",
                              style: TextStyle(color: Colors.black),
                            )),
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.parse('1900-01-01'),
                            lastDate: DateTime.parse('2100-12-03'),
                          ).then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IntlPhoneField(
                          pickerDialogStyle: PickerDialogStyle(
                            backgroundColor: Colors.white,
                          ),
                          style: TextStyle(color: Colors.black),
                          initialCountryCode: 'IQ',
                          languageCode: 'ar',
                          cursorColor: Colors.black,
                          controller: phone,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15.0),
                            hintText: 'Phone number',
                            hintStyle: TextStyle(color: Colors.black),
                            iconColor: Colors.black,
                            floatingLabelStyle: TextStyle(color: Colors.black),
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Colors.black,
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(50)),
                          )),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          return validinput(value!, 3, 10);
                        },
                        controller: password,
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF102C57), width: 1.5),
                                borderRadius: BorderRadius.circular(50)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(50)),
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.black,
                            ),
                            label: Text(
                              "password",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 90.0, left: 90),
                        child: Container(
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF102C57)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            onPressed: () async {
                              await signup();
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Donot have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Color(0xFF102C57),
                                  fontSize: 15,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

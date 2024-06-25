import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eol/Subjects/utils/fonts.dart';
import 'package:eol/componet/crud.dart';
import 'package:eol/componet/valid.dart';
import 'package:eol/constant/link.dart';
import 'package:eol/login/sign/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formState = GlobalKey();
  final Crud crud = Crud();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    if (formState.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        var response = await crud.postRequest(
          linkLogin,
          {
            "email": email.text,
            "password": password.text,
          },
        );

        setState(() {
          isLoading = false;
        });

        if (response != null && response["status"] == "success") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt("id", response['data']['id']);
          await prefs.setString("username", response['data']['username']);
          await prefs.setString("email", response['data']['email']);
          if (!mounted) return;
          Navigator.of(context)
              .pushNamedAndRemoveUntil("choose_department", (route) => false);
        } else {
          if (!mounted) return;

          print('Login failed: $response'); // Log the response for debugging
          AwesomeDialog(
            context: context,
            title: "Alert",
            body: const Text(
                "Email or Password is incorrect or the account does not exist"),
          ).show();
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print('Error during login: $e'); // Log the error for debugging
        AwesomeDialog(
          context: context,
          title: "Error",
          body: const Text("An error occurred. Please try again."),
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Form(
                    key: formState,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('EOL',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: Appfonts.fontfamilymont)),
                        const Text("Welcome back to EOL",
                            style: TextStyle(
                                color: Color(0xFF102C57),
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: Appfonts.fontfamilymont)),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextFormField(
                            validator: (value) {
                              return validinput(value!, 3, 20);
                            },
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF102C57), width: 1.5),
                                  borderRadius: BorderRadius.circular(50)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(50)),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              label: const Text(
                                "Email",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextFormField(
                            validator: (value) {
                              return validinput(value!, 3, 10);
                            },
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.key,
                                color: Colors.black,
                              ),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF102C57), width: 1.5),
                                  borderRadius: BorderRadius.circular(50)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(50)),
                              label: const Text("Password",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  const Color(0xFF102C57)),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            onPressed: () async {
                              await login();
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 253, 251, 251)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const sign_in()));
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: Color(0xFF102C57),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

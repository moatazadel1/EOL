import 'package:eol/constant/link.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:eol/core/widgets/validators.dart';
import 'Subjects/utils/app_colors.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _messageController;

  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _messageFocusNode;

  late final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _messageController = TextEditingController();

    _emailFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    _messageFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _messageController.dispose();

    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('id');

      if (userId == null) {
        setState(() {
          _isLoading = false;
        });
        // Handle the case where user ID is not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User ID not found. Please log in again.')),
        );
        return;
      }

      try {
        var response = await http.post(
          Uri.parse(linkContactUs),
          body: {
            'first_name': _nameController.text,
            'email': _emailController.text,
            'massege': _messageController.text,
            'id': userId.toString(), // Convert userId to String
          },
        );

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          if (responseBody['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Message sent successfully!')),
            );
            _nameController.clear();
            _emailController.clear();
            _messageController.clear();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to send message.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Server error. Please try again later.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_sharp)),
                    Spacer(),
                    Text(
                      "Eol",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Center(
                  child: Text(
                    "Contact us",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomContactTextFormField(
                                controller: _nameController,
                                focusNode: _nameFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  return Validators.displayNamevalidator(
                                    value,
                                  );
                                },
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_emailFocusNode);
                                },
                                hintText: "Full Name",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomContactTextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            return Validators.emailValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(_messageFocusNode);
                          },
                          hintText: "Email Address",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomContactTextFormField(
                          controller: _messageController,
                          keyboardType: TextInputType.text,
                          focusNode: _messageFocusNode,
                          validator: (value) {
                            return Validators.messageValidator(value);
                          },
                          hintText: "Message",
                          isMessage: true,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : buildSendButton())
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSendButton() {
    return GestureDetector(
      onTap: _sendMessage,
      child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.yellow, borderRadius: BorderRadius.circular(14)),
          child: Text(
            "Send",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
    );
  }
}

class CustomContactTextFormField extends StatelessWidget {
  const CustomContactTextFormField(
      {super.key,
      required this.hintText,
      this.isMessage = false,
      this.controller,
      this.focusNode,
      this.keyboardType,
      this.validator,
      this.textInputAction,
      this.onFieldSubmitted,
      this.contentPadding,
      this.fillColor});
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;

  final String hintText;
  final bool isMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      cursorColor: Colors.white,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 18, color: Colors.grey, fontWeight: FontWeight.normal),
        contentPadding: isMessage
            ? const EdgeInsets.symmetric(horizontal: 14, vertical: 98)
            : const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        fillColor: AppColors.yellow,
        filled: true,
        border: getBorderSyle(),
        enabledBorder: getBorderSyle(),
        focusedBorder: getBorderSyle(),
      ),
      validator: validator,
      onFieldSubmitted: (value) {
        onFieldSubmitted;
      },
    );
  }
}

InputBorder getBorderSyle() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: AppColors.yellow,
      ));
}

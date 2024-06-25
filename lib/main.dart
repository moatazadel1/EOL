import 'package:eol/chooseyourplan_and_ask/ASK/ASK_PDF_URL.dart';
import 'package:eol/chooseyourplan_and_ask/ASK/chat_pdf.dart';
import 'package:eol/chooseyourplan_and_ask/chooseplan/choice.dart';
import 'package:eol/chooseyourplan_and_ask/chooseyourplan_and_ask.dart';
import 'package:eol/core/localization/language_translation.dart';
import 'package:eol/departement/choose_department.dart';
import 'package:eol/homes/home_literary.dart';
import 'package:eol/homes/home_mathematics.dart';
import 'package:eol/homes/home_scientific.dart';
import 'package:eol/login/sign/login.dart';
import 'package:eol/plan/note/addnote.dart';
import 'package:eol/plan/note/editenote.dart';
import 'package:eol/services/service_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/community/views/community_view.dart';

late SharedPreferences sharepref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharepref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        fallbackLocale: ServiceInitializer.locale,
        translations: LanguageTranslation(),
        initialRoute:
            sharepref.getInt("id") == null ? "login" : "choose_department",
        // "home_literary",
        routes: {
          "addnote": (context) => const AddNote(),
          "editenote": (context) => const EditNote(),
          "chooseplan_and_ask": (context) => const ChoicePlanAsk(),
          "login": (context) => const Login(),
          "chooseplan": (context) => ChoicePlan(),
          "chatpdf": (context) => const ChatPage1(),
          "choose_department": (context) => const ChooseDepartment(),
          "home_scientific": (context) => HomeScientific(),
          "home_mathematics": (context) => HomeMathematics(),
          "home_literary": (context) => HomeLiterary(),
          "AskPage": (context) => const Ask_Page(),
          "community": (context) => const CommunityView(),
        });
  }
}

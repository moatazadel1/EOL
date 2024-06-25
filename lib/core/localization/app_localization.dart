import 'dart:io';

import 'package:eol/core/local_data/shared_preferences_services.dart';
import 'package:eol/services/dependency_injection_service.dart';
import 'package:eol/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LanguageType { arabic, english }

const String arabic = "ar";
const String english = "en";

extension LanguageTypeExtension on LanguageType {
  String getLanguageValue() {
    switch (this) {
      case LanguageType.arabic:
        return arabic;
      case LanguageType.english:
        return english;
    }
  }
}

abstract class BaseAppLocalizations {
  changeLocale({String? languageCode});

  bool isArabic();

  bool isEnglish();

  String getLanguageCode();

  Future<Locale> getUserStoredLocale();

  Future setUserStoredLocale(Locale locale);
}

class AppLocalizations implements BaseAppLocalizations {
  static String defaultLocal = Platform.localeName.contains('ar')
      ? LanguageType.arabic.getLanguageValue()
      : LanguageType.english.getLanguageValue();
  static String currentSelectedLanguage =
      LanguageType.english.getLanguageValue();

  /// Change language for the current application
  /// Save current application language in device local storage so that even if app terminated/restarted, the language doesn't change
  @override
  changeLocale({String? languageCode}) {
    languageCode == null
        ? Get.updateLocale(isArabic()
            ? Locale(LanguageType.english.getLanguageValue())
            : Locale(LanguageType.arabic.getLanguageValue()))
        : Get.updateLocale(Locale(languageCode));
    setUserStoredLocale(Get.locale!);
  }

  /// Check if current application language is Arabic
  @override
  bool isArabic() {
    return Get.locale?.languageCode.toString() ==
        LanguageType.arabic.getLanguageValue();
  }

  /// Check if current application language is English
  @override
  bool isEnglish() {
    return Get.locale?.languageCode.toString() ==
        LanguageType.english.getLanguageValue();
  }

  /// YOU CAN USE THIS IN API CALLER TO SEND REQUEST BY LANGUAGE
  @override
  String getLanguageCode() {
    return Get.locale?.languageCode ?? defaultLocal;
  }

  ///Fetch stored language from device local storage for user app
  ///If there is no stored language then arabic will be used as default
  @override
  Future<Locale> getUserStoredLocale() async {
    String locale = await sl<SharedPreferencesServices>().getData(
            key: AppConstants.userStoredLocale, dataType: DataType.string) ??
        defaultLocal;
    if (locale.contains(LanguageType.english.getLanguageValue())) {
      return Locale(LanguageType.english.getLanguageValue());
    } else {
      return Locale(LanguageType.arabic.getLanguageValue());
    }
  }

  /// Save user application language in device local storage so that even if app terminated/restarted, the language doesn't change
  @override
  Future setUserStoredLocale(Locale locale) async {
    await sl<SharedPreferencesServices>().saveData(
      key: AppConstants.userStoredLocale,
      value: locale.toString(),
      dataType: DataType.string,
    );
  }
}

String tr(String key) {
  return key.tr;
}

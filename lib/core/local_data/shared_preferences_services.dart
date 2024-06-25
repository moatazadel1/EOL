import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

enum DataType {
  string,
  int,
  double,
  bool,
  stringList,
}

abstract class SharedPreferencesServices {
  Future saveData({
    required String key,
    required dynamic value,
    required DataType dataType,
  });

  Future<dynamic> getData({
    required String key,
    required DataType dataType,
  });

  Future<bool> clearAll();

  Future<bool> clearKey({required key});

  bool checkByKey({required key});
}

class SharedPreferencesServicesImpl implements SharedPreferencesServices {
  late final SharedPreferences prefs;

  SharedPreferencesServicesImpl({required this.prefs});

  @override
  Future saveData({
    required String key,
    required dynamic value,
    required DataType dataType,
  }) async {
    await _getSharedPrefsMethod(restoring: false, dataType: dataType)(
      key,
      value,
    );
  }

  @override
  Future<dynamic> getData({
    required String key,
    required DataType dataType,
  }) async {
    return await _getSharedPrefsMethod(restoring: true, dataType: dataType)(
        key);
  }

  @override
  Future<bool> clearAll() async {
    return await prefs.clear();
  }

  @override
  Future<bool> clearKey({required key}) async {
    return await prefs.remove(key);
  }

  _getSharedPrefsMethod({
    required bool restoring,
    required DataType dataType,
  }) {
    switch (dataType) {
      case DataType.bool:
        {
          return restoring ? prefs.getBool : prefs.setBool;
        }
      case DataType.string:
        {
          return restoring ? prefs.getString : prefs.setString;
        }
      case DataType.double:
        {
          return restoring ? prefs.getDouble : prefs.setDouble;
        }
      case DataType.int:
        {
          return restoring ? prefs.getInt : prefs.setInt;
        }
      case DataType.stringList:
        {
          return restoring ? prefs.getStringList : prefs.setStringList;
        }
      default:
        {
          throw 'No method was selected, method is required';
        }
    }
  }

  @override
  bool checkByKey({required key}) {
    return prefs.containsKey(key);
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/extensions/either_extension.dart';
import 'package:weather_app/constans/env.dart';

@lazySingleton
class Storage {
  static final Logger logger = new Logger("Storage");
  SharedPreferences sharedPreferences;

  Storage(this.sharedPreferences);

  Future<Null> deleteAll() async {
    var envData = getEnvData();
    sharedPreferences.clear();

    setEnvData(envData!);
    logger.info("Setting back custom EnvData to $envData");
  }

  EnvData? getEnvData() {
    var a = sharedPreferences.getString("env_data");
    return a!=null ? EnvData.fromJson(jsonDecode(a)) : null;
  }

  Future<void> setEnvData(EnvData envData) async {
    saveObject("env_data", envData);
  }

  DateTime? getDateTime(String key) {
    var value = sharedPreferences.get(key);
    return value != null ? DateTime.parse(value.toString()) : null;
  }

  Future<void> setDateTime(String key, DateTime date) async {
    sharedPreferences.setString(key, date.toIso8601String());
    return;
  }

  Future<Either<Exception, T>> saveObject<T>(String key, T value) async {
    var either = await saveString(key, json.encode(value));
    return either.fold((l) => Left(l), (r) => Right(value));
  }

  Future<Either<Exception, String?>> saveString<T>(
      String key, String? value) async {
    return Task<String>(() async {
      await sharedPreferences.setString(key, value!);
      return value;
    }).attempt().mapLeftToException<String>().run();
  }

  @deprecated
  String? getFlavor() {
    return sharedPreferences.getString("flavor");
  }

  @deprecated
  void removeFlavor() {
    if (sharedPreferences.containsKey("flavor")) {
      sharedPreferences.remove("flavor");
    }
  }
}

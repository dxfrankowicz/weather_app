import 'package:flutter/foundation.dart' as foundation;
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/api/di/di.dart';
import 'package:weather_app/constans/urls.dart';
import 'package:weather_app/storage/storage.dart';

part 'env.g.dart';

final Env env = getIt<Env>();
final Storage storage = getIt<Storage>();

@injectable
@preResolve
class Env {
  EnvData _env;

  Storage _storage;

  Env(this._env, this._storage);

  EnvData get data => _env;

  final bool IS_RELEASE = foundation.kReleaseMode;
  final bool IS_DEBUG = !foundation.kReleaseMode;

  @factoryMethod
  static Future<Env> create(Storage storage) async {
    bool devFromFlavor = optionOf(storage.getFlavor()).map((a) {
      return a != "Flavor.RELEASE";
    }).getOrElse(() => false);
    storage.removeFlavor();
    if (devFromFlavor) {
      await storage.setEnvData(DEV);
    }

    var envData =
        storage.getEnvData() ?? (foundation.kReleaseMode ? PROD : DEV);
    return Env(envData, storage);
  }

  Future<EnvData> changeEnvDataModifying(Function(EnvData) modifier) async {
    modifier.call(data);
    await _storage.setEnvData(data);
    _env = data;

    return _env;
  }

  static final EnvData DEV = EnvData(
    debug: true,
    debugApiClient: true,
    loggingEnabled: true,
    devicePreview: false,
    apiBaseUrl: UrlConstants.URL,
  );

  static final EnvData PROD = EnvData(
    debug: false,
    debugApiClient: false,
    loggingEnabled: false,
    devicePreview: false,
    apiBaseUrl: UrlConstants.URL,
  );
}

@JsonSerializable()
class EnvData {
  bool debug;
  bool debugApiClient;
  bool loggingEnabled;
  bool devicePreview;
  String apiBaseUrl;

  String get apiUrl => apiBaseUrl + "/api";

  String get baseUrl => apiBaseUrl;

  EnvData({
    this.debug = false,
    this.debugApiClient = false,
    this.loggingEnabled = false,
    this.devicePreview = false,
    required this.apiBaseUrl,
  });

  factory EnvData.fromJson(Map<String, dynamic> json) =>
      _$EnvDataFromJson(json);

  Map<String, dynamic> toJson() => _$EnvDataToJson(this);


}

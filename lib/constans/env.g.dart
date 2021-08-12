// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnvData _$EnvDataFromJson(Map<String, dynamic> json) {
  return EnvData(
    debug: json['debug'] as bool,
    debugApiClient: json['debugApiClient'] as bool,
    loggingEnabled: json['loggingEnabled'] as bool,
    devicePreview: json['devicePreview'] as bool,
    apiBaseUrl: json['apiBaseUrl'] as String,
  );
}

Map<String, dynamic> _$EnvDataToJson(EnvData instance) => <String, dynamic>{
      'debug': instance.debug,
      'debugApiClient': instance.debugApiClient,
      'loggingEnabled': instance.loggingEnabled,
      'devicePreview': instance.devicePreview,
      'apiBaseUrl': instance.apiBaseUrl,
    };

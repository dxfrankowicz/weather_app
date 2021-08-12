// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return LocationModel(
    (json['consolidated_weather'] as List<dynamic>)
        .map((e) => ConsolidatedWeather.fromJson(e as Map<String, dynamic>))
        .toList(),
    DateTime.parse(json['time'] as String),
    DateTime.parse(json['sun_rise'] as String),
    DateTime.parse(json['sun_set'] as String),
    json['timezone_name'] as String,
    ParentModel.fromJson(json['parent'] as Map<String, dynamic>),
    json['title'] as String,
    json['location_type'] as String,
    json['woeid'] as int,
    json['latt_long'] as String,
    json['timezone'] as String,
  );
}

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'consolidated_weather': instance.consolidatedWeather,
      'time': instance.time.toIso8601String(),
      'sun_rise': instance.sunRise.toIso8601String(),
      'sun_set': instance.sunSet.toIso8601String(),
      'timezone_name': instance.timezoneName,
      'parent': instance.parent,
      'title': instance.title,
      'location_type': instance.locationType,
      'woeid': instance.woeid,
      'latt_long': instance.lattLong,
      'timezone': instance.timezone,
    };

ParentModel _$ParentModelFromJson(Map<String, dynamic> json) {
  return ParentModel(
    json['title'] as String,
    json['location_type'] as String,
    json['woeid'] as int,
    json['latt_long'] as String,
  );
}

Map<String, dynamic> _$ParentModelToJson(ParentModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'location_type': instance.locationType,
      'woeid': instance.woeid,
      'latt_long': instance.lattLong,
    };

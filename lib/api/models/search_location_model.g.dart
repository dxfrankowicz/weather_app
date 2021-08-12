// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchLocationModel _$SearchLocationModelFromJson(Map<String, dynamic> json) {
  return SearchLocationModel(
    json['title'] as String,
    json['location_type'] as String,
    json['woeid'] as int,
    json['latt_long'] as String,
    json['distance'] as int,
  );
}

Map<String, dynamic> _$SearchLocationModelToJson(
        SearchLocationModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'location_type': instance.locationType,
      'woeid': instance.woeid,
      'latt_long': instance.lattLong,
      'distance': instance.distance,
    };

import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/api/models/consolidated_weather.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  @JsonKey(name: "consolidated_weather")
  List<ConsolidatedWeather> consolidatedWeather;
  DateTime time;
  @JsonKey(name: "sun_rise")
  DateTime sunRise;
  @JsonKey(name: "sun_set")
  DateTime sunSet;
  @JsonKey(name: "timezone_name")
  String timezoneName;
  ParentModel parent;
  String title;
  @JsonKey(name: "location_type")
  String locationType;
  int woeid;
  @JsonKey(name: "latt_long")
  String lattLong;
  String timezone;

  LocationModel(
      this.consolidatedWeather,
      this.time,
      this.sunRise,
      this.sunSet,
      this.timezoneName,
      this.parent,
      this.title,
      this.locationType,
      this.woeid,
      this.lattLong,
      this.timezone);

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}

@JsonSerializable()
class ParentModel {
  String title;
  @JsonKey(name: "location_type")
  String locationType;
  int woeid;
  @JsonKey(name: "latt_long")
  String lattLong;

  ParentModel(this.title, this.locationType, this.woeid, this.lattLong);

  factory ParentModel.fromJson(Map<String, dynamic> json) =>
      _$ParentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParentModelToJson(this);
}

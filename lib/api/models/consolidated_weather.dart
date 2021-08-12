import 'package:json_annotation/json_annotation.dart';

part 'consolidated_weather.g.dart';

@JsonSerializable()
class ConsolidatedWeather {
  int id;
  @JsonKey(name: "weather_state_name")
  String weatherStateName;
  @JsonKey(name: "weather_state_abbr")
  String weatherStateAbbr;
  @JsonKey(name: "wind_direction_compass")
  String windDirectionCompass;
  DateTime created;
  @JsonKey(name: "applicable_date")
  DateTime applicableDate;
  @JsonKey(name: "min_temp")
  double minTemp;
  @JsonKey(name: "max_temp")
  double maxTemp;
  @JsonKey(name: "the_temp")
  double theTemp;
  @JsonKey(name: "wind_speed")
  double windSpeed;
  @JsonKey(name: "wind_direction")
  double windDirection;
  @JsonKey(name: "air_pressure")
  double airPressure;
  double humidity;
  double visibility;
  int predictability;

  ConsolidatedWeather(
      this.id,
      this.weatherStateName,
      this.weatherStateAbbr,
      this.windDirectionCompass,
      this.created,
      this.applicableDate,
      this.minTemp,
      this.maxTemp,
      this.theTemp,
      this.windSpeed,
      this.windDirection,
      this.airPressure,
      this.humidity,
      this.visibility,
      this.predictability);

  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
      _$ConsolidatedWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$ConsolidatedWeatherToJson(this);
}

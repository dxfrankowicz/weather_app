import 'package:json_annotation/json_annotation.dart';

part 'search_location_model.g.dart';

@JsonSerializable()
class SearchLocationModel {
  String title;
  @JsonKey(name: "location_type")
  String locationType;
  int woeid;
  @JsonKey(name: "latt_long")
  String lattLong;
  int distance;

  double? get latitude => double.tryParse(lattLong.split(',').first);

  double? get longitude => double.tryParse(lattLong.split(',').last);

  SearchLocationModel(
      this.title, this.locationType, this.woeid, this.lattLong, this.distance);

  factory SearchLocationModel.fromJson(Map<String, dynamic> json) =>
      _$SearchLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchLocationModelToJson(this);
}

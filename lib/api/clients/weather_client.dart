import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/api/models/location_model.dart';
import 'package:weather_app/api/models/search_location_model.dart';

part 'weather_client.g.dart';

@RestApi()
@lazySingleton
abstract class WeatherClient {
  @factoryMethod
  static WeatherClient create(Dio dio) => _WeatherClient(dio);

  @GET("/location/search/")
  Future<List<SearchLocationModel>> searchLocationByName(
      @Query("query") String location);

  @GET("/location/search/")
  Future<List<SearchLocationModel>> searchLocationByLatLong(
      @Query("lattlong") String lattlong);

  @GET("/location/{woeid}")
  Future<LocationModel> getLocation(
      @Path("woeid") int woeid);

  @GET("/location/{woeid}/{date}")
  Future<LocationModel> getLocationDay(
      @Path("woeid") int woeid,  @Path("date") String date);
}

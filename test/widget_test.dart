// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/api/clients/weather_client.dart';
import 'package:weather_app/api/di/di.dart' as di;
import 'package:weather_app/api/models/consolidated_weather.dart';
import 'package:weather_app/api/models/location_model.dart';
import 'package:get_it/get_it.dart';

void main() {
  group("WeatherClient test", () {
    test("Function di.init() completes without exception", () {
      expect(di.init(), isA<Future<GetIt>>());
    });

    var weatherClient;
    test('Returns WeatherClient', () async {
      weatherClient = di.getIt<WeatherClient>();
      expect(weatherClient, isA<WeatherClient>());
    });

    test('Get location returns LocationModel', () async {
      var rsp = await weatherClient.getLocation(523920);
      expect(rsp, isA<LocationModel>());
    });

    var rspLocationModel;
    test('Returned LocationModel for woeid 523920 contains title Warsaw', () async {
      rspLocationModel = await weatherClient.getLocation(523920);
      expect(rspLocationModel.title, "Warsaw");
    });

    test('Returned LocationModel contains ConsolidatedWeather is list with length == 6 ', () {
      var x = rspLocationModel as LocationModel;
      expect(x.consolidatedWeather, isA<List<ConsolidatedWeather>>());
      expect(x.consolidatedWeather.length, 6);
    });

    test('Get location returns Exception if calling not existing woeid',
        () async {
      expect(weatherClient.getLocation(0), throwsException);
    });
  });
}

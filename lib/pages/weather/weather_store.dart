import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/api/clients/weather_client.dart';
import 'package:weather_app/api/di/di.dart';
import 'package:weather_app/api/models/consolidated_weather.dart';
import 'package:weather_app/api/models/location_model.dart';
import 'package:weather_app/utils/log/log.dart';

part 'weather_store.g.dart';

@singleton
class WeatherStore extends _WeatherStoreBase with _$WeatherStore {
  WeatherStore() : super();
}

abstract class _WeatherStoreBase with Store {
  final WeatherClient weatherClient = getIt<WeatherClient>();
  final Logger logger = new Logger("WeatherStore");

  @observable
  int? woeid;

  @observable
  TempUnit tempUnit = TempUnit.C;

  @observable
  int selectedIndex = 0;

  @observable
  LocationModel? location;

  @observable
  ObservableFuture<LocationModel>? weatherFuture;

  @observable
  Exception? lastException;

  @computed
  ConsolidatedWeather? get getCurrentDayWeather =>
      weatherFuture?.value?.consolidatedWeather.elementAt(selectedIndex);

  @computed
  bool get isLoadingWeather => weatherFuture?.status == FutureStatus.pending;

  @computed
  bool get hasError =>
      weatherFuture?.status == FutureStatus.rejected || lastException != null;

  _WeatherStoreBase();

  @action
  void init(int woeid) {
    this.woeid = woeid;
    fetchWeather();
  }

  @action
  void setIndex(int index) {
    this.selectedIndex = index;
  }

  @action
  void setTempUnit(TempUnit tempUnit) {
    this.tempUnit = tempUnit;
  }

  @action
  Future<void> fetchWeather() async {
    log.info("Fetching weather by woeid: $woeid");

    try {
      weatherFuture = weatherClient.getLocation(woeid!).asObservable();
      location = await weatherFuture;
    } on DioError catch (onError) {
      if (onError.message
          .toLowerCase()
          .contains("SocketException".toLowerCase()))
        lastException = SocketException("");
      else
        lastException = onError;
      log.error("Error fetching weather by woeid: $woeid: $onError");
    } catch (onError) {
      lastException = onError as Exception?;
      log.error("Error fetching weather by woeid: $woeid: $onError");
      throw onError;
    }
  }

  @action
  void retry() {
    lastException = null;
    fetchWeather();
  }

  @action
  void resetState() {
    lastException = null;
    location = null;
    weatherFuture = null;
    selectedIndex = 0;
    woeid = null;
  }
}

enum TempUnit { C, F }

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/api/clients/weather_client.dart';
import 'package:weather_app/api/di/di.dart';
import 'package:weather_app/api/models/consolidated_weather.dart';
import 'package:weather_app/api/models/location_model.dart';
import 'package:weather_app/api/models/search_location_model.dart';
import 'package:weather_app/utils/location_utils.dart';
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
  String? locationName;

  @observable
  TempUnit tempUnit = TempUnit.C;

  @observable
  int selectedIndex = 0;

  @observable
  LocationModel? location;

  @observable
  ObservableFuture<LocationModel>? weatherFuture;

  @observable
  ObservableFuture<List<SearchLocationModel>>? locationByLatLongFuture;

  @observable
  dynamic lastException;

  @observable
  bool isLoadingLocalization = false;

  @computed
  ConsolidatedWeather? get getCurrentDayWeather =>
      weatherFuture?.value?.consolidatedWeather.elementAt(selectedIndex);

  @computed
  bool get isLoading =>
      locationByLatLongFuture?.status == FutureStatus.pending ||
      weatherFuture?.status == FutureStatus.pending ||
      isLoadingLocalization;

  @computed
  bool get hasError =>
      weatherFuture?.status == FutureStatus.rejected || lastException != null;

  _WeatherStoreBase();

  @action
  void getLocationAndInit() {
    isLoadingLocalization = true;
    LocationUtils.determinePosition().then((location) {
      if (location != null)
        init(latLong: "${location.latitude},${location.longitude}");
      else {
        //Hardcoded city when no permission
        locationName = "Warsaw";
        init(woeid: 523920);
      }
      isLoadingLocalization = false;
    });
  }

  @action
  Future<void> init(
      {int? woeid, String? latLong, SearchLocationModel? locationModel}) async {
    if (latLong != null) {
      locationByLatLongFuture =
          weatherClient.searchLocationByLatLong(latLong).asObservable();
      var x = await locationByLatLongFuture;
      setLocationName(x!.first.title);
      this.woeid = x.first.woeid;
    } else if (locationModel != null) {
      setLocationName(locationModel.title);
      this.woeid = locationModel.woeid;
    } else
      this.woeid = woeid;
    fetchWeather();
  }

  @action
  void setLocationName(String l) {
    this.locationName = l;
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
      lastException = onError;
      log.error("Error fetching weather by woeid: $woeid: $onError");
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

import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_app/api/clients/weather_client.dart';
import 'package:weather_app/api/di/di.dart';
import 'package:weather_app/api/models/search_location_model.dart';
import 'package:weather_app/utils/log/log.dart';

part 'weather_search_store.g.dart';

@singleton
class WeatherSearchStore extends _WeatherSearchStoreBase
    with _$WeatherSearchStore {
  WeatherSearchStore() : super();
}

abstract class _WeatherSearchStoreBase with Store {
  final WeatherClient weatherClient = getIt<WeatherClient>();

  @observable
  ObservableFuture<List<SearchLocationModel>> searchFuture =
      ObservableFuture.value(List.of([]));

  @observable
  Exception? lastException;

  @computed
  bool get isLoading => searchFuture.status == FutureStatus.pending;

  @computed
  bool get hasError =>
      searchFuture.status == FutureStatus.rejected || lastException != null;

  Timer? searchOnStoppedTyping;
  List<SearchLocationModel> locations = List.of([]);

  @action
  void searchLocations(String s) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }
    searchOnStoppedTyping = new Timer(duration, () => fetchLocations(s));
  }

  @action
  Future<void> fetchLocations(String location) async {
    log.info("Searching locations by: $location");

    try {
      searchFuture = weatherClient.searchLocationByName(location).asObservable();
      locations = await searchFuture;
    } on DioError catch (onError) {
      if (onError.message
          .toLowerCase()
          .contains("SocketException".toLowerCase()))
        lastException = SocketException("");
      else
        lastException = onError;
      log.error("Error Searching locations by: $location: $onError");
    } catch (onError,s) {
      lastException = onError as Exception?;
      log.error("Error Searching locations by: $location: $onError");
      log.error(s);
    }
  }

  @action
  void resetState() {
    lastException = null;
    locations = [];
  }
}

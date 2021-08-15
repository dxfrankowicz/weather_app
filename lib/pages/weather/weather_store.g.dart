// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WeatherStore on _WeatherStoreBase, Store {
  Computed<ConsolidatedWeather?>? _$getCurrentDayWeatherComputed;

  @override
  ConsolidatedWeather? get getCurrentDayWeather =>
      (_$getCurrentDayWeatherComputed ??= Computed<ConsolidatedWeather?>(
              () => super.getCurrentDayWeather,
              name: '_WeatherStoreBase.getCurrentDayWeather'))
          .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_WeatherStoreBase.isLoading'))
          .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_WeatherStoreBase.hasError'))
          .value;

  final _$woeidAtom = Atom(name: '_WeatherStoreBase.woeid');

  @override
  int? get woeid {
    _$woeidAtom.reportRead();
    return super.woeid;
  }

  @override
  set woeid(int? value) {
    _$woeidAtom.reportWrite(value, super.woeid, () {
      super.woeid = value;
    });
  }

  final _$locationNameAtom = Atom(name: '_WeatherStoreBase.locationName');

  @override
  String? get locationName {
    _$locationNameAtom.reportRead();
    return super.locationName;
  }

  @override
  set locationName(String? value) {
    _$locationNameAtom.reportWrite(value, super.locationName, () {
      super.locationName = value;
    });
  }

  final _$tempUnitAtom = Atom(name: '_WeatherStoreBase.tempUnit');

  @override
  TempUnit get tempUnit {
    _$tempUnitAtom.reportRead();
    return super.tempUnit;
  }

  @override
  set tempUnit(TempUnit value) {
    _$tempUnitAtom.reportWrite(value, super.tempUnit, () {
      super.tempUnit = value;
    });
  }

  final _$selectedIndexAtom = Atom(name: '_WeatherStoreBase.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  final _$locationAtom = Atom(name: '_WeatherStoreBase.location');

  @override
  LocationModel? get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(LocationModel? value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  final _$weatherFutureAtom = Atom(name: '_WeatherStoreBase.weatherFuture');

  @override
  ObservableFuture<LocationModel>? get weatherFuture {
    _$weatherFutureAtom.reportRead();
    return super.weatherFuture;
  }

  @override
  set weatherFuture(ObservableFuture<LocationModel>? value) {
    _$weatherFutureAtom.reportWrite(value, super.weatherFuture, () {
      super.weatherFuture = value;
    });
  }

  final _$locationByLatLongFutureAtom =
      Atom(name: '_WeatherStoreBase.locationByLatLongFuture');

  @override
  ObservableFuture<List<SearchLocationModel>>? get locationByLatLongFuture {
    _$locationByLatLongFutureAtom.reportRead();
    return super.locationByLatLongFuture;
  }

  @override
  set locationByLatLongFuture(
      ObservableFuture<List<SearchLocationModel>>? value) {
    _$locationByLatLongFutureAtom
        .reportWrite(value, super.locationByLatLongFuture, () {
      super.locationByLatLongFuture = value;
    });
  }

  final _$lastExceptionAtom = Atom(name: '_WeatherStoreBase.lastException');

  @override
  dynamic get lastException {
    _$lastExceptionAtom.reportRead();
    return super.lastException;
  }

  @override
  set lastException(dynamic value) {
    _$lastExceptionAtom.reportWrite(value, super.lastException, () {
      super.lastException = value;
    });
  }

  final _$isLoadingLocalizationAtom =
      Atom(name: '_WeatherStoreBase.isLoadingLocalization');

  @override
  bool get isLoadingLocalization {
    _$isLoadingLocalizationAtom.reportRead();
    return super.isLoadingLocalization;
  }

  @override
  set isLoadingLocalization(bool value) {
    _$isLoadingLocalizationAtom.reportWrite(value, super.isLoadingLocalization,
        () {
      super.isLoadingLocalization = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_WeatherStoreBase.init');

  @override
  Future<void> init(
      {int? woeid, String? latLong, SearchLocationModel? locationModel}) {
    return _$initAsyncAction.run(() => super
        .init(woeid: woeid, latLong: latLong, locationModel: locationModel));
  }

  final _$fetchWeatherAsyncAction =
      AsyncAction('_WeatherStoreBase.fetchWeather');

  @override
  Future<void> fetchWeather() {
    return _$fetchWeatherAsyncAction.run(() => super.fetchWeather());
  }

  final _$_WeatherStoreBaseActionController =
      ActionController(name: '_WeatherStoreBase');

  @override
  void getLocationAndInit() {
    final _$actionInfo = _$_WeatherStoreBaseActionController.startAction(
        name: '_WeatherStoreBase.getLocationAndInit');
    try {
      return super.getLocationAndInit();
    } finally {
      _$_WeatherStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIndex(int index) {
    final _$actionInfo = _$_WeatherStoreBaseActionController.startAction(
        name: '_WeatherStoreBase.setIndex');
    try {
      return super.setIndex(index);
    } finally {
      _$_WeatherStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTempUnit(TempUnit tempUnit) {
    final _$actionInfo = _$_WeatherStoreBaseActionController.startAction(
        name: '_WeatherStoreBase.setTempUnit');
    try {
      return super.setTempUnit(tempUnit);
    } finally {
      _$_WeatherStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void retry() {
    final _$actionInfo = _$_WeatherStoreBaseActionController.startAction(
        name: '_WeatherStoreBase.retry');
    try {
      return super.retry();
    } finally {
      _$_WeatherStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_WeatherStoreBaseActionController.startAction(
        name: '_WeatherStoreBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_WeatherStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
woeid: ${woeid},
locationName: ${locationName},
tempUnit: ${tempUnit},
selectedIndex: ${selectedIndex},
location: ${location},
weatherFuture: ${weatherFuture},
locationByLatLongFuture: ${locationByLatLongFuture},
lastException: ${lastException},
isLoadingLocalization: ${isLoadingLocalization},
getCurrentDayWeather: ${getCurrentDayWeather},
isLoading: ${isLoading},
hasError: ${hasError}
    ''';
  }
}

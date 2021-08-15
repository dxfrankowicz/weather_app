// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WeatherSearchStore on _WeatherSearchStoreBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_WeatherSearchStoreBase.isLoading'))
          .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_WeatherSearchStoreBase.hasError'))
          .value;

  final _$searchFutureAtom = Atom(name: '_WeatherSearchStoreBase.searchFuture');

  @override
  ObservableFuture<List<SearchLocationModel>> get searchFuture {
    _$searchFutureAtom.reportRead();
    return super.searchFuture;
  }

  @override
  set searchFuture(ObservableFuture<List<SearchLocationModel>> value) {
    _$searchFutureAtom.reportWrite(value, super.searchFuture, () {
      super.searchFuture = value;
    });
  }

  final _$lastExceptionAtom =
      Atom(name: '_WeatherSearchStoreBase.lastException');

  @override
  Exception? get lastException {
    _$lastExceptionAtom.reportRead();
    return super.lastException;
  }

  @override
  set lastException(Exception? value) {
    _$lastExceptionAtom.reportWrite(value, super.lastException, () {
      super.lastException = value;
    });
  }

  final _$fetchLocationsAsyncAction =
      AsyncAction('_WeatherSearchStoreBase.fetchLocations');

  @override
  Future<void> fetchLocations(String location) {
    return _$fetchLocationsAsyncAction
        .run(() => super.fetchLocations(location));
  }

  final _$_WeatherSearchStoreBaseActionController =
      ActionController(name: '_WeatherSearchStoreBase');

  @override
  void searchLocations(String s) {
    final _$actionInfo = _$_WeatherSearchStoreBaseActionController.startAction(
        name: '_WeatherSearchStoreBase.searchLocations');
    try {
      return super.searchLocations(s);
    } finally {
      _$_WeatherSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetState() {
    final _$actionInfo = _$_WeatherSearchStoreBaseActionController.startAction(
        name: '_WeatherSearchStoreBase.resetState');
    try {
      return super.resetState();
    } finally {
      _$_WeatherSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchFuture: ${searchFuture},
lastException: ${lastException},
isLoading: ${isLoading},
hasError: ${hasError}
    ''';
  }
}

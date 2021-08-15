// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import '../../constans/env.dart' as _i6;
import '../../pages/weather/weather_search_store.dart' as _i11;
import '../../pages/weather/weather_store.dart' as _i12;
import '../../storage/storage.dart' as _i5;
import '../../utils/log/log_it.dart' as _i8;
import '../../utils/logconsole/in_memory_logs.dart' as _i3;
import '../clients/weather_client.dart' as _i10;
import 'dio_di.dart' as _i15;
import 'logger_di.dart' as _i14;
import 'shared_preferences_di.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final sharedPreferencesDi = _$SharedPreferencesDi();
  final loggerDi = _$LoggerDi();
  final dioDi = _$DioDi();
  gh.lazySingleton<_i3.InMemoryLogs>(() => _i3.InMemoryLogs());
  await gh.factoryAsync<_i4.SharedPreferences>(
      () => sharedPreferencesDi.sharedPreferences,
      preResolve: true);
  gh.lazySingleton<_i5.Storage>(
      () => _i5.Storage(get<_i4.SharedPreferences>()));
  await gh.factoryAsync<_i6.Env>(() => _i6.Env.create(get<_i5.Storage>()),
      preResolve: true);
  gh.lazySingleton<_i7.Logger>(
      () => loggerDi.getLogger(get<_i6.Env>(), get<_i3.InMemoryLogs>()));
  gh.lazySingleton<_i8.LogIt>(() => _i8.LogIt(get<_i7.Logger>()));
  gh.lazySingleton<_i9.Dio>(() =>
      dioDi.dio(get<_i6.Env>(), get<_i3.InMemoryLogs>(), get<_i8.LogIt>()));
  gh.lazySingleton<_i10.WeatherClient>(
      () => _i10.WeatherClient.create(get<_i9.Dio>()));
  gh.singleton<_i11.WeatherSearchStore>(_i11.WeatherSearchStore());
  gh.singleton<_i12.WeatherStore>(_i12.WeatherStore());
  return get;
}

class _$SharedPreferencesDi extends _i13.SharedPreferencesDi {}

class _$LoggerDi extends _i14.LoggerDi {}

class _$DioDi extends _i15.DioDi {}

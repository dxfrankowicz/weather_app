import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app/api/interceptors/api_error_message_interceptor.dart';
import 'package:weather_app/api/interceptors/dio_log_interceptor.dart';
import 'package:weather_app/api/interceptors/internal_server_error_interceptor.dart';
import 'package:weather_app/constans/env.dart';
import 'package:weather_app/utils/log/log_it.dart';
import 'package:weather_app/utils/logconsole/in_memory_logs.dart';

@injectable
@module
abstract class DioDi {
  @lazySingleton
  Dio dio(Env env, InMemoryLogs log, LogIt logIt) {
    var options = BaseOptions(
      baseUrl: env.data.apiUrl,
      connectTimeout: const Duration(minutes: 2).inMilliseconds,
      receiveTimeout: const Duration(minutes: 2).inMilliseconds,
    );
    var dio = Dio(options);
    // dio.interceptors.add(InternalServerErrorInterceptor(logIt));
    // dio.interceptors.add(ApiErrorMessageInterceptor());
    if (env.data.debugApiClient) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: false,
        maxWidth: 3000,
      ));

    //   dio.interceptors.add(DioLogInterceptor(
    //       request: true,
    //       responseBody: true,
    //       requestHeader: true,
    //       logPrint: (v) =>
    //           log.httpLog.add(OutputEvent(Level.info, [v.toString()]))));
    }

    return dio;
  }
}

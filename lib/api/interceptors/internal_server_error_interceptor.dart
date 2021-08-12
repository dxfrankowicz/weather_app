import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_app/api/api_errors/internal_server_api_error.dart';
import 'package:weather_app/utils/log/log_it.dart';
import 'package:weather_app/utils/try.dart';


class InternalServerErrorInterceptor extends Interceptor {
  LogIt _logIt;

  InternalServerErrorInterceptor(this._logIt);

  @override
  Future onError(DioError error, ErrorInterceptorHandler errorInterceptorHandler) async {
    if (error.response != null) {
      if (error.response!.statusCode == 500) {
        Try.toDo(() => _logIt.info(
            "Exception from Server: ${error.requestOptions.uri} ${error.message}; ${error.response!.data ?? ""}"));

        if (error.response != null && error.response!.data != null) {
          var j = error.response!.data;
        }

        return InternalServerApiError(error.requestOptions);
      }
    }

    return null;
  }
}

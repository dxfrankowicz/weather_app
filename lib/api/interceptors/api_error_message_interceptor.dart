import 'package:dio/dio.dart';
import 'package:weather_app/api/api_errors/api_error_message_error.dart';

class ApiErrorMessageInterceptor extends Interceptor {
  @override
  Future onError(
      DioError error, ErrorInterceptorHandler errorInterceptorHandler) async {
    if (error.response != null) {
      var e = ApiErrorMessageError(
          type: error.type,
          errorMessage: error.response!.data["message"],
          requestOptions: error.requestOptions,
          statusCode: error.response!.statusCode!,
          response: error.response,
          error: error);
      if (e.error != null) {
        return e;
      }
    }

    return error;
  }
}

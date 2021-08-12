import 'package:dio/dio.dart';

class InternalServerApiError extends DioError {
  InternalServerApiError(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);
}

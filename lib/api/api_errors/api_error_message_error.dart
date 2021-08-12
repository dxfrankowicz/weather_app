import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

class ApiErrorMessageError extends DioError {
  @JsonKey(name: 'message')
  String errorMessage;

  @JsonKey(name: 'status_code')
  int statusCode;

  @override
  RequestOptions requestOptions;

  @override
  Response? response;

  @override
  DioErrorType type;

  @override
  dynamic error;

  ApiErrorMessageError({
    required this.errorMessage,
    required this.statusCode,
    required this.requestOptions,
    this.response,
    required this.type,
    this.error,
  }) : super(
            requestOptions: requestOptions,
            error: error,
            response: response,
            type: type);

  factory ApiErrorMessageError.fromJson(Map<String, dynamic> json) {
    return ApiErrorMessageError(
      errorMessage: json['message'] as String,
      statusCode: json['status_code'] as int,
      type: json['type'],
      requestOptions: json["request_options"],
    );
  }
}

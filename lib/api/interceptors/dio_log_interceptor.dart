import 'package:dio/dio.dart';

class DioLogInterceptor extends Interceptor {
  DioLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = true,
    this.error = true,
    this.logPrint = print,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  /// Log printer; defaults print log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file, for example:
  ///```dart
  ///  var file=File("./log.txt");
  ///  var sink=file.openWrite();
  ///  dio.interceptors.add(LogInterceptor(sb.writeln: sink.writeln));
  ///  ...
  ///  await sink.close();
  ///```
  void Function(Object object) logPrint;

  @override
  Future onRequest(RequestOptions options,
      RequestInterceptorHandler requestInterceptorHandler) async {
    StringBuffer sb = StringBuffer();

    sb.writeln('*** Request ***');
    _printKV('uri', options.uri, sb);

    if (request) {
      _printKV('method', options.method, sb);
      _printKV('responseType', options.responseType, sb);
      _printKV('followRedirects', options.followRedirects, sb);
      _printKV('connectTimeout', options.connectTimeout, sb);
      _printKV('receiveTimeout', options.receiveTimeout, sb);
      _printKV('extra', options.extra, sb);
    }
    if (requestHeader) {
      sb.writeln('headers:');
      options.headers.forEach((key, v) => _printKV(' $key', v, sb));
    }
    if (requestBody) {
      sb.writeln('data:');
      _printAll(options.data, sb);
    }
    sb.writeln('');
    logPrint(sb.toString());
  }

  @override
  Future onError(
      DioError err, ErrorInterceptorHandler errorInterceptorHandler) async {
    if (error) {
      StringBuffer sb = StringBuffer();

      sb.writeln('*** DioError ***:');
      sb.writeln('uri: ${err.requestOptions.uri}');
      sb.writeln('$err');
      if (err.response != null) {
        _printResponse(err.response!, sb);
      }
      sb.writeln('');
      logPrint(sb.toString());
    }
  }

  @override
  Future onResponse(Response response,
      ResponseInterceptorHandler responseInterceptorHandler) async {
    StringBuffer sb = StringBuffer();

    sb.writeln('*** Response ***');
    _printResponse(response, sb);
  }

  void _printResponse(Response response, StringBuffer sb) {
    _printKV('uri', response.requestOptions.uri, sb);
    if (responseHeader) {
      _printKV('statusCode', response.statusCode!, sb);
      if (response.isRedirect == true) {
        _printKV('redirect', response.realUri, sb);
      }
      sb.writeln('headers:');
      response.headers
          .forEach((key, v) => _printKV(' $key', v.join(','), sb));
    }
    if (responseBody) {
      sb.writeln('Response Text:');
      _printAll(response.toString(), sb);
    }
    sb.writeln('');
    logPrint(sb.toString());
  }

  void _printKV(String key, Object v, StringBuffer sb) {
    sb.writeln('$key: $v');
  }

  void _printAll(msg, StringBuffer sb) {
    msg.toString().split('\n').forEach(sb.writeln);
  }
}

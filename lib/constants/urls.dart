import 'env.dart';

class UrlConstants {
  UrlConstants._();
  static const String URL = "https://www.metaweather.com";

  static const List<String> URLS = [URL];

  static String resolveUrl(String url) {
    return "${env.data.baseUrl}/$url";
  }

  static String getBaseUrl() {
    return env.data.baseUrl;
  }
}

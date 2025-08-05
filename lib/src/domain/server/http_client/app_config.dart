
import '../../../global/constants/enum.dart';

enum AppConfig {
  base,
  baseImage,
  apiKey,

}

extension AppUrlExtention on AppConfig {
  static String _baseUrl = "";
  static void setUrl(UrlLink urlLink) {
    switch (urlLink) {
      case UrlLink.isLive:
        _baseUrl = "";
        break;
      case UrlLink.isDev:
        _baseUrl = "http://www.omdbapi.com/";

        break;
      case UrlLink.isLocalServer:
        _baseUrl = "";
        break;
    }
  }

  String get url {
    switch (this) {
      case AppConfig.base:
        return _baseUrl;
      case AppConfig.baseImage:
        return "";

      default:
    }
    return "";
  }
}

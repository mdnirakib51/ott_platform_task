
import '../../../global/constants/enum.dart';

enum AppConfig {
  base,
  baseImage,
  logInUrl,
  registrationUrl,

}

extension AppUrlExtention on AppConfig {
  static String _baseUrl = "";

  static void setUrl(UrlLink urlLink) {
    switch (urlLink) {
      case UrlLink.isLive:
        _baseUrl = "";
        break;
      case UrlLink.isDev:
        _baseUrl = "https://sau.brri.softwaresale.xyz/";

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

        /// ==/@ Auth Api Url @/==
      case AppConfig.logInUrl:
        return 'api/login';
      case AppConfig.registrationUrl:
        return 'api/member_registration';

      default:
    }
    return "";
  }
}

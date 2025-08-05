
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'domain/local/preferences/local_storage.dart';
import 'domain/local/preferences/storage_controller.dart';
import 'domain/server/http_client/request_handler.dart';
import 'features/account/controller/account_controller.dart';
import 'features/dashboard_bottom_navigation_bar/controller/dashboard_buttom_controller.dart';
import 'features/home/controller/home_controller.dart';
import 'features/video_details/controller/video_details_controller.dart';

final locator = GetIt.instance;

Future<void> init(LocalStorage localStorage) async {
  final prefs = localStorage.sharedPreference;

  // ==# Register dependencies with GetIt for core services
  locator.registerLazySingleton<LocalStorage>(() => localStorage);
  locator.registerLazySingleton<RequestHandler>(() => RequestHandler(dio: Dio()));
  locator.registerLazySingleton<StorageController>(() => StorageController(prefs: prefs));

  // ==# UI Controllers using GetX lazyPut for screen management
  Get.lazyPut(() => AccountController(), fenix: true);
  Get.lazyPut(() => HomePageController(), fenix: true);
  Get.lazyPut(() => DashboardBottomController(), fenix: true);
  Get.lazyPut(() => VideoDetailsController(), fenix: true);

  // ==# Register GetIt services within GetX for further access
  Get.lazyPut(() => locator<RequestHandler>(), fenix: true);
  Get.lazyPut(() => locator<StorageController>(), fenix: true);

}



/// Initializes the app's core services and controllers.
///
/// This function sets up all the essential dependencies using both
/// the GetIt service locator and GetX's lazy-loaded controllers.
///
/// - The [localStorage] is passed as a parameter and registered as a singleton,
///   ensuring shared preference access is initialized only once.
///
/// - GetIt is used to register shared services such as:
///     - [LocalStorage] for handling persistent storage.
///     - [RequestHandler] for managing HTTP requests.
///     - [StorageController] for managing app data storage.
///
/// - Get.lazyPut() is employed for UI-related controllers like:
///     - [AccountController] to handle user account data.
///     - [HomePageController] for managing home screen interactions.
///     - [DashboardBottomController] for controlling navigation between
///       dashboard screens.
///
/// The use of `fenix: true` ensures that these controllers are retained in memory
/// and re-initialized as needed when the user navigates back to these parts of the app.

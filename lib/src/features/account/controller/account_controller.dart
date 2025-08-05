
import 'package:get/get.dart';

class AccountController extends GetxController implements GetxService {

  AccountController();

  static AccountController get current => Get.find();

  bool isLoginScreen = true;

  void toggleScreen() {
    isLoginScreen = !isLoginScreen;
    update();
  }

}

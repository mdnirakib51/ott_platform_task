
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../account/view/account_screen.dart';
import '../../download/view/download_screen.dart';
import '../../home/controller/home_controller.dart';
import '../../home/view/home_screen.dart';
import '../../search/view/search_screen.dart';

class DashboardBottomController extends GetxController implements GetxService {

  DashboardBottomController();

  static DashboardBottomController get current => Get.find();

  // ==/@ Navigation Bar
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    HomePageController.current.resetTabBarClick();
    update();
  }

  List<Widget> dashBoardBottomScreen = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const DownloadScreen(),
    const AccountScreen()
  ];

}

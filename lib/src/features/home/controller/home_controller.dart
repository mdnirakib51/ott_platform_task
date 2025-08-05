
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController implements GetxService {

  HomePageController();

  static HomePageController get current => Get.find();

  // ==/@ Scroll
  bool isScrolled = false;
  final ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.offset > 0 && !isScrolled) {
      isScrolled = true;
    } else if (scrollController.offset <= 0 && isScrolled) {
      isScrolled = false;
    }
    update();
  }

  initAddListener(){
    scrollController.addListener(scrollListener);
  }

  disposeListener(){
    scrollController.dispose();
  }

  // ==/@ Tab Bar
  int tabBarIndex = -1;
  void tabBarClick(int index) {
    tabBarIndex = index;
    update();
  }

  void resetTabBarClick() {
    tabBarIndex = -1;
    update();
  }

  List tabBarList = [
    "Movie",
    "Series",
    "Favourites"
  ];

}


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/images.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../dashboard_bottom_navigation_bar/dashboard_bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    route();

    // Reset to portrait mode when exiting full-screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }

  void route(){
    Timer(const Duration(seconds: 3), () {
      Get.offAll(()=> const DashboardBottomNavigationBar());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: size(context).height,
        width: size(context).width,
        padding: const EdgeInsets.symmetric(horizontal: 60),
        decoration: const BoxDecoration(
            color: ColorRes.appColor
        ),
        child: const Center(
          child: GlobalImageLoader(
            imagePath: Images.appLogo,
            width: 130,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

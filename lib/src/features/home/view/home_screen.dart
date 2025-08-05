
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/features/home/controller/home_controller.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../../tab/view/favourites_tab_view_screen.dart';
import '../../tab/view/movie_tab_view_screen.dart';
import '../../tab/view/series_tab_view_screen.dart';
import 'home_view_screen.dart';
import 'widget/dashboard_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // Reset to portrait mode when exiting full-screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (homePageController){
      return Scaffold(
        key: scaffoldKey,
        body: Container(
          height: size(context).height,
          width: size(context).width,
          color: ColorRes.appBackColor,
          child: Stack(
            children: [

              homePageController.tabBarIndex == -1
                  ? const HomeViewScreen()
                  : IndexedStack(
                index: homePageController.tabBarIndex,
                children: [
                  const MovieTabViewScreen(),
                  const SeriesTabViewScreen(),
                  const FavouritesTabViewScreen(),
                  Scaffold(body: Center(child: Container(height: double.infinity, width: double.infinity, color: ColorRes.appBackColor, child: const Center(child: Text("Favourites", style: TextStyle(color: Colors.white)))))),
                ],
              ),

              // == AppBar
              const DashboardAppbar()

              // homePageController.isScrolled
              //     ? const SizedBox.shrink()
              //     : const DashboardAppbar()
            ],
          ),
        ),
      );
    });
  }
}

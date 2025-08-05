
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/features/dashboard_bottom_navigation_bar/controller/dashboard_buttom_controller.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/widget/global_image_loader.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import 'package:ott_app/src/global/widget/global_text.dart';
import 'model/nav_item_model.dart';

class DashboardBottomNavigationBar extends StatefulWidget {
  const DashboardBottomNavigationBar({super.key});

  @override
  State<DashboardBottomNavigationBar> createState() => _DashboardBottomNavigationBarState();
}

class _DashboardBottomNavigationBarState extends State<DashboardBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardBottomController>(builder: (dashboardBottomController){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            dashboardBottomController.dashBoardBottomScreen.elementAt(dashboardBottomController.selectedIndex),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                width: size(context).width,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: ColorRes.black,
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                          color: ColorRes.appColor.withOpacity(0.3),
                          offset: const Offset(0, 20),
                          blurRadius: 20
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(navItemList.length, (index) =>
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            dashboardBottomController.onItemTapped(index);
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GlobalImageLoader(
                                  imagePath: navItemList[index].img,
                                  color: dashboardBottomController.selectedIndex == index ? ColorRes.appRedColor : ColorRes.white,
                                  height: 20,
                                  width: 20,
                                ),
                                sizedBoxH(5),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: dashboardBottomController.selectedIndex == index ? ColorRes.appRedColor : Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  child: GlobalText(
                                    str: navItemList[index].title,
                                    fontSize: 9,
                                    color: ColorRes.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

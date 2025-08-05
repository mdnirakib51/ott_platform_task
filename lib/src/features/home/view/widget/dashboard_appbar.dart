
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/widget/global_text.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../controller/home_controller.dart';

class DashboardAppbar extends StatefulWidget {
  const DashboardAppbar({super.key});

  @override
  State<DashboardAppbar> createState() => _DashboardAppbarState();
}

class _DashboardAppbarState extends State<DashboardAppbar> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (homePageController){
      return Container(
        height: 75,
        width: size(context).width,
        color: homePageController.isScrolled
            ? ColorRes.black.withOpacity(0.7)
            : ColorRes.black.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  sizedBoxW(10),
                  Expanded(
                    child: Row(
                      children: homePageController.tabBarList.asMap().entries.map((tab){
                        return Flexible(
                          child: GestureDetector(
                            onTap: (){
                              homePageController.tabBarClick(tab.key);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(right: 7),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GlobalText(
                                    str: tab.value,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: homePageController.tabBarIndex == tab.key ? ColorRes.appRedColor : ColorRes.white,
                                    textAlign: TextAlign.center,
                                  ),
                                  homePageController.tabBarIndex == tab.key ? Container(
                                    height: 2,
                                    width: homePageController.tabBarIndex == 0 || homePageController.tabBarIndex == 1 ? 25 : homePageController.tabBarIndex == 2 ? 40 : 30,
                                    color: ColorRes.appRedColor,
                                  ) : const SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorRes.appRedColor
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8
                        ),
                        child: const Center(
                          child: GlobalText(
                            str: "SUBSCRIBE",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizedBoxW(10)
                ],
              ),
            )

          ],
        ),
      );
    });
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/features/account/view/widget/account_menu_widget.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/constants/images.dart';
import 'package:ott_app/src/global/widget/global_bottom_widget.dart';
import 'package:ott_app/src/global/widget/global_container.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../../../global/widget/dotted/global_dotted_line_painter.dart';
import '../../../global/widget/global_text.dart';
import '../../dashboard_bottom_navigation_bar/controller/dashboard_buttom_controller.dart';
import '../controller/account_controller.dart';
import 'language_select_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'subscribe_now_screen.dart';
import 'watch_list_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key,});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (accountController){
      return GetBuilder<DashboardBottomController>(builder: (dashboardBottomController){
        return Scaffold(
          key: scaffoldKey,
          body: GlobalContainer(
            height: size(context).height,
            width: size(context).width,
            color: ColorRes.appBackColor,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxH(40),
                const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: GlobalText(
                    str: "Account",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                sizedBoxH(10),
                GlobalButtonWidget(
                  str: "Subscribe Now",
                  height: 45,
                  buttomColor: ColorRes.appRedColor,
                  textSize: 13,
                  onTap: (){
                    Get.to(()=> const SubscribeNowScreen());
                  },
                ),

                sizedBoxH(10),
                GlobalButtonWidget(
                  str: "Login / Sign Up",
                  img: Images.logInIc,
                  height: 50,
                  textSize: 13,
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (ctx){
                          return StatefulBuilder(
                              builder: (ctx, buildSetState){
                                return AlertDialog(
                                  backgroundColor: ColorRes.appBackColor.withOpacity(0.9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                  content: SizedBox(
                                    width: Get.width,
                                    child: NotificationListener<OverscrollIndicatorNotification>(
                                      onNotification: (overScroll) {
                                        overScroll.disallowIndicator();
                                        return true;
                                      },
                                      child: SingleChildScrollView(
                                        child: accountController.isLoginScreen
                                            ? LoginScreen(
                                          onSwitch: () {
                                            buildSetState(() {
                                              accountController.toggleScreen();
                                            });
                                          },
                                        )
                                            : SignUpScreen(
                                          onSwitch: () {
                                            buildSetState(() {
                                              accountController.toggleScreen();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        }
                    );
                  },
                ),

                sizedBoxH(20),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorRes.listTileBackColor
                  ),
                  child: Column(
                    children: [

                      AccountMenuWidget(
                          img: Images.languageIc,
                          title: "App Language",
                          subTitle: "English",
                          onTap: (){
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (ctx){
                                  return const LanguageSelectScreen();
                                }
                            );
                          }
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, 1),
                          painter: GlobalDottedLinePainter(),
                        ),
                      ),

                      AccountMenuWidget(
                          img: Images.watchIc,
                          title: "Watch List",
                          onTap: (){
                            Get.to(()=> const WatchListScreen());
                          }
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, 1),
                          painter: GlobalDottedLinePainter(),
                        ),
                      ),

                      AccountMenuWidget(
                          img: Images.downloadIc,
                          title: "Download",
                          onTap: (){
                            dashboardBottomController.onItemTapped(2);
                          }
                      ),

                      sizedBoxH(5)

                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
    });
  }
}

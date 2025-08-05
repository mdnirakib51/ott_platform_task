
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/constants/images.dart';
import 'package:ott_app/src/global/widget/global_container.dart';
import 'package:ott_app/src/global/widget/global_image_loader.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../../../global/widget/global_textform_field.dart';
import '../../account/controller/account_controller.dart';
import '../../tab/view/widget/global_appbar_widget.dart';
import 'widget/watch_list_menu_widget.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key,});
  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (accountController){
      return Scaffold(
        key: scaffoldKey,
        body: GlobalContainer(
          height: size(context).height,
          width: size(context).width,
          color: ColorRes.appBackColor,
          child: Column(
            children: [

              // ==# App Bar
              const GlobalAppbarWidget(
                title: "Watch List",
              ),

              Expanded(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        sizedBoxH(10),
                        GlobalTextFormField(
                          controller: emailCon,
                          hintText: "Search Movie & Series",
                          filled: true,
                          fillColor: ColorRes.bottomColor,
                          isDense: true,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: GlobalImageLoader(
                              imagePath: Images.searchIc,
                              color: ColorRes.white200,
                              height: 20,
                              width: 20,
                              fit: BoxFit.fill,
                            ),
                          ),
                          sufixIcon: emailCon.text.isNotEmpty ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  emailCon.clear();
                                });
                              },
                              child: const GlobalImageLoader(
                                imagePath: Images.close,
                                color: ColorRes.white200,
                                height: 20,
                                width: 20,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ) : const SizedBox.shrink(),
                          onChanged: (val){
                            setState(() {
                              emailCon.text = val;
                            });
                          },
                        ),

                        sizedBoxH(10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 30,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return WatchListMenuWidget(
                                img: Images.justiceLeagueImg,
                                text: "Best Of Tagore Song | Rabindra Sangeet Juke Box | Trissha Chatterjee | Bob Sn",
                                subText: "Trisha Chatterjje",
                                onTap: (){},
                                moreVertOnTap: (){
                                  // showModalBottomSheet(
                                  //     context: context,
                                  //     backgroundColor: Colors.transparent,
                                  //     builder: (ctx){
                                  //       return const DownloadMoreVertScreen();
                                  //     }
                                  // );
                                },
                              );
                            },
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/widget/global_container.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../../../global/constants/images.dart';
import '../../../global/widget/global_text.dart';
import '../../home/view/widget/social_menu_widget.dart';
import '../controller/video_details_controller.dart';
import 'widget/video_details_menu_widget.dart';
import 'widget/video_player_details_widget.dart';

class VideoDetailsScreen extends StatefulWidget {
  const VideoDetailsScreen({
    super.key,
  });
  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailCon = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Reset to portrait mode when exiting full-screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }

  bool isExploreClick = false;
  List<String> exploreList = [
    "Latest Shows",
    "Latest Movies",
    "Upcoming on NP",
    "All Shows",
    "All Movies",
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoDetailsController>(builder: (videoDetailsController){
      return Scaffold(
        key: scaffoldKey,
        body: GlobalContainer(
          height: size(context).height,
          width: size(context).width,
          color: ColorRes.appBackColor,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll){
              overScroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBoxH(25),

                  // ==# Video Player
                  const VideoPlayerDetailsWidget(),

                  sizedBoxH(10),
                  Container(
                      width: size(context).width,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GlobalText(
                            str: "Justice League",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),

                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GlobalText(
                                str: "Genres: ",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: ColorRes.appRedColor,
                              ),
                              GlobalText(
                                str: "Action - Adventure",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),

                          const GlobalText(
                            str: "6 September | 2024",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),

                          sizedBoxH(10),
                          const SizedBox(
                            child: GlobalText(
                              str: "Steppenwolf and hconst is Parademons return after eons to capture Earth. However, Batman seeks the help of Wonder Woman to recruit and assemble Flash, Cyborg and Aquaman to fight the powerful new enemy.",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              fontSize: 10,
                            ),
                          )
                        ],
                      )
                  ),

                  sizedBoxH(15),
                  ListView.builder(
                    itemCount: 12,
                    padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return VideoDetailsMenuWidget(
                        img: Images.justiceLeagueImg,
                        text: "Best Of Tagore Song | Rabindra Sangeet Juke Box | Trissha Chatterjee | Bob Sn",
                        subText: "Trisha Chatterjje",
                        onTap: (){},
                        moreVertOnTap: (){

                        },
                      );
                    },
                  ),

                  sizedBoxH(20),
                  Container(
                    width: size(context).width,
                    color: ColorRes.appColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        sizedBoxH(10),
                        const GlobalImageText(
                          str: "NP",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),

                        sizedBoxH(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialMenuWidget(
                              img: Images.facebookIc,
                              onTap: (){},
                            ),

                            sizedBoxW(10),
                            SocialMenuWidget(
                              img: Images.instagramIc,
                              onTap: (){},
                            ),

                            sizedBoxW(10),
                            SocialMenuWidget(
                              img: Images.linkedInIc,
                              onTap: (){},
                            ),
                          ],
                        ),

                        sizedBoxH(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialMenuWidget(
                              img: Images.youtubeIc,
                              onTap: (){},
                            ),

                            sizedBoxW(10),
                            SocialMenuWidget(
                              img: Images.twitterIc,
                              onTap: (){},
                            ),
                          ],
                        ),

                        sizedBoxH(30),
                        Container(
                          width: size(context).width,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: ColorRes.white),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isExploreClick = !isExploreClick;
                                  });
                                },
                                child: const SizedBox(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GlobalText(
                                          str: "Explore",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: ColorRes.white,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              isExploreClick == true ?
                              Padding(
                                padding: const EdgeInsets.only(left: 20, top: 8),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: exploreList.asMap().entries.map((item){
                                      return Container(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: GlobalText(
                                          str: item.value,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      );
                                    }).toList()
                                ),
                              ) : const SizedBox.shrink()
                            ],
                          ),
                        ),

                        sizedBoxH(10),
                        Container(
                          width: size(context).width,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: ColorRes.white),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isExploreClick = !isExploreClick;
                                  });
                                },
                                child: const SizedBox(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GlobalText(
                                          str: "Company",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: ColorRes.white,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              isExploreClick == true ?
                              Padding(
                                padding: const EdgeInsets.only(left: 20, top: 8),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: exploreList.asMap().entries.map((item){
                                      return Container(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: GlobalText(
                                          str: item.value,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      );
                                    }).toList()
                                ),
                              ) : const SizedBox.shrink()
                            ],
                          ),
                        ),

                        sizedBoxH(10),
                        Container(
                          width: size(context).width,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: ColorRes.white),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isExploreClick = !isExploreClick;
                                  });
                                },
                                child: const SizedBox(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GlobalText(
                                          str: "Contract",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: ColorRes.white,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              isExploreClick == true ?
                              Padding(
                                padding: const EdgeInsets.only(left: 20, top: 8),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: exploreList.asMap().entries.map((item){
                                      return Container(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: GlobalText(
                                          str: item.value,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      );
                                    }).toList()
                                ),
                              ) : const SizedBox.shrink()
                            ],
                          ),
                        ),

                        sizedBoxH(20),
                        const GlobalText(
                          str: "Copyright © 2024 NP",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),

                        sizedBoxH(20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

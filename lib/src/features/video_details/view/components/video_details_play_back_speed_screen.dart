
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_bottom_widget.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../controller/video_details_controller.dart';

class VideoDetailsPlayBackSpeedScreen extends StatefulWidget {
  final Function(double) onSpeedSelected;
  const VideoDetailsPlayBackSpeedScreen({
    super.key,
    required this.onSpeedSelected,
  });

  @override
  State<VideoDetailsPlayBackSpeedScreen> createState() => _VideoDetailsPlayBackSpeedScreenState();
}

class _VideoDetailsPlayBackSpeedScreenState extends State<VideoDetailsPlayBackSpeedScreen> {

  final videoDetailsController = Get.find<VideoDetailsController>();

  @override
  void initState() {
    super.initState();

    // ==# Init Selected
    videoDetailsController.selectPlaySpeed = videoDetailsController.playSpeedList
        .indexWhere((element) => element.playBackValue == videoDetailsController.initialSpeed);

    // ==# Fallback to normal if no valid speed found
    if (videoDetailsController.selectPlaySpeed == -1) {
      videoDetailsController.selectPlaySpeed = videoDetailsController.playSpeedList.indexWhere((element) => element.playBackValue == 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoDetailsController>(builder: (videoPlayerDetailsController){
      return StatefulBuilder(
          builder: (ctx, buildSetState){
            return Container(
              width: size(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  color: ColorRes.appBackColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  sizedBoxH(10),
                  Container(
                    height: 4,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorRes.grey.withOpacity(0.3)
                    ),
                  ),

                  sizedBoxH(10),
                  const Row(
                    children: [
                      GlobalText(
                        str: "Video Play Speed",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )
                    ],
                  ),

                  sizedBoxH(10),

                  Expanded(
                    child: ListView.builder(
                        itemCount: videoPlayerDetailsController.playSpeedList.length,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index){
                          final languageData = videoPlayerDetailsController.playSpeedList[index];
                          return GestureDetector(
                            onTap: (){
                              buildSetState(() {
                                videoPlayerDetailsController.selectPlaySpeed = index;
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 5
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  videoPlayerDetailsController.selectPlaySpeed == index
                                      ? Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: ColorRes.appRedColor
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: ColorRes.white,
                                      size: 18,
                                    ),
                                  )
                                      : Container(
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: ColorRes.appRedColor,
                                            width: 1
                                        )
                                    ),
                                  ),

                                  sizedBoxW(15),
                                  Expanded(
                                    child: SizedBox(
                                      child: GlobalText(
                                        str: languageData.playBackName,
                                        fontWeight: FontWeight.w500,
                                        color: ColorRes.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ),

                  sizedBoxH(10),
                  // Save button
                  GlobalButtonWidget(
                    str: "Save",
                    height: 45,
                    buttomColor: ColorRes.appRedColor,
                    textSize: 13,
                    onTap: () {
                      widget.onSpeedSelected(videoPlayerDetailsController.playSpeedList[videoPlayerDetailsController.selectPlaySpeed ?? 2].playBackValue);
                      Navigator.pop(context);
                    },
                  ),
                  sizedBoxH(10),

                ],
              ),
            );
          }
      );
    });
  }
}

class PlayBackSpeedModel{
  final String playBackName;
  final double playBackValue;

  PlayBackSpeedModel({
    required this.playBackName,
    required this.playBackValue
  });
}

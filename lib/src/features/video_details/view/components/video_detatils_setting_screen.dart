
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/constants/images.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../controller/video_details_controller.dart';
import 'video_details_play_back_speed_screen.dart';
import '../widget/video_details_settings_menu_widgt.dart';
import 'video_details_quantity_screen.dart';

class VideoDetailsSettingsScreen extends StatefulWidget {
  final Function(double) onSpeedSelected;
  const VideoDetailsSettingsScreen({
    super.key,
    required this.onSpeedSelected
  });

  @override
  State<VideoDetailsSettingsScreen> createState() => _VideoDetailsSettingsScreenState();
}

class _VideoDetailsSettingsScreenState extends State<VideoDetailsSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoDetailsController>(builder: (videoPlayerDetailsController){
      return StatefulBuilder(
          builder: (ctx, buildSetState){
            return Container(
              height: 180,
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
                        str: "Video Option",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )
                    ],
                  ),

                  sizedBoxH(10),
                  VideoDetailsSettingMenuWidget(
                      img: Images.qualityIc,
                      title: "Quality",
                      subTitle: "Auto(720p)",
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (ctx){
                              return const VideoDetailsQualityScreen();
                            }
                        );
                      }
                  ),

                  VideoDetailsSettingMenuWidget(
                      img: Images.playSpeedIc,
                      title: "PlayBack Speed",
                      subTitle: videoPlayerDetailsController.getPlaybackSpeedLabel(videoPlayerDetailsController.initialSpeed ?? 1),
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (ctx){
                              return VideoDetailsPlayBackSpeedScreen(
                                onSpeedSelected: (speed){
                                  setState(() {
                                    videoPlayerDetailsController.initialSpeed = speed;
                                  });
                                  widget.onSpeedSelected(speed);
                                },
                              );
                            }
                        );
                      }
                  ),

                ],
              ),
            );
          }
      );
    });
  }
}

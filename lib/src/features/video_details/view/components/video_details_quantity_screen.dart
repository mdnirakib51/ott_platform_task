import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_bottom_widget.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';
import '../../controller/video_details_controller.dart';

class VideoDetailsQualityScreen extends StatefulWidget {
  final Function(int)? onQualitySelected;

  const VideoDetailsQualityScreen({
    super.key,
    this.onQualitySelected,
  });

  @override
  State<VideoDetailsQualityScreen> createState() => _VideoDetailsQualityScreenState();
}

class _VideoDetailsQualityScreenState extends State<VideoDetailsQualityScreen> {

  final videoDetailsController = Get.find<VideoDetailsController>();
  int? tempSelectedQuality;

  @override
  void initState() {
    super.initState();
    // Initialize temp selection with current selection
    tempSelectedQuality = videoDetailsController.selectQuantity;
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
                mainAxisSize: MainAxisSize.min,
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
                        str: "Video Quality",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )
                    ],
                  ),

                  sizedBoxH(10),

                  // Show loading if qualities are not loaded yet
                  if (!videoPlayerDetailsController.isQualitiesLoaded)
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(color: ColorRes.white),
                    ),

                  // Show quality list if loaded
                  if (videoPlayerDetailsController.isQualitiesLoaded)
                    Flexible(
                      child: ListView.builder(
                          itemCount: videoPlayerDetailsController.qualityList.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, index){
                            final qualityData = videoPlayerDetailsController.qualityList[index];
                            final isSelected = tempSelectedQuality == index;

                            return GestureDetector(
                              onTap: (){
                                buildSetState(() {
                                  tempSelectedQuality = index;
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 5
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    isSelected
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
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          GlobalText(
                                            str: qualityData.qualityName,
                                            fontWeight: FontWeight.w500,
                                            color: ColorRes.white,
                                            fontSize: 14,
                                          ),
                                          if (qualityData.resolution != 'Auto' && qualityData.resolution != 'Unknown')
                                            GlobalText(
                                              str: qualityData.resolution,
                                              fontWeight: FontWeight.w400,
                                              color: ColorRes.grey,
                                              fontSize: 12,
                                            ),
                                        ],
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
                  if (videoPlayerDetailsController.isQualitiesLoaded)
                    GlobalButtonWidget(
                      str: "Apply",
                      height: 45,
                      buttomColor: ColorRes.appRedColor,
                      textSize: 13,
                      onTap: () {
                        if (tempSelectedQuality != null &&
                            tempSelectedQuality != videoPlayerDetailsController.selectQuantity) {
                          // Apply the quality change
                          if (widget.onQualitySelected != null) {
                            widget.onQualitySelected!(tempSelectedQuality!);
                          }
                        }
                        Get.back(); // Close the quality selection screen
                        Get.back(); // Close the settings screen
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
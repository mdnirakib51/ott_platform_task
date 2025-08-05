
import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';

class VideoDetailsSettingMenuWidget extends StatelessWidget {
  final String img;
  final String title;
  final String? subTitle;
  final Function() onTap;
  const VideoDetailsSettingMenuWidget({
    super.key,
    required this.img,
    required this.title,
    this.subTitle,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size(context).width,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  GlobalImageLoader(
                    imagePath: img,
                    height: 18,
                    width: 18,
                    color: ColorRes.white,
                  ),
                  sizedBoxW(15),
                  subTitle == null ? Expanded(
                    child: GlobalText(
                      str: title,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ) : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          str: title,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        GlobalText(
                          str: subTitle ?? "",
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: ColorRes.grey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorRes.grey,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

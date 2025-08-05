
import 'package:flutter/material.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_text.dart';

class DownloadMenuWidget extends StatelessWidget {
  final String img;
  final String text;
  final String subText;
  final Function() onTap;
  final Function() moreVertOnTap;
  const DownloadMenuWidget({
    super.key,
    required this.img,
    required this.text,
    required this.subText,
    required this.onTap,
    required this.moreVertOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size(context).width,
        margin: const EdgeInsets.only(
          bottom: 10
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: GlobalImageLoader(
                imagePath: img,
                height: 85,
                width: 140,
                fit: BoxFit.fill,
              ),
            ),
            sizedBoxW(5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    str: text,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  GlobalText(
                    str: subText,
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const GlobalText(
                    str: '2.5M Views',
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: moreVertOnTap,
                child: const Icon(
                  Icons.more_vert_outlined,
                  size: 20,
                  color: ColorRes.white,
                ))
          ],
        ),
      ),
    );
  }
}

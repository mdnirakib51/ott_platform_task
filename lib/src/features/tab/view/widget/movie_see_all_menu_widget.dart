
import 'package:flutter/material.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_text.dart';

class MovieSeeAllMenuWidget extends StatelessWidget {
  final String img;
  final String text;
  final String subText;
  final Function() onTap;
  const MovieSeeAllMenuWidget({
    super.key,
    required this.img,
    required this.text,
    required this.subText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorRes.bottomColor.withOpacity(0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5)
              ),
              child: GlobalImageLoader(
                imagePath: img,
                height: 100,
                width: size(context).width,
                fit: BoxFit.fill,
              ),
            ),
            sizedBoxH(3),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: GlobalText(
                str: text,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}

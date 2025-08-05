
import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/constants/enum.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_text.dart';

class MovieMenuWidget extends StatelessWidget {
  final String img;
  final String text;
  final String subText;
  final ImageFor? imageFor;
  final Function() onTap;
  const MovieMenuWidget({
    super.key,
    required this.img,
    required this.text,
    required this.subText,
    this.imageFor = ImageFor.asset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 115,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: GlobalImageLoader(
                    imagePath: img,
                    height: 160,
                    width: 115,
                    fit: BoxFit.fill,
                    imageFor: imageFor ?? ImageFor.asset,
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      decoration: const BoxDecoration(
                          color: ColorRes.appRedColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)
                          )
                      ),
                      child: GlobalText(
                        str: subText,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                )
              ],
            ),
            GlobalText(
              str: text,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}

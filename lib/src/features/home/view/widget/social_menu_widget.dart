
import 'package:flutter/material.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import '../../../../global/widget/global_image_loader.dart';

class SocialMenuWidget extends StatelessWidget {
  final String img;
  final Function() onTap;
  const SocialMenuWidget({
    super.key,
    required this.img,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 1, color: ColorRes.white)
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: GlobalImageLoader(
            imagePath: img,
            height: 20,
            width: 20,
            color: ColorRes.white,
          ),
        ),
      ),
    );
  }
}

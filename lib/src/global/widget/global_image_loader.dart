
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import '../constants/enum.dart';
import '../constants/images.dart';

class GlobalImageLoader extends StatelessWidget {
  const GlobalImageLoader({
    super.key,
    required this.imagePath,
    this.imageFor = ImageFor.asset,
    this.height,
    this.width,
    this.fit,
    this.color,
    this.errorBuilder
  });
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  final ImageErrorWidgetBuilder? errorBuilder;
  final ImageFor imageFor;

  @override
  Widget build(BuildContext context) {
    if (imageFor == ImageFor.network) {
      return Image.network(
          imagePath,
          height: height,
          width: width,
          fit: fit,
          color: color,
          errorBuilder: errorBuilder ?? (context, exception, stackTrace) => Center(
              child: Container(
                height: height,
                width: width,
                color: ColorRes.grey.withOpacity(0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Images.appLogoShadow,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              )
          )
      );
    } else if (imageFor == ImageFor.local) {
      log("Image Path2: $imagePath");
      return Image.file(
        File(imagePath),
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: errorBuilder ?? (context, exception, stackTrace) => Center(
            child: Container(
              height: height,
              width: width,
              color: ColorRes.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.appLogoShadow,
                    width: 80,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            )
        ),
      );
    } else {
      return Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: errorBuilder ?? (context, exception, stackTrace) => Center(
            child: Container(
              height: height,
              width: width,
              color: ColorRes.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.appLogoShadow,
                    width: 80,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            )
        ),
      );
    }
  }
}

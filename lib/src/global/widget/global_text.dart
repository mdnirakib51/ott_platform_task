import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ott_app/src/global/constants/images.dart';
import '../constants/colors_resources.dart';
import 'package:flutter/services.dart';

class GlobalText extends StatelessWidget {
  final String str;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? softwrap;
  final double? height;
  final String? fontFamily;

  const GlobalText({
    super.key,
    required this.str,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.color,
    this.letterSpacing,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softwrap,
    this.height,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    final h = height ?? .08;
    final fw = fontSize ?? 14;
    final double fontHeight = h * fw;
    return Text(
      str,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softwrap,
      style: GoogleFonts.roboto(
        color: color ?? ColorRes.white,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        decoration: decoration,
        height: height == null ? null : fontHeight,
        fontStyle: fontStyle,
        // fontFamily: fontFamily ?? AppConstantKey.fontFamily.key,
      ),
    );
  }
}

class GlobalImageText extends StatelessWidget {
  final String str;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? softwrap;
  final double? height;
  final String? fontFamily;

  const GlobalImageText({
    super.key,
    required this.str,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.color,
    this.letterSpacing,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softwrap,
    this.height,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    final h = height ?? .08;
    final fw = fontSize ?? 14;
    final double fontHeight = h * fw;

    return FutureBuilder<ui.Image>(
      future: _loadUiImage(Images.textUre), // Load the texture image as ui.Image
      builder: (context, snapshot) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return ImageShader(
              snapshot.data!,
              TileMode.repeated,
              TileMode.repeated,
              Matrix4.identity().storage, // Removed scaling
            );
          },
          blendMode: BlendMode.srcIn,
          child: Text(
            str,
            maxLines: maxLines,
            overflow: overflow,
            textAlign: textAlign,
            softWrap: softwrap,
            style: GoogleFonts.roboto(
              color: color, // This color will be overridden by the image texture
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              decoration: decoration,
              height: height == null ? null : fontHeight,
              fontStyle: fontStyle,
            ),
          ),
        );
      },
    );
  }

  Future<ui.Image> _loadUiImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }
}

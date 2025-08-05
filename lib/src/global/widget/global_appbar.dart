import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors_resources.dart';
import 'global_text.dart';

class GlobalAppBar extends StatelessWidget {
  const GlobalAppBar({
    super.key,
    this.title,
    this.titleText,
    this.centerTitle,
    this.leading,
    this.backgroundColor,
    this.actions,
  });

  final Widget? title;
  final String? titleText;
  final Color? backgroundColor;
  final Widget? leading;
  final bool? centerTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? ColorRes.appColor,
      automaticallyImplyLeading: false,
      leading: leading ?? IconButton(
        splashRadius: 0.1,
        icon: const Icon(Icons.arrow_back, color: ColorRes.white, size: 22),
        onPressed: (){
          Get.back();
        },
      ),
      centerTitle: centerTitle,
      title: title ?? GlobalText(
        str: titleText ?? '',
        color: ColorRes.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        textAlign: TextAlign.center,
        fontFamily: 'Rubik',
      ),
      actions: actions
    );
  }
}
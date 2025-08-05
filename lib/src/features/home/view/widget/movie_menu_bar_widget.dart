
import 'package:flutter/material.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import '../../../../global/widget/global_text.dart';

class MovieMenuBarWidget extends StatelessWidget {
  final String text;
  final Function() onTap;
  const MovieMenuBarWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlobalText(
            str: text,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const GlobalText(
            str: "See All",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorRes.appRedColor,
          ),
        ),
      ],
    );
  }
}

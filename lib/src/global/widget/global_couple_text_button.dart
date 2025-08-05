
import 'package:flutter/material.dart';
import '../constants/colors_resources.dart';

class CoupleTextButton extends StatelessWidget {
  final String firstText;
  final String secondText;

  const CoupleTextButton(
      {super.key, required this.firstText, required this.secondText});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: const TextStyle(
              color: ColorRes.white200,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              // decoration: TextDecoration.lineThrough,
            ),
          ),
          const TextSpan(
            text: ' ',
            style: TextStyle(
              // color: KColor.deep2.color,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: secondText,
            style: const TextStyle(
              color: ColorRes.appRedColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
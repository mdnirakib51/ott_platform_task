
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';

class GlobalAppbarWidget extends StatelessWidget {
  final String title;
  const GlobalAppbarWidget({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      color: ColorRes.black.withOpacity(0.5),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              height: 40,
              width: 30,
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: ColorRes.white,
                  size: 20,
                ),
              ),
            ),
          ),
          sizedBoxW(5),
          Expanded(
            child: GlobalText(
              str: title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

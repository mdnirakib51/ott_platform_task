
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../../../global/widget/global_container.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  int isDrop = 0;

  @override
  Widget build(BuildContext context) {

    return GlobalContainer(
      height: Get.height,
      width: 130,
      color: ColorRes.appBackColor,
      margin: const EdgeInsets.only(top: 100, bottom: 200),
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5)
      ),
      child: Column(
        children: [
          sizedBoxH(10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

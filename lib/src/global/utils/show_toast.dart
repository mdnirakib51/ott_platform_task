import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors_resources.dart';

void printTest(String text){
  if(kDebugMode){
    print('\x1B[33m$text\x1B[0m');
  }
}

void showLog(String text){
  if(kDebugMode){
    log('\x1B[33m$text\x1B[0m');
  }
}

void showCustomSnackBar(String message, {
      IconData? icon,
      bool isError = true,
      bool isPosition= true,
      double? duration,
    }) {
  Get.showSnackbar(

      GetSnackBar(
        backgroundColor: isError ? ColorRes.appRedColor : ColorRes.green,
        message: message,
        maxWidth: 1170,
        duration: duration != null ? Duration(seconds: duration.toInt()) : const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        isDismissible: true,
        snackPosition: isPosition?SnackPosition.BOTTOM:SnackPosition.TOP,
        icon: Icon(icon,
          size: 25,
          color: ColorRes.white,
        ),

  ));
}

class OverlayLoadingIndicator extends StatelessWidget {
  const OverlayLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black26,
      child: Center(
        child: Container(
          height: 125,
          width: 120,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularProgressIndicator(),
              Text("Loading..."),
            ],
          ),
        ),
      ),
    );
  }
}

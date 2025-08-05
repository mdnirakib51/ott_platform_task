
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/constants/images.dart';
import 'package:video_player/video_player.dart';
import '../view/mini_screen_video_player.dart';
import '../view/components/video_details_play_back_speed_screen.dart';

class VideoDetailsController extends GetxController implements GetxService {

  VideoDetailsController();

  static VideoDetailsController get current => Get.find();

  final String videoSrc = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4";
  final String initImg = Images.justiceLeagueImg;

  /// ==# Selected Video Player Speed..
  int? selectQuantity = 0;

  List<PlayBackSpeedModel> quantityList = [
    PlayBackSpeedModel(playBackName: "Auto", playBackValue: 0.5),
    PlayBackSpeedModel(playBackName: "400p", playBackValue: 0.75),
    PlayBackSpeedModel(playBackName: "720p", playBackValue: 1.0),
  ];


  /// ==================== /@ Business Logic @/ ====================

  OverlayEntry? _miniPlayerOverlay;

  void showMiniPlayerOverlay({
    required BuildContext context,
    required VideoPlayerController controller
  }) {

    if (_miniPlayerOverlay == null) {
      _miniPlayerOverlay = OverlayEntry(
        builder: (context) => Stack(
          children: [
            MiniScreenVideoPlayer(controller: controller),
          ],
        ),
      );
      Overlay.of(context).insert(_miniPlayerOverlay!);
    }
    update();
  }

  void removeMiniPlayerOverlay() {
    _miniPlayerOverlay?.remove();
    _miniPlayerOverlay = null;
    update();
  }

  /// ==# Next & Previous Button 10s Message View..

  String displayMessage = '';
  bool isMessageVisible = false;

  int clickCount = 0;
  Timer? _clickTimer;

  // Update this method to handle click counts
  void handleClick(bool isNext){
    clickCount++;
    _showMessageWithCount(isNext);

    // Reset the click count after 3 seconds
    if (_clickTimer?.isActive ?? false) {
      _clickTimer!.cancel();
    }
    _clickTimer = Timer(const Duration(seconds: 2), () {
      clickCount = 0; // Reset the count
    });
  }

  void _showMessageWithCount(bool isNext) {
    int totalSeconds = 0 + clickCount * 10; // Calculate total seconds
    String direction = isNext ? 'Forward' : 'Rewind';
    showMessage('$direction $totalSeconds seconds');
  }

  void showMessage(String message) {
    displayMessage = message;
    isMessageVisible = true;
    update();

    Future.delayed(const Duration(seconds: 1), (){
      isMessageVisible = false;
      update();
      Future.delayed(const Duration(seconds: 1), (){
        displayMessage = '';
        update();
      });
    });
  }

  /// ==# Video Time Format..
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  /// ==# Selected Video Player Speed..
  int? selectPlaySpeed = 0;
  double? initialSpeed;

  List<PlayBackSpeedModel> playSpeedList = [
    PlayBackSpeedModel(playBackName: "0.5x", playBackValue: 0.5),
    PlayBackSpeedModel(playBackName: "0.75x", playBackValue: 0.75),
    PlayBackSpeedModel(playBackName: "Normal", playBackValue: 1.0),
    PlayBackSpeedModel(playBackName: "1.25x", playBackValue: 1.25),
    PlayBackSpeedModel(playBackName: "1.5x", playBackValue: 1.5),
    PlayBackSpeedModel(playBackName: "1.75x", playBackValue: 1.75),
    PlayBackSpeedModel(playBackName: "2x", playBackValue: 2.0),
    PlayBackSpeedModel(playBackName: "4x", playBackValue: 4.0)
  ];

  String getPlaybackSpeedLabel(double speed) {
    if (speed == 1.0) return 'Normal';
    return '${speed}x';
  }

  /// ==# Function to handle exit full-screen and reset to portrait mode..
  void exitFullScreen() {
    Get.back();
    // Reset to portrait mode when exiting full-screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);

    update();
  }

  /// ==================== /@ UI Api Han @/ ====================

}

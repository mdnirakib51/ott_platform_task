import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/constants/images.dart';
import 'package:video_player/video_player.dart';
import '../hls_service/hls_quality_manage.dart';
import '../model/video_list_model.dart';
import '../view/mini_screen_video_player.dart';
import 'video_detail_repo.dart';

class VideoDetailsController extends GetxController implements GetxService {
  static VideoDetailsController get current => Get.find();
  final VideoDetailsRepository repository = VideoDetailsRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    _hasError = false;
    update();
  }

  void _setErrorState(bool hasError) {
    _isLoading = false;
    _hasError = hasError;
    update();
  }

  final String videoSrc = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8";
  final String initImg = Images.justiceLeagueImg;

  /// ==# Selected Video Quality..
  int? selectQuantity = 0;
  List<QualityModel> qualityList = [];
  bool _isQualitiesLoaded = false;
  bool get isQualitiesLoaded => _isQualitiesLoaded;

  // Current selected quality URL
  String get currentQualityUrl => qualityList.isNotEmpty && selectQuantity != null
      ? qualityList[selectQuantity!].qualityUrl
      : videoSrc;

  /// Initialize HLS qualities
  Future<void> initializeQualities() async {
    try {
      _setLoadingState(true);
      final hlsQualities = await HLSQualityManager.extractQualities(videoSrc);

      qualityList.clear();
      for (final quality in hlsQualities) {
        qualityList.add(QualityModel(
          qualityName: quality.label,
          qualityUrl: quality.url,
          resolution: quality.resolution,
          bandwidth: quality.bandwidth,
        ));
      }

      // Set Auto as default (index 0)
      selectQuantity = 0;
      _isQualitiesLoaded = true;

      log('Loaded ${qualityList.length} qualities');
      for (final quality in qualityList) {
        log('Quality: ${quality.qualityName} - ${quality.resolution}');
      }

      _setLoadingState(false);
    } catch (e) {
      log('Error initializing qualities: $e');
      // Fallback to default quality list if HLS parsing fails
      qualityList = [
        QualityModel(
          qualityName: "Auto",
          qualityUrl: videoSrc,
          resolution: "Auto",
          bandwidth: 0,
        ),
      ];
      selectQuantity = 0;
      _isQualitiesLoaded = true;
      _setLoadingState(false);
    }
  }

  /// Change video quality
  Future<void> changeQuality(int qualityIndex, VideoPlayerController controller) async {
    if (qualityIndex >= 0 && qualityIndex < qualityList.length) {
      try {
        // Store current position
        final currentPosition = controller.value.position;
        final wasPlaying = controller.value.isPlaying;

        // Pause the video
        await controller.pause();

        // Update selected quality
        selectQuantity = qualityIndex;

        // Dispose current controller
        await controller.dispose();

        // Create new controller with new quality URL
        final newController = VideoPlayerController.networkUrl(
            Uri.parse(qualityList[qualityIndex].qualityUrl)
        );

        // Initialize new controller
        await newController.initialize();

        // Restore position
        await newController.seekTo(currentPosition);

        // Resume playing if it was playing before
        if (wasPlaying) {
          await newController.play();
        }

        // You'll need to update the reference to the new controller
        // This might require some refactoring in your widget

        log('Quality changed to: ${qualityList[qualityIndex].qualityName}');
        update();

      } catch (e) {
        log('Error changing quality: $e');
      }
    }
  }

  /// Get current quality name
  String getCurrentQualityName() {
    if (selectQuantity != null && selectQuantity! < qualityList.length) {
      return qualityList[selectQuantity!].qualityName;
    }
    return 'Auto';
  }

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

  VideoDetailsModel? videoListModel;
  Future getVideoDetails({
    required String imdbId,
    String? title,
    String? type,
    String? year,
  }) async {
    try {
      _setLoadingState(true);

      final response = await repository.getVideoDetails(
        imdbId: imdbId,
        title: title,
        type: type,
        year: year,
      );
      videoListModel = response;

      _isLoading = false;
      update();
    } catch (e, s) {
      log('Error: ', error: e, stackTrace: s);
      _setErrorState(true);
    }
  }
}

class PlayBackSpeedModel{
  final String playBackName;
  final double playBackValue;

  PlayBackSpeedModel({
    required this.playBackName,
    required this.playBackValue
  });
}
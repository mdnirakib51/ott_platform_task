import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/features/video_details/controller/video_details_controller.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/constants/images.dart';
import 'package:ott_app/src/global/widget/global_image_loader.dart';
import 'package:video_player/video_player.dart';
import '../../../../global/constants/enum.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../full_screen_video_player.dart';
import '../components/video_detatils_setting_screen.dart';

class VideoPlayerDetailsWidget extends StatefulWidget {
  final String initImg;
  const VideoPlayerDetailsWidget({
    super.key,
    required this.initImg,
  });

  @override
  State<VideoPlayerDetailsWidget> createState() => _VideoPlayerDetailsWidgetState();
}

class _VideoPlayerDetailsWidgetState extends State<VideoPlayerDetailsWidget> {

  VideoPlayerController? _controller;
  bool _controlsVisible = true;
  bool _isInitializing = true;
  String? _initializationError;

  final videoDetailsController = Get.find<VideoDetailsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeVideo();
    });
  }

  Future<void> _initializeVideo() async {
    try {
      if (!mounted) return;

      setState(() {
        _isInitializing = true;
        _initializationError = null;
      });

      /// -> First, initialize qualities
      await videoDetailsController.initializeQualities();

      if (!mounted) return;

      /// -> Then create controller with the current quality URL
      _controller = VideoPlayerController.networkUrl(Uri.parse(videoDetailsController.currentQualityUrl));

      await _controller?.initialize();

      if (!mounted) return; // Check again after async operation

      /// -> Add listener to handle video end event
      _controller?.addListener(_videoListener);
      videoDetailsController.initialSpeed = null;

      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }

    } catch (e) {
      log('Error initializing video: $e');
      if (mounted) {
        setState(() {
          _isInitializing = false;
          _initializationError = e.toString();
        });
      }
    }
  }

  void _videoListener() {
    if (_controller != null && mounted) {
      if (_controller?.value.position == _controller?.value.duration) {
        setState(() {
          _controlsVisible = true;
        });
      }
      if (_controller?.value.hasError ?? false) {
        log('VideoPlayer Error: ${_controller?.value.errorDescription}');
      }
    }
  }

  bool _isMuted = false;

  Future<void> _onScreenExitThenOverlayEntry() async {
    if (_controller != null) {
      videoDetailsController.showMiniPlayerOverlay(
        context: context,
        controller: _controller!,
      );
    }
  }

  void _setPlaybackSpeed(double speed) {
    if (_controller != null) {
      videoDetailsController.initialSpeed = speed;
      _controller?.setPlaybackSpeed(speed);
    }
  }

  /// -> Add this method to handle quality changes
  Future<void> _changeVideoQuality(int qualityIndex) async {
    if (_controller == null || qualityIndex >= videoDetailsController.qualityList.length || !mounted) {
      return;
    }

    try {
      /// -> Store current state
      final currentPosition = _controller?.value.position ?? Duration.zero;
      final wasPlaying = _controller?.value.isPlaying ?? false;
      final currentVolume = _controller?.value.volume ?? 1.0;
      final currentSpeed = _controller?.value.playbackSpeed ?? 1.0;

      // Show loading indicator
      if (mounted) {
        setState(() {
          _controlsVisible = false;
          _isInitializing = true;
        });
      }

      /// -> Pause current video
      await _controller?.pause();

      /// ->  Update selected quality
      videoDetailsController.selectQuantity = qualityIndex;

      /// ->  Remove old listener
      _controller?.removeListener(_videoListener);

      /// ->  Dispose current controller
      await _controller?.dispose();

      if (!mounted) return; // Check if widget is still mounted

      /// ->  Create new controller with new quality URL
      _controller = VideoPlayerController.networkUrl(
          Uri.parse(videoDetailsController.qualityList[qualityIndex].qualityUrl)
      );

      /// ->  Initialize new controller
      await _controller?.initialize();

      if (!mounted) return; // Check again after async operation

      // Restore previous state
      await _controller?.seekTo(currentPosition);
      await _controller?.setVolume(currentVolume);
      await _controller?.setPlaybackSpeed(currentSpeed);

      /// ->  Resume playing if it was playing before
      if (wasPlaying) {
        await _controller?.play();
      }

      // Re-add listener
      _controller?.addListener(_videoListener);

      if (mounted) {
        setState(() {
          _controlsVisible = true;
          _isInitializing = false;
        });
      }

      log('Quality changed to: ${videoDetailsController.qualityList[qualityIndex].qualityName}');

    } catch (e) {
      log('Error changing quality: $e');
      if (mounted) {
        setState(() {
          _controlsVisible = true;
          _isInitializing = false;
          _initializationError = 'Failed to change quality: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// ->  Show loading while initializing
    if (_isInitializing || _controller == null) {
      return Center(
        child: Container(
          height: 210,
          width: size(context).width,
          decoration: const BoxDecoration(
              color: ColorRes.black
          ),
          child: const Center(
            child: CircularProgressIndicator(color: ColorRes.white),
          ),
        ),
      );
    }

    /// ->  Show error if initialization failed
    if (_initializationError != null) {
      return Center(
        child: Container(
          height: 210,
          width: size(context).width,
          decoration: const BoxDecoration(color: ColorRes.black),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: ColorRes.white, size: 48),
                const SizedBox(height: 16),
                const Text(
                  'Failed to load video',
                  style: TextStyle(color: ColorRes.white, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _initializeVideo(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    /// ->  Show video player when initialized
    if (_controller?.value.isInitialized ?? false) {
      return GetBuilder<VideoDetailsController>(builder: (videoDetailsController){
        return WillPopScope(
          onWillPop: () async {
            if(_controller?.value.isPlaying ?? false){
              _onScreenExitThenOverlayEntry();
            } else{
              Get.back();
            }
            return false;
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _controlsVisible = !_controlsVisible;
                  });
                },
                child: AspectRatio(
                  aspectRatio: _controller?.value.aspectRatio ?? 16/9,
                  child: Stack(
                    children: [
                      /// ->  Video Player
                      if (_controller != null) VideoPlayer(_controller!),

                      /// ->  Display image when the video is paused or hasn't started
                      if (!(_controller?.value.isPlaying ?? true))
                        Positioned.fill(
                          child: GlobalImageLoader(
                              imagePath: widget.initImg,
                              fit: BoxFit.cover,
                              imageFor: ImageFor.network
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (!(_controller?.value.isPlaying ?? true))
                Positioned.fill(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        (_controller?.value.isPlaying ?? false) ? _controller?.pause() : _controller?.play();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorRes.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),

              if (_controlsVisible)
                Positioned.fill(
                  child: SizedBox(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          // Previous Button
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  final newPosition = (_controller?.value.position ?? Duration.zero) - const Duration(seconds: 10);
                                  _controller?.seekTo(newPosition < const Duration(seconds: 0) ? const Duration(seconds: 0) : newPosition);
                                  videoDetailsController.handleClick(false);
                                });
                              },
                              child: Container(
                                height: 50,
                                color: Colors.transparent,
                                child: const Center(
                                  child: GlobalImageLoader(
                                    imagePath: Images.previousIc,
                                    height: 15,
                                    width: 15,
                                    color: ColorRes.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: (){
                              setState(() {
                                (_controller?.value.isPlaying ?? false) ? _controller?.pause() : _controller?.play();
                              });
                            },
                            child: Icon(
                              (_controller?.value.isPlaying ?? false) ? Icons.pause : Icons.play_arrow, size: 40,
                              color: ColorRes.white,
                            ),
                          ),

                          // Next Button
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  final newPosition = (_controller?.value.position ?? Duration.zero) + const Duration(seconds: 10);
                                  _controller?.seekTo(newPosition > (_controller?.value.duration ?? Duration.zero) ? (_controller?.value.duration ?? Duration.zero) : newPosition);
                                  videoDetailsController.handleClick(true);
                                });
                              },
                              child: Container(
                                height: 50,
                                color: Colors.transparent,
                                child: const Center(
                                  child: GlobalImageLoader(
                                    imagePath: Images.nextIc,
                                    height: 15,
                                    width: 15,
                                    color: ColorRes.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              /// ->  Message display
              if (videoDetailsController.isMessageVisible)
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      color: Colors.black54,
                      child: Text(
                        videoDetailsController.displayMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

              /// ->  Progress bar
              if (_controlsVisible)
                Positioned(
                  bottom: 0, right: 0, left: 0,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (dts) {
                      setState(() {
                        final newPosition = (_controller?.value.duration ?? Duration.zero) * (dts.localPosition.dx / MediaQuery.of(context).size.width);
                        _controller?.seekTo(newPosition);
                      });
                    },
                    child: SizedBox(
                      height: 9,
                      child: VideoProgressIndicator(
                        _controller!,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          playedColor: ColorRes.appRedColor,
                          backgroundColor: ColorRes.grey,
                          bufferedColor: ColorRes.white,
                        ),
                      ),
                    ),
                  ),
                ),

              /// ->  Back button
              if (_controlsVisible)
                Positioned(
                  top: 8,
                  left: 5,
                  child: GestureDetector(
                    onTap: () {
                      if(_controller?.value.isPlaying ?? false){
                        _onScreenExitThenOverlayEntry();
                      } else{
                        Get.back();
                      }
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        color: Colors.transparent,
                        child: (_controller?.value.isPlaying ?? false) ? const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: ColorRes.grey,
                          size: 25,
                        ) : const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: ColorRes.grey,
                          size: 18,
                        )
                    ),
                  ),
                ),

              /// -> Settings button
              if (_controlsVisible)
                Positioned(
                  top: 8,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (ctx){
                            return VideoDetailsSettingsScreen(
                              onSpeedSelected: (speed) {
                                _setPlaybackSpeed(speed);
                              },
                              onQualitySelected: (qualityIndex) {
                                _changeVideoQuality(qualityIndex);
                              },
                            );
                          }
                      );
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      color: Colors.transparent,
                      child: const Icon(
                        Icons.settings_outlined,
                        color: ColorRes.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),

              /// -> Volume and fullscreen controls
              if (_controlsVisible)
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              _isMuted = !_isMuted;
                              _controller?.setVolume(_isMuted ? 0.00 : 1.00);
                            });
                          },
                          child: Icon(
                              _isMuted ? Icons.volume_off : Icons.volume_up,
                              color: ColorRes.white,
                              size: 22
                          )
                      ),

                      sizedBoxW(10),
                      GestureDetector(
                          onTap: (){
                            Get.to(()=> FullScreenVideoPlayer(
                              controller: _controller!,
                              initialMute: _isMuted,
                            ));
                          },
                          child: const Icon(Icons.fullscreen,
                              color: ColorRes.white,
                              size: 22
                          )
                      ),
                    ],
                  ),
                ),

              /// -> Time display
              if (_controlsVisible)
                Positioned(
                  left: 5,
                  bottom: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: _controller!,
                        builder: (ctx, val, child) {
                          return Text(
                            videoDetailsController.formatDuration(val.position),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                      const Text(" / ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: _controller!,
                        builder: (ctx, val, child) {
                          return Text(
                            videoDetailsController.formatDuration(val.duration),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      });
    } else {
      /// ->  Show loading while video is initializing
      return Center(
        child: Container(
          height: 210,
          width: size(context).width,
          decoration: const BoxDecoration(
              color: ColorRes.black
          ),
          child: const Center(
            child: CircularProgressIndicator(color: ColorRes.white),
          ),
        ),
      );
    }
  }
}
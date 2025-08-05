
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/features/video_details/controller/video_details_controller.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/constants/images.dart';
import 'package:ott_app/src/global/widget/global_image_loader.dart';
import 'package:video_player/video_player.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../full_screen_video_player.dart';
import '../components/video_detatils_setting_screen.dart';

class VideoPlayerDetailsWidget extends StatefulWidget {
  const VideoPlayerDetailsWidget({super.key});

  @override
  State<VideoPlayerDetailsWidget> createState() => _VideoPlayerDetailsWidgetState();
}

class _VideoPlayerDetailsWidgetState extends State<VideoPlayerDetailsWidget> {
  late VideoPlayerController _controller;
  bool _controlsVisible = true;

  final videoDetailsController = Get.find<VideoDetailsController>();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoDetailsController.videoSrc))
      ..initialize().then((_) {
        setState(() {});
      });

    // Add listener to handle video end event
    _controller.addListener(_videoListener);
    videoDetailsController.initialSpeed = null;

  }

  void _videoListener() {
    if (_controller.value.position == _controller.value.duration) {
      setState(() {
        _controlsVisible = true;
      });
    }
    if (_controller.value.hasError) {
      log('VideoPlayer Error: ${_controller.value.errorDescription}');
    }
  }

  bool _isMuted = false;

  Future<void> _onScreenExitThenOverlayEntry() async {
    videoDetailsController.showMiniPlayerOverlay(
      context: context,
      controller: _controller,
    );
    // await Future.delayed(const Duration(milliseconds: 200));  // Delay transition
    // Get.back();  // Navigate back after showing the mini player
  }

  void _setPlaybackSpeed(double speed) {
    videoDetailsController.initialSpeed = speed;
    _controller.setPlaybackSpeed(speed);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (_controller.value.isInitialized) {
      return GetBuilder<VideoDetailsController>(builder: (videoDetailsController){
        return WillPopScope(
          onWillPop: () async {
            if(_controller.value.isPlaying){
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
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    children: [
                      // Video Player
                      VideoPlayer(_controller),

                      // Display image when the video is paused or hasn't started
                      if (!_controller.value.isPlaying)
                        Positioned.fill(
                          child: Image.asset(
                            videoDetailsController.initImg, // Replace with actual image path
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (!_controller.value.isPlaying)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        _controller.value.isPlaying ? _controller.pause() : _controller.play();
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
                                  final newPosition = _controller.value.position - const Duration(seconds: 10);
                                  _controller.seekTo(newPosition < const Duration(seconds: 0) ? const Duration(seconds: 0) : newPosition);
                                  videoDetailsController.handleClick(false); // Call to handle rewind click
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
                                _controller.value.isPlaying ? _controller.pause() : _controller.play();
                              });
                            },
                            child: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow, size: 40,
                              color: ColorRes.white,
                            ),
                          ),

                          // Next Button
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  final newPosition = _controller.value.position + const Duration(seconds: 10);
                                  _controller.seekTo(newPosition > _controller.value.duration ? _controller.value.duration : newPosition);
                                  videoDetailsController.handleClick(true); // Call to handle forward click
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

              // Message display
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

              // Other UI elements...
              if (_controlsVisible)
                Positioned(
                  bottom: 0, right: 0, left: 0,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (dts) {
                      setState(() {
                        final newPosition = _controller.value.duration * (dts.localPosition.dx / MediaQuery.of(context).size.width);
                        _controller.seekTo(newPosition);
                      });
                    },
                    child: SizedBox(
                      height: 9,
                      child: VideoProgressIndicator(
                        _controller,
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

              if (_controlsVisible)
                Positioned(
                  top: 8,
                  left: 5,
                  child: GestureDetector(
                    onTap: () {
                      if(_controller.value.isPlaying){
                        _onScreenExitThenOverlayEntry();
                      } else{
                        Get.back();
                      }
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        color: Colors.transparent,
                        child: _controller.value.isPlaying ? const Icon(
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


              if (_controlsVisible)
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap:(){
                            setState(() {
                              _isMuted = !_isMuted;
                              _controller.setVolume(_isMuted ? 0.00 : 1.00);
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
                              controller: _controller,
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

              if (_controlsVisible)
                Positioned(
                  left: 5,
                  bottom: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: _controller,
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
                        valueListenable: _controller,
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

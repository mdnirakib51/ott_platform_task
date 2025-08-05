
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/constants/enum.dart';
import 'package:ott_app/src/global/widget/global_image_loader.dart';
import 'package:video_player/video_player.dart';
import '../../../../global/widget/global_sized_box.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoSrc;
  final String initImg;
  final bool? close;
  const VideoPlayerWidget({
    super.key,
    required this.videoSrc,
    required this.initImg,
    this.close,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoFuture;

  @override
  void initState() {
    super.initState();
    _initializeVideoFuture = _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      log("Video Src: ${widget.videoSrc}");
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoSrc),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: true,
        ),
      );

      await _controller.initialize();
      setState(() {});

      _controller.addListener(() {
        if (_controller.value.position == _controller.value.duration) {
          setState(() {});
        }
      });
    } catch (e, s) {
      log('Error initializing video: $e', error: e, stackTrace: s);
    }
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isMuted = false;
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_controller.value.isInitialized) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Material(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.value.isPlaying ? _controller.pause() : _controller.play();
                            });
                          },
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Stack(
                              children: [
                                VideoPlayer(_controller),

                                if (!_controller.value.isPlaying)
                                  Positioned.fill(
                                    child: GlobalImageLoader(
                                      imagePath: widget.initImg,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          right: 8,
                          left: 35,
                          child: GestureDetector(
                            onHorizontalDragUpdate: (dts) {
                              // Lock to avoid race conditions
                              setState(() {
                                if (_controller.value.isInitialized) {
                                  final newPosition = _controller.value.duration *
                                      (dts.localPosition.dx / MediaQuery.of(context).size.width);
                                  _controller.seekTo(newPosition);
                                }
                              });
                            },
                            child: _controller.value.isInitialized
                                ? VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: ColorRes.appRedColor,
                                backgroundColor: ColorRes.grey,
                                bufferedColor: ColorRes.white,
                              ),
                            )
                                : const SizedBox.shrink(),
                          ),
                        ),

                        Positioned(
                          left: 5,
                          bottom: 5,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.value.isPlaying ? _controller.pause() : _controller.play();
                              });
                            },
                            child: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 20,
                              color: ColorRes.white,
                            ),
                          ),
                        ),
                        widget.close == true
                            ? Positioned(
                          right: 10,
                          top: 10,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.close,
                              size: 20,
                              color: ColorRes.white,
                            ),
                          ),
                        )
                            : const SizedBox.shrink(),
                        Positioned(
                          right: 10,
                          bottom: 25,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isMuted = !_isMuted;
                                    _controller.setVolume(_isMuted ? 0.00 : 1.00);
                                  });
                                },
                                child: Icon(
                                  _isMuted ? Icons.volume_off : Icons.volume_up,
                                  color: ColorRes.red,
                                  size: 18,
                                ),
                              ),
                              sizedBoxW(10),
                              ValueListenableBuilder<VideoPlayerValue>(
                                valueListenable: _controller,
                                builder: (ctx, val, child) {
                                  return Text(
                                    formatDuration(val.position),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                              const Text(
                                " / ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ValueListenableBuilder<VideoPlayerValue>(
                                valueListenable: _controller,
                                builder: (ctx, val, child) {
                                  return Text(
                                    formatDuration(val.duration),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                height: 210,
                width: size(context).width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    color: ColorRes.black
                ),
                child: const Center(
                  child: CircularProgressIndicator(color: ColorRes.white),
                ),
              ),
            );
          }
        } else {
          return Center(
            child: Container(
              height: 210,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(color: ColorRes.black),
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorRes.white,
                ),
              ),
            ),
          );

        }
      },
    );
  }
}

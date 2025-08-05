
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_sized_box.dart';
import '../controller/video_details_controller.dart';
import 'video_details_screen.dart';

class MiniScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  const MiniScreenVideoPlayer({
    super.key,
    required this.controller
  });

  @override
  State<MiniScreenVideoPlayer> createState() => _MiniScreenVideoPlayerState();
}

class _MiniScreenVideoPlayerState extends State<MiniScreenVideoPlayer> {

  late VideoPlayerController _controller;
  Offset position = const Offset(0, 0); // Initial position
  Offset dragStart = Offset.zero; // Start position of drag

  final videoDetailsController = Get.find<VideoDetailsController>();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    // _controller = VideoPlayerController.networkUrl(Uri.parse(videoDetailsController.videoSrc))
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });

    // Add listener to handle video end event
    _controller.addListener(_videoListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set initial position to the bottom right of the screen
      final renderBox = context.findRenderObject() as RenderBox;
      final screenSize = MediaQuery.of(context).size;
      position = Offset(screenSize.width - renderBox.size.width, screenSize.height - renderBox.size.height);
      setState(() {});
    });
  }

  void _videoListener() {
    if (_controller.value.hasError) {
      // Handle codec or playback errors
      log('VideoPlayer Error: ${_controller.value.errorDescription}');
    }
    if (_controller.value.position == _controller.value.duration) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoDetailsController>(builder: (videoDetailsController){
      return Positioned(
        left: position.dx,
        top: position.dy,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              position = Offset(position.dx + details.delta.dx, position.dy + details.delta.dy);
            });
          },
          child: Container(
            height: 150,
            width: 250,
            color: Colors.black,
            margin: const EdgeInsets.only(
                right: 5,
                bottom: 5
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
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

                Positioned.fill(
                  child: SizedBox(
                    child: Center(
                      child: GestureDetector(
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
                    ),
                  ),
                ),

                Positioned(
                  right: 10,
                  top: 10,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            videoDetailsController.removeMiniPlayerOverlay();
                            Get.to(() => const VideoDetailsScreen());
                          },
                          child: const Icon(
                              Icons.open_in_full,
                              color: ColorRes.white,
                              size: 20
                          )
                      ),

                      sizedBoxW(10),
                      GestureDetector(
                          onTap: (){
                            videoDetailsController.removeMiniPlayerOverlay();
                          },
                          child: const Icon(Icons.close,
                              color: ColorRes.white,
                              size: 20
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}


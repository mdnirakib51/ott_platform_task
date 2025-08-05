
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/images.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../controller/video_details_controller.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final bool initialMute;

  const FullScreenVideoPlayer({
    super.key,
    required this.controller,
    required this.initialMute,
  });

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {

  late VideoPlayerController _controller;
  late bool _isMute;

  @override
  void initState() {
    super.initState();
    _isMute = widget.initialMute;
    _controller = widget.controller;

    // Force landscape orientation on full-screen entry
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // Add listener to handle video end event
    _controller.addListener(_videoListener);

  }

  void _videoListener() {
    if (_controller.value.position == _controller.value.duration) {
      setState(() {
        _controlsVisible = true;
      });
    }
  }

  bool _controlsVisible = true;
  void toggleControlsVisibility() {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoDetailsController>(builder: (videoDetailsController){
      return WillPopScope(
        onWillPop: () async {
          videoDetailsController.exitFullScreen();
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              GestureDetector(
                onTap: toggleControlsVisibility,
                child: SizedBox(
                  height: size(context).height,
                  width: size(context).width,
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
                              videoDetailsController.initImg,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!_controller.value.isPlaying)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
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
                                height: 100,
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
                                height: 100,
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

              if (_controlsVisible)
                Positioned(
                  bottom: 20,
                  right: 10,
                  left: 10,
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
                  top: 30,
                  left: 10,
                  child: SizedBox(
                    width: size(context).width,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            videoDetailsController.exitFullScreen();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            color: Colors.transparent,
                            child: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: ColorRes.grey,
                              size: 25,
                            ),
                          ),
                        ),

                        sizedBoxW(10),
                        const GlobalText(
                          str: "Jack Reacher: Never Go Back",
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        )
                      ],
                    ),
                  ),
                ),

              if (_controlsVisible)
                Positioned(
                  right: 10,
                  bottom: 35,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMute = !_isMute;
                            _controller.setVolume(_isMute ? 0.0 : 1.0);
                          });
                        },
                        child: Icon(
                          _isMute ? Icons.volume_off : Icons.volume_up,
                          color: ColorRes.white,
                          size: 25,
                        ),
                      ),
                      sizedBoxW(10),
                      GestureDetector(
                        onTap: () {
                          videoDetailsController.exitFullScreen();
                        },
                        child: const Icon(
                          Icons.fullscreen_exit,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),

              if (_controlsVisible)
                Positioned(
                  left: 10,
                  bottom: 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: _controller,
                        builder: (ctx, val, child) {
                          return GlobalText(
                            str: videoDetailsController.formatDuration(val.position),
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          );
                        },
                      ),
                      const GlobalText(
                        str: " / ",
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: _controller,
                        builder: (ctx, val, child) {
                          return GlobalText(
                            str: videoDetailsController.formatDuration(val.position),
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          );
                        },
                      ),
                    ],
                  ),
                ),

            ],
          ),
        ),
      );
    });
  }
}

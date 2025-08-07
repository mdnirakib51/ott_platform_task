
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/widget/global_container.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../controller/video_details_controller.dart';
import 'widget/video_player_details_widget.dart';

class VideoDetailsScreen extends StatefulWidget {
  final String? imdbId;
  const VideoDetailsScreen({
    super.key,
    this.imdbId
  });
  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Reset to portrait mode when exiting full-screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);

    final videoDetailsCon = VideoDetailsController.current;
    videoDetailsCon.getVideoDetails(imdbId: widget.imdbId ?? "");
  }

  bool isExploreClick = false;
  List<String> exploreList = [
    "Latest Shows",
    "Latest Movies",
    "Upcoming on NP",
    "All Shows",
    "All Movies",
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoDetailsController>(builder: (videoDetailsController){
      return Scaffold(
        key: scaffoldKey,
        body: GlobalContainer(
          height: size(context).height,
          width: size(context).width,
          color: ColorRes.appBackColor,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll){
              overScroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBoxH(25),

                  // ==# Video Player
                  VideoPlayerDetailsWidget(
                    initImg: videoDetailsController.videoListModel?.poster ?? ""
                  ),

                  sizedBoxH(10),
                  Container(
                    width: size(context).width,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        GlobalText(
                          str: videoDetailsController.videoListModel?.title ?? "Loading...",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),

                        // Genre and Year
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const GlobalText(
                              str: "Genres: ",
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorRes.appRedColor,
                            ),
                            Expanded(
                              child: GlobalText(
                                str: videoDetailsController.videoListModel?.genre ?? "N/A",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        // Released date and runtime
                        Row(
                          children: [
                            GlobalText(
                              str: videoDetailsController.videoListModel?.released ?? "N/A",
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            if (videoDetailsController.videoListModel?.runtime != null) ...[
                              const GlobalText(
                                str: " • ",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              GlobalText(
                                str: videoDetailsController.videoListModel?.runtime ?? "",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ],
                        ),

                        // Rating and votes
                        if (videoDetailsController.videoListModel?.imdbRating != null) ...[
                          sizedBoxH(5),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              sizedBoxW(4),
                              GlobalText(
                                str: "${videoDetailsController.videoListModel!.imdbRating}/10",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                              if (videoDetailsController.videoListModel?.imdbVotes != null) ...[
                                sizedBoxW(8),
                                GlobalText(
                                  str: "(${videoDetailsController.videoListModel!.imdbVotes} votes)",
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ],
                            ],
                          ),
                        ],

                        sizedBoxH(10),

                        // Plot/Description
                        SizedBox(
                          child: GlobalText(
                            str: videoDetailsController.videoListModel?.plot ?? "Description not available.",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            fontSize: 10,
                          ),
                        ),

                        // Director and Actors
                        if (videoDetailsController.videoListModel?.director != null) ...[
                          sizedBoxH(8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const GlobalText(
                                str: "Director: ",
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: ColorRes.appRedColor,
                              ),
                              Expanded(
                                child: GlobalText(
                                  str: videoDetailsController.videoListModel!.director!,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],

                        if (videoDetailsController.videoListModel?.actors != null) ...[
                          sizedBoxH(4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const GlobalText(
                                str: "Cast: ",
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: ColorRes.appRedColor,
                              ),
                              Expanded(
                                child: GlobalText(
                                  str: videoDetailsController.videoListModel?.actors ?? "",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],

                        // Additional ratings
                        if (videoDetailsController.videoListModel?.ratings != null && (videoDetailsController.videoListModel?.ratings?.isNotEmpty ?? false)) ...[
                          sizedBoxH(8),
                          SizedBox(
                            height: 25,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: videoDetailsController.videoListModel!.ratings!.length,
                              itemBuilder: (context, index) {
                                final rating = videoDetailsController.videoListModel!.ratings![index];
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 0.5),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GlobalText(
                                        str: _getShortSource(rating.source ?? ""),
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: ColorRes.appRedColor,
                                      ),
                                      sizedBoxW(4),
                                      GlobalText(
                                        str: rating.value ?? "",
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  String _getShortSource(String source) {
    switch (source.toLowerCase()) {
      case 'internet movie database':
        return 'IMDb';
      case 'rotten tomatoes':
        return 'RT';
      case 'metacritic':
        return 'Meta';
      default:
        return source.length > 10 ? source.substring(0, 10) : source;
    }
  }

}

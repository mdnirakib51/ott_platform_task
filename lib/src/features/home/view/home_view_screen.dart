
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ott_app/src/global/constants/enum.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/images.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../search/controller/search_controller.dart';
import '../../video_details/view/video_details_screen.dart';
import '../model/demo_model/movie_model.dart';
import 'widget/carousel_slider_widget.dart';
import 'widget/movie_menu_bar_widget.dart';
import 'widget/movie_menu_widget.dart';
import 'widget/social_menu_widget.dart';
import 'widget/video_player_widget.dart';

class HomeViewScreen extends StatefulWidget {
  const HomeViewScreen({super.key});

  @override
  State<HomeViewScreen> createState() => _HomeViewScreenState();
}

class _HomeViewScreenState extends State<HomeViewScreen> {

  // =/# Carousel Slider
  int currentIndex = 0;
  final carouselController = CarouselSliderController();
  // List<MovieModel> movieList = [
  //   MovieModel(img: Images.justiceLeagueImg, text: "Justice League", subText: "Vor vielen Jahrtausenden versuchte der Superschurke Steppenwolf mit seinen Legionen aus Paradämonen zu erobern. Ein Bündnis aus Menschen, Amazonen, Olympischen Götter und den Green Lanterns konnte die Invasion verhindern. Nach dem Ableben von Superman in „Batman v Superman: Dawn of Justice“ stürzt sich Steppenwolf erneut auf die Erde und raubt den Amazonen eine der drei mächtigen Mutterboxen. Währenddessen scharrt Batman die verbliebenen Superhelden Wonder Woman, The Flash, Aquaman und Cyborg um sich und gründet damit die Justice League. Bevor sich Steppenwolf alle drei Artefakte unter den Nagel reißen kann, nutzen die Superhelden eine der Boxen um Superman wiederzubeleben."),
  //   MovieModel(img: Images.johnWickCharter2Img, text: "John Wick Two", subText: "Vor vielen Jahrtausenden versuchte der Superschurke Steppenwolf mit seinen Legionen aus Paradämonen zu erobern. Ein Bündnis aus Menschen, Amazonen, Olympischen Götter und den Green Lanterns konnte die Invasion verhindern. Nach dem Ableben von Superman in „Batman v Superman: Dawn of Justice“ stürzt sich Steppenwolf erneut auf die Erde und raubt den Amazonen eine der drei mächtigen Mutterboxen. Währenddessen scharrt Batman die verbliebenen Superhelden Wonder Woman, The Flash, Aquaman und Cyborg um sich und gründet damit die Justice League. Bevor sich Steppenwolf alle drei Artefakte unter den Nagel reißen kann, nutzen die Superhelden eine der Boxen um Superman wiederzubeleben."),
  //   MovieModel(img: Images.porineetaImg, text: "Porineeta", subText: "Vor vielen Jahrtausenden versuchte der Superschurke Steppenwolf mit seinen Legionen aus Paradämonen zu erobern. Ein Bündnis aus Menschen, Amazonen, Olympischen Götter und den Green Lanterns konnte die Invasion verhindern. Nach dem Ableben von Superman in „Batman v Superman: Dawn of Justice“ stürzt sich Steppenwolf erneut auf die Erde und raubt den Amazonen eine der drei mächtigen Mutterboxen. Währenddessen scharrt Batman die verbliebenen Superhelden Wonder Woman, The Flash, Aquaman und Cyborg um sich und gründet damit die Justice League. Bevor sich Steppenwolf alle drei Artefakte unter den Nagel reißen kann, nutzen die Superhelden eine der Boxen um Superman wiederzubeleben."),
  //   MovieModel(img: Images.golamMamunImg, text: "Golam Mamun", subText: "Vor vielen Jahrtausenden versuchte der Superschurke Steppenwolf mit seinen Legionen aus Paradämonen zu erobern. Ein Bündnis aus Menschen, Amazonen, Olympischen Götter und den Green Lanterns konnte die Invasion verhindern. Nach dem Ableben von Superman in „Batman v Superman: Dawn of Justice“ stürzt sich Steppenwolf erneut auf die Erde und raubt den Amazonen eine der drei mächtigen Mutterboxen. Währenddessen scharrt Batman die verbliebenen Superhelden Wonder Woman, The Flash, Aquaman und Cyborg um sich und gründet damit die Justice League. Bevor sich Steppenwolf alle drei Artefakte unter den Nagel reißen kann, nutzen die Superhelden eine der Boxen um Superman wiederzubeleben."),
  // ];

  // =/# Resent
  List<MovieModel> recentList = [
    MovieModel(img: Images.porineetaImg, text: "Porineeta", subText: "Free"),
    MovieModel(img: Images.dharmajuddhaImg, text: "Dharmajuddha", subText: "Premium"),
    MovieModel(img: Images.golamMamunImg, text: "Golam Mamun", subText: "Premium"),
    MovieModel(img: Images.porineetaImg, text: "Porineeta", subText: "Free"),
    MovieModel(img: Images.dharmajuddhaImg, text: "Dharmajuddha", subText: "Premium"),
    MovieModel(img: Images.golamMamunImg, text: "Golam Mamun", subText: "Premium"),
  ];

  bool isExploreClick = false;
  List<String> exploreList = [
    "Latest Shows",
    "Latest Movies",
    "Upcoming on NP",
    "All Shows",
    "All Movies",
  ];

  @override
  void initState() {
    super.initState();
    final searchBarController = SearchBarController.current;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Future.wait({
        searchBarController.fetchMovies(search: 'batman'),
        searchBarController.fetchRecent(search: 'jaws', year: '2025'),
        searchBarController.fetchSeries(search: 'batman', year: '2022'),
      });
    });

  }
  //
  // @override
  // void dispose() {
  //   final homePageController = HomePageController.current;
  //   homePageController.disposeListener();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchBarController>(builder: (searchBarController) {
      return SingleChildScrollView(
        // controller: homePageController.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ==# Carousel Slider Screen
            CarouselSlider(
              carouselController: carouselController,
              items: searchBarController.movieModel?.search?.map((item) =>
                  CarouselSliderWidget(
                    imdbId: item.imdbID ?? "",
                    img: item.poster ?? "",
                    text: item.title ?? "",
                    subText: "Vor vielen Jahrtausenden versuchte der Superschurke Steppenwolf mit seinen Legionen aus Paradämonen zu erobern. Ein Bündnis aus Menschen, Amazonen, Olympischen Götter und den Green Lanterns konnte die Invasion verhindern. Nach dem Ableben von Superman in „Batman v Superman: Dawn of Justice“ stürzt sich Steppenwolf erneut auf die Erde und raubt den Amazonen eine der drei mächtigen Mutterboxen. Währenddessen scharrt Batman die verbliebenen Superhelden Wonder Woman, The Flash, Aquaman und Cyborg um sich und gründet damit die Justice League. Bevor sich Steppenwolf alle drei Artefakte unter den Nagel reißen kann, nutzen die Superhelden eine der Boxen um Superman wiederzubeleben.",
                    onTap: (){},
                    watchTrailerOnTap: (){
                      showDialog(
                          context: context,
                          builder: (ctx){
                            return VideoPlayerWidget(
                              videoSrc: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
                              initImg: item.poster ?? "",
                              close: true,
                            );
                          }
                      );
                    },
                  )).toList() ?? [],
              options: CarouselOptions(
                height: 550,
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: false,
                aspectRatio: 2,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GlobalText(
                    str: "Recent",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  sizedBoxH(5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: searchBarController.recentList?.search?.asMap().entries.map((video){
                          return MovieMenuWidget(
                            img: video.value.poster ?? "",
                            text: video.value.title ?? "",
                            subText: "Free",
                            imageFor: ImageFor.network,
                            onTap: (){
                              Get.to(()=> VideoDetailsScreen(imdbId: video.value.imdbID));
                            },
                          );
                        }).toList() ?? []
                    ),
                  )
                ],
              ),
            ),

            sizedBoxH(20),
            const VideoPlayerWidget(
              videoSrc: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
              initImg: Images.justiceLeagueImg,
            ),

            sizedBoxH(10),
            Container(
                width: size(context).width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GlobalText(
                      str: "Justice League",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    const GlobalText(
                      str: "2024",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GlobalText(
                          str: "Genres: ",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorRes.appRedColor,
                        ),
                        GlobalText(
                          str: "Action - Adventure",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),

                    sizedBoxH(10),
                    const SizedBox(
                      child: GlobalText(
                        str: "Steppenwolf and hconst is Parademons return after eons to capture Earth. However, Batman seeks the help of Wonder Woman to recruit and assemble Flash, Cyborg and Aquaman to fight the powerful new enemy.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        fontSize: 13,
                      ),
                    )
                  ],
                )
            ),

            /// ==# Genres
            sizedBoxH(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GlobalText(
                    str: "All Series",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  sizedBoxH(5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: searchBarController.seriesModel?.search?.asMap().entries.map((video){
                          return MovieMenuWidget(
                            img: video.value.poster ?? "",
                            text: video.value.title ?? "",
                            subText: "Free",
                            imageFor: ImageFor.network,
                            onTap: (){
                              Get.to(()=> VideoDetailsScreen(imdbId: video.value.imdbID));
                            },
                          );
                        }).toList() ?? []
                    ),
                  )
                ],
              ),
            ),

            sizedBoxH(10),
            Container(
              width: size(context).width,
              color: ColorRes.black,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  sizedBoxH(15),
                  const GlobalText(
                    str: "OTT Is Offers Superior Live TV Streaming",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  sizedBoxH(10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: recentList.asMap().entries.map((movie){
                          return Container(
                            width: 115,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: ColorRes.appBackColor,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const GlobalImageLoader(
                                  imagePath: Images.starMarkImg,
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.fill,
                                ),
                                sizedBoxH(10),
                                const GlobalText(
                                  str: "SUPER FAST QUALITY",
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),

                                sizedBoxH(10),
                                const GlobalText(
                                  str: "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Doloribus, quibusdam.",
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }).toList()
                    ),
                  ),
                  sizedBoxH(15),
                ],
              ),
            ),

            sizedBoxH(20),
            Container(
              width: size(context).width,
              color: ColorRes.appColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sizedBoxH(10),
                  const GlobalImageText(
                    str: "NP",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),

                  sizedBoxH(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMenuWidget(
                        img: Images.facebookIc,
                        onTap: (){},
                      ),

                      sizedBoxW(10),
                      SocialMenuWidget(
                        img: Images.instagramIc,
                        onTap: (){},
                      ),

                      sizedBoxW(10),
                      SocialMenuWidget(
                        img: Images.linkedInIc,
                        onTap: (){},
                      ),
                    ],
                  ),

                  sizedBoxH(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMenuWidget(
                        img: Images.youtubeIc,
                        onTap: (){},
                      ),

                      sizedBoxW(10),
                      SocialMenuWidget(
                        img: Images.twitterIc,
                        onTap: (){},
                      ),
                    ],
                  ),

                  sizedBoxH(30),
                  Container(
                    width: size(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: ColorRes.white),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isExploreClick = !isExploreClick;
                            });
                          },
                          child: const SizedBox(
                            child: Row(
                              children: [
                                Expanded(
                                  child: GlobalText(
                                    str: "Explore",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: ColorRes.white,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),

                        isExploreClick == true ?
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: exploreList.asMap().entries.map((item){
                                return Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: GlobalText(
                                    str: item.value,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                );
                              }).toList()
                          ),
                        ) : const SizedBox.shrink()
                      ],
                    ),
                  ),

                  sizedBoxH(10),
                  Container(
                    width: size(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: ColorRes.white),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isExploreClick = !isExploreClick;
                            });
                          },
                          child: const SizedBox(
                            child: Row(
                              children: [
                                Expanded(
                                  child: GlobalText(
                                    str: "Company",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: ColorRes.white,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),

                        isExploreClick == true ?
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: exploreList.asMap().entries.map((item){
                                return Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: GlobalText(
                                    str: item.value,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                );
                              }).toList()
                          ),
                        ) : const SizedBox.shrink()
                      ],
                    ),
                  ),

                  sizedBoxH(10),
                  Container(
                    width: size(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: ColorRes.white),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isExploreClick = !isExploreClick;
                            });
                          },
                          child: const SizedBox(
                            child: Row(
                              children: [
                                Expanded(
                                  child: GlobalText(
                                    str: "Contract",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: ColorRes.white,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),

                        isExploreClick == true ?
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: exploreList.asMap().entries.map((item){
                                return Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: GlobalText(
                                    str: item.value,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                );
                              }).toList()
                          ),
                        ) : const SizedBox.shrink()
                      ],
                    ),
                  ),

                  sizedBoxH(20),
                  const GlobalText(
                    str: "Copyright © 2024 NP",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),

                  sizedBoxH(110),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}


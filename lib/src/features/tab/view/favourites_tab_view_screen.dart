
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/images.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../home/controller/home_controller.dart';
import '../../home/model/demo_model/movie_model.dart';
import '../../home/view/widget/movie_menu_bar_widget.dart';
import '../../home/view/widget/movie_menu_widget.dart';

class FavouritesTabViewScreen extends StatefulWidget {
  const FavouritesTabViewScreen({super.key});

  @override
  State<FavouritesTabViewScreen> createState() => _FavouritesTabViewScreenState();
}

class _FavouritesTabViewScreenState extends State<FavouritesTabViewScreen> {

  // =/# Resent
  List<MovieModel> recentList = [
    MovieModel(img: Images.porineetaImg, text: "Porineeta", subText: "Free"),
    MovieModel(img: Images.dharmajuddhaImg, text: "Dharmajuddha", subText: "Premium"),
    MovieModel(img: Images.golamMamunImg, text: "Golam Mamun", subText: "Premium"),
    MovieModel(img: Images.porineetaImg, text: "Porineeta", subText: "Free"),
    MovieModel(img: Images.dharmajuddhaImg, text: "Dharmajuddha", subText: "Premium"),
    MovieModel(img: Images.golamMamunImg, text: "Golam Mamun", subText: "Premium"),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(builder: (homePageController){
      return SingleChildScrollView(
        // controller: homePageController.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBoxH(80),

                  /// ==# Favourites Movie
                  MovieMenuBarWidget(
                      text: "Favourites Movie",
                      onTap: (){

                      }
                  ),
                  sizedBoxH(5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: recentList.asMap().entries.map((movie){
                          return MovieMenuWidget(
                            img: movie.value.img,
                            text: movie.value.text,
                            subText: movie.value.subText,
                            onTap: (){},
                          );
                        }).toList()
                    ),
                  ),

                  /// ==# Favourites Series
                  sizedBoxH(20),
                  MovieMenuBarWidget(
                      text: "Favourites Series",
                      onTap: (){

                      }
                  ),
                  sizedBoxH(5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: recentList.asMap().entries.map((movie){
                          return MovieMenuWidget(
                            img: movie.value.img,
                            text: movie.value.text,
                            subText: movie.value.subText,
                            onTap: (){},
                          );
                        }).toList()
                    ),
                  ),

                  sizedBoxH(100),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

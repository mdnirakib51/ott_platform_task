
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/images.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../home/controller/home_controller.dart';
import '../../home/model/demo_model/movie_model.dart';
import '../../home/view/widget/movie_menu_bar_widget.dart';
import '../../home/view/widget/movie_menu_widget.dart';
import 'components/movie_see_all_screen.dart';

class MovieTabViewScreen extends StatefulWidget {
  const MovieTabViewScreen({super.key});

  @override
  State<MovieTabViewScreen> createState() => _MovieTabViewScreenState();
}

class _MovieTabViewScreenState extends State<MovieTabViewScreen> {

  // =/# Resent
  List<MovieModel> recentList = [
    MovieModel(img: Images.porineetaImg, text: "Porineeta", subText: "Free"),
    MovieModel(img: Images.dharmajuddhaImg, text: "Dharmajuddha", subText: "Premium"),
    MovieModel(img: Images.golamMamunImg, text: "Golam Mamun", subText: "Premium"),
    MovieModel(img: Images.porineetaImg, text: "Porineeta", subText: "Free"),
    MovieModel(img: Images.dharmajuddhaImg, text: "Dharmajuddha", subText: "Premium"),
    MovieModel(img: Images.golamMamunImg, text: "Golam Mamun", subText: "Premium"),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   final homePageController = HomePageController.current;
  //   homePageController.initAddListener();
  // }
  //
  // @override
  // void dispose() {
  //   final homePageController = HomePageController.current;
  //   homePageController.disposeListener();
  //   super.dispose();
  // }

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

                  /// ==# All Movie
                  MovieMenuBarWidget(
                      text: "All Movie",
                      onTap: (){
                        Get.to(()=> const MovieSeeAllScreen());
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

                  /// ==# Romance
                  sizedBoxH(20),
                  MovieMenuBarWidget(
                      text: "Romance",
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

                  /// ==# Sci-Fi
                  sizedBoxH(20),
                  MovieMenuBarWidget(
                      text: "Sci-Fi",
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


                  /// ==# Drama
                  sizedBoxH(20),
                  MovieMenuBarWidget(
                      text: "Drama",
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

                  /// ==# Action
                  sizedBoxH(20),
                  MovieMenuBarWidget(
                      text: "Action",
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

                  /// ==# Thriller
                  sizedBoxH(20),
                  MovieMenuBarWidget(
                      text: "Thriller",
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

                  /// ==# Family
                  sizedBoxH(20),
                  MovieMenuBarWidget(
                      text: "Family",
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

                  /// ==# Musical
                  sizedBoxH(20),
                  MovieMenuBarWidget(
                      text: "Musical",
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

                  /// ==# Adventure
                  sizedBoxH(20),
                  MovieMenuBarWidget(
                      text: "Adventure",
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

                  /// ==# Horror
                  sizedBoxH(20),
                  MovieMenuBarWidget(
                      text: "Horror",
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

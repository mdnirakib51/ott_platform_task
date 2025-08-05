
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/images.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../home/model/demo_model/movie_model.dart';
import '../../home/view/widget/movie_menu_bar_widget.dart';
import '../../home/view/widget/movie_menu_widget.dart';
import 'components/series_see_all_screen.dart';

class SeriesTabViewScreen extends StatefulWidget {
  const SeriesTabViewScreen({super.key});

  @override
  State<SeriesTabViewScreen> createState() => _SeriesTabViewScreenState();
}

class _SeriesTabViewScreenState extends State<SeriesTabViewScreen> {

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxH(80),

                /// ==# All Series
                MovieMenuBarWidget(
                    text: "All Series",
                    onTap: (){
                      Get.to(()=> const SeriesSeeAllScreen());
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
  }
}


import 'package:flutter/material.dart';
import 'package:ott_app/src/global/constants/colors_resources.dart';
import 'package:ott_app/src/global/constants/images.dart';
import 'package:ott_app/src/global/widget/global_container.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../widget/movie_see_all_menu_widget.dart';
import '../widget/global_appbar_widget.dart';

class MovieSeeAllScreen extends StatefulWidget {
  const MovieSeeAllScreen({super.key,});
  @override
  State<MovieSeeAllScreen> createState() => _MovieSeeAllScreenState();
}

class _MovieSeeAllScreenState extends State<MovieSeeAllScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GlobalContainer(
        height: size(context).height,
        width: size(context).width,
        color: ColorRes.appBackColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlobalAppbarWidget(
              title: "Movie",
            ),

            Expanded(
              child: GridView.builder(
                itemCount: 30,
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: size(context).height < 700 ? 1.1 : 1.4,
                ),
                itemBuilder: (ctx, index) {
                  return MovieSeeAllMenuWidget(
                    img: Images.justiceLeagueImg,
                    text: "Justice League",
                    subText: "Free",
                    onTap: () {},
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}

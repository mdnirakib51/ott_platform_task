
import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/constants/images.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import 'widget/download_option_menu_widget.dart';

class DownloadMoreVertScreen extends StatefulWidget {
  const DownloadMoreVertScreen({super.key});

  @override
  State<DownloadMoreVertScreen> createState() => _DownloadMoreVertScreenState();
}

class _DownloadMoreVertScreenState extends State<DownloadMoreVertScreen> {

  int selectLanguage = 0;
  List<String> languageList = [
    "English",
    "বাংলা",
    "हिंदी",
    "عربي",
  ];

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (ctx, buildSetState){
          return Container(
            height: 200,
            width: size(context).width,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                color: ColorRes.appBackColor,
                borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                sizedBoxH(10),
                Container(
                  height: 4,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorRes.grey.withOpacity(0.3)
                  ),
                ),

                sizedBoxH(10),
                const Row(
                  children: [
                    GlobalText(
                      str: "Download Option",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )
                  ],
                ),

                sizedBoxH(10),
                DownloadOptionMenuWidget(
                    img: Images.watchListLaterIc,
                    title: "Save to Watch Later",
                    onTap: (){}
                ),

                DownloadOptionMenuWidget(
                    img: Images.shareIc,
                    title: "Share",
                    onTap: (){}
                ),

                DownloadOptionMenuWidget(
                    img: Images.deleteIc,
                    title: "Delete from download",
                    onTap: (){}
                ),

              ],
            ),
          );
        }
    );
  }
}

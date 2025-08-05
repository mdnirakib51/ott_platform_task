
import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_bottom_widget.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {

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
            height: 400,
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
                      str: "Language Selection",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )
                  ],
                ),

                sizedBoxH(10),

                Expanded(
                  child: ListView.builder(
                      itemCount: languageList.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index){
                        return GestureDetector(
                          onTap: (){
                            buildSetState(() {
                              selectLanguage = index;
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                selectLanguage == index ?
                                Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorRes.appRedColor
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: ColorRes.white,
                                    size: 18,
                                  ),
                                ) : Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: ColorRes.appRedColor,
                                          width: 1
                                      )
                                  ),
                                ),
                                sizedBoxW(15),
                                Expanded(
                                  child: SizedBox(
                                    child: GlobalText(
                                      str: languageList[index],
                                      fontWeight: FontWeight.w500,
                                      color: ColorRes.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                ),

                sizedBoxH(10),
                GlobalButtonWidget(
                  str: "Save",
                  height: 45,
                  buttomColor: ColorRes.appRedColor,
                  textSize: 13,
                  onTap: (){

                  },
                ),
                sizedBoxH(10)

              ],
            ),
          );
        }
    );
  }
}

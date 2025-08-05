
import 'package:flutter/material.dart';
import 'package:ott_app/src/global/widget/global_sized_box.dart';
import '../../../../global/shimmer/shimmer_widget.dart';

Widget searchListShimmer(List<String> itemCount) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
          children: itemCount.asMap().entries.map((item){
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10, bottom: 10),
                  child: ShimmerWidget.circular(
                      height: 85,
                      width: 140,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
                ),
                sizedBoxH(5),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ShimmerWidget.circular(
                            height: 15,
                            width: 100,
                            shapeBorder: RoundedRectangleBorder()
                        ),

                        sizedBoxH(5),
                        const ShimmerWidget.circular(
                            height: 15,
                            width: 70,
                            shapeBorder: RoundedRectangleBorder()
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList()
      ),
    ),
  );
}

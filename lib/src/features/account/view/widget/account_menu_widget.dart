
import 'package:flutter/material.dart';
import '../../../../global/constants/colors_resources.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sized_box.dart';
import '../../../../global/widget/global_text.dart';

class AccountMenuWidget extends StatelessWidget {
  final String img;
  final String title;
  final String? subTitle;
  final Function() onTap;
  const AccountMenuWidget({
    super.key,
    required this.img,
    required this.title,
    this.subTitle,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size(context).width,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  GlobalImageLoader(
                    imagePath: img,
                    height: 22,
                    width: 22,
                    color: ColorRes.grey,
                  ),
                  sizedBoxW(10),
                  subTitle == null ? GlobalText(
                    str: title,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalText(
                        str: title,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      GlobalText(
                        str: subTitle ?? "",
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.grey,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorRes.grey,
              size: 14,
            )
          ],
        ),
      ),
    );
  }
}

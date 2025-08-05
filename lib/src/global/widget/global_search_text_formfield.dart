import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors_resources.dart';
import '../constants/images.dart';
import '../constants/input_decoration.dart';
import 'global_image_loader.dart';
import 'global_sized_box.dart';
import 'global_text.dart';
import 'global_textform_field.dart';


class GlobalSearchTextFormField extends StatelessWidget {
  final String text;
  final String? titleText;
  final Color? color;
  final bool? isRequired;
  final TextStyle? titleStyle;
  final List<String> item;
  final Function onSelect;
  final Function()? barScannerOnPress;
  const GlobalSearchTextFormField({
    super.key,
    required this.text,
    this.titleText,
    this.titleStyle,
    this.color,
    this.isRequired = false,
    required this.item,
    required this.onSelect,
    this.barScannerOnPress
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isRequired == false ?
        titleText == null
            ? const SizedBox.shrink()
            : Text(titleText ?? "",
          style: titleStyle
              ?? const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Bookman"
              ),
        ) : SizedBox(
          child: Row(
            children: [
              titleText == null
                  ? const SizedBox.shrink()
                  : Text(titleText ?? "",
                style: titleStyle
                    ?? const TextStyle(
                        color: ColorRes.deep100,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Rubik'
                    ),
              ),
              sizedBoxW(2),
              const Text("*",
                style: TextStyle(
                    color: ColorRes.appRedColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik'
                ),
              ),
            ],
          ),
        ),
        /// When I give the title text it will take the sizedbox
        titleText != null ? const SizedBox(height: 5) : const SizedBox.shrink(),
        GestureDetector(
          onTap: (){
            Get.dialog(
                GlobalSearchTextFormFieldWidget(
                  titleText: titleText ?? '',
                  dataList: item,
                  onSelect: onSelect,
                )
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorRes.grey, width: 1)
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 8,
                    child: GlobalText(
                      str: text,
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Rubik',
                    )
                ),
                barScannerOnPress != null ? GestureDetector(
                  onTap: barScannerOnPress,
                  child: const GlobalImageLoader(
                    imagePath: Images.deleteIc,
                    height: 18,
                    width: 25,
                    fit: BoxFit.fill,
                  ),
                ) :
                const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: ColorRes.grey,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class GlobalSearchTextFormFieldWidget extends StatefulWidget {
  final String titleText;
  final List<String> dataList;
  final Function onSelect;
  const GlobalSearchTextFormFieldWidget({
    super.key,
    required this.titleText,
    required this.dataList,
    required this.onSelect,
  });

  @override
  State<GlobalSearchTextFormFieldWidget> createState() => _GlobalSearchTextFormFieldWidgetState();
}

class _GlobalSearchTextFormFieldWidgetState extends State<GlobalSearchTextFormFieldWidget> {

  List<String> tempDataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempDataList = widget.dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      insetPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      Images.close,
                      width: 18
                    )
                )
              ),
            ),
            sizedBoxH(10),
            GlobalTextFormField(
              titleText: widget.titleText,
              hintText: "Searching..",
              prefixIcon: const Icon(Icons.search, color: ColorRes.grey, size: 20),
              decoration: borderDecoration,
              isDense: true,
              onChanged: (val){
                if (widget.dataList.isNotEmpty) {
                  setState(() {
                    tempDataList = widget.dataList.where((i) => i.isCaseInsensitiveContains(val)).toList();
                  });
                }
              },
            ),
            sizedBoxH(10),

            tempDataList.isNotEmpty ? Expanded(
              child: SizedBox(
                child: ListView.builder(
                    itemCount: tempDataList.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index){
                      return GestureDetector(
                        onTap: (){
                          widget.onSelect(widget.dataList.indexOf(tempDataList[index]));
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorRes.grey.withOpacity(0.2),
                          ),
                          child: GlobalText(
                            str: tempDataList[index],
                            color: ColorRes.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Rubik',
                          ),
                        ),
                      );
                    }
                ),
              ),
            ) : const Expanded(
                child: Center(
                  child: GlobalText(
                    str: "No Data Found",
                    color: ColorRes.deep100,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    fontFamily: 'Rubik',
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}


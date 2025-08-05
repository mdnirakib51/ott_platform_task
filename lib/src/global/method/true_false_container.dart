//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../constants/colors_resources.dart';
// import '../widget/global_sized_box.dart';
// import '../widget/global_text.dart';
//
// class TrueFalseContainer extends StatelessWidget {
//   final bool currentValue;
//   final String trueText;
//   final String falseText;
//   final ValueChanged<bool> onChange;
//
//   const TrueFalseContainer({
//     super.key,
//     required this.currentValue,
//     required this.trueText,
//     required this.falseText,
//     required this.onChange,
//   });
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Get.width,
//       margin: const EdgeInsets.only(left: 10, right: 10),
//       padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: ColorRes.white,
//           boxShadow: [
//             BoxShadow(
//                 color: ColorRes.grey.withOpacity(0.3),
//                 blurRadius: 5
//             )
//           ]
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: () => onChange(true),
//               child: Column(
//                 children: [
//                   GlobalText(
//                     str: trueText,
//                     color: ColorRes.primaryColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     textAlign: TextAlign.center,
//                     fontFamily: 'Rubik',
//                   ),
//                   sizedBoxH(8),
//                   Container(
//                     height: 7,
//                     width: Get.width,
//                     decoration: BoxDecoration(
//                       color: currentValue ? ColorRes.blueColor : Colors.transparent,
//                       borderRadius: BorderRadius.circular(4)
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: InkWell(
//               onTap: () => onChange(false),
//               highlightColor: Colors.black38,
//               child: Column(
//                 children: [
//                   GlobalText(
//                     str: falseText,
//                     color: ColorRes.primaryColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     textAlign: TextAlign.center,
//                     fontFamily: 'Rubik',
//                   ),
//                   sizedBoxH(8),
//                   // Expanded(child: Container()),
//                   Container(
//                     height: 7,
//                     width: Get.width,
//                     decoration: BoxDecoration(
//                       color: currentValue ? Colors.transparent : ColorRes.blueColor,
//                       borderRadius: BorderRadius.circular(4)
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class ThreeOptionContainer extends StatefulWidget {
//   final int currentValue;
//   final String firstText;
//   final String secondText;
//   final String thirdText;
//   final ValueChanged<int> onChange;
//
//   const ThreeOptionContainer({
//     super.key,
//     required this.currentValue,
//     required this.firstText,
//     required this.secondText,
//     required this.thirdText,
//     required this.onChange,
//   });
//
//   @override
//   State<ThreeOptionContainer> createState() => _ThreeOptionContainerState();
// }
//
// class _ThreeOptionContainerState extends State<ThreeOptionContainer> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Get.width,
//       margin: const EdgeInsets.only(left: 10, right: 10),
//       padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: ColorRes.white,
//           boxShadow: [
//             BoxShadow(
//                 color: ColorRes.grey.withOpacity(0.3),
//                 blurRadius: 5
//             )
//           ]
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: (){
//                 setState(() {
//                   widget.onChange(0);
//                 });
//               },
//               child: Column(
//                 children: [
//                   GlobalText(
//                     str: widget.firstText,
//                     color: ColorRes.primaryColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     textAlign: TextAlign.center,
//                     fontFamily: 'Rubik',
//                   ),
//                   sizedBoxH(8),
//                   Container(
//                     height: 7,
//                     width: Get.width,
//                     decoration: BoxDecoration(
//                         color: widget.currentValue == 0 ? ColorRes.blueColor : Colors.transparent,
//                         borderRadius: BorderRadius.circular(4)
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//
//           Expanded(
//             child: InkWell(
//               onTap: (){
//                 setState(() {
//                   widget.onChange(1);
//                 });
//               },
//               child: Column(
//                 children: [
//                   GlobalText(
//                     str: widget.secondText,
//                     color: ColorRes.primaryColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     textAlign: TextAlign.center,
//                     fontFamily: 'Rubik',
//                   ),
//                   sizedBoxH(8),
//                   Container(
//                     height: 7,
//                     width: Get.width,
//                     decoration: BoxDecoration(
//                         color: widget.currentValue == 1 ? ColorRes.blueColor : Colors.transparent,
//                         borderRadius: BorderRadius.circular(4)
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//
//           Expanded(
//             child: InkWell(
//               onTap: (){
//                 setState(() {
//                   widget.onChange(2);
//                 });
//               },
//               child: Column(
//                 children: [
//                   GlobalText(
//                     str: widget.thirdText,
//                     color: ColorRes.primaryColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     textAlign: TextAlign.center,
//                     fontFamily: 'Rubik',
//                   ),
//                   sizedBoxH(8),
//                   Container(
//                     height: 7,
//                     width: Get.width,
//                     decoration: BoxDecoration(
//                         color: widget.currentValue == 2 ? ColorRes.blueColor : Colors.transparent,
//                         borderRadius: BorderRadius.circular(4)
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }
//
// class FourOptionContainer extends StatefulWidget {
//   final int currentValue;
//   final String firstText;
//   final String secondText;
//   final String thirdText;
//   final String fourText;
//   final ValueChanged<int> onChange;
//
//   const FourOptionContainer({
//     super.key,
//     required this.currentValue,
//     required this.firstText,
//     required this.secondText,
//     required this.thirdText,
//     required this.fourText,
//     required this.onChange,
//   });
//
//   @override
//   State<FourOptionContainer> createState() => _FourOptionContainerState();
// }
//
// class _FourOptionContainerState extends State<FourOptionContainer> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Get.width,
//       margin: const EdgeInsets.only(left: 10, right: 10),
//       padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: ColorRes.white,
//           boxShadow: [
//             BoxShadow(
//                 color: ColorRes.grey.withOpacity(0.3),
//                 blurRadius: 5
//             )
//           ]
//       ),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             InkWell(
//               onTap: (){
//                 setState(() {
//                   widget.onChange(0);
//                 });
//               },
//               child: Column(
//                 children: [
//                   GlobalText(
//                     str: widget.firstText,
//                     color: ColorRes.primaryColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     textAlign: TextAlign.center,
//                     fontFamily: 'Rubik',
//                   ),
//                   sizedBoxH(8),
//                   Container(
//                     height: 7,
//                     width: 130,
//                     decoration: BoxDecoration(
//                         color: widget.currentValue == 0 ? ColorRes.blueColor : Colors.transparent,
//                         borderRadius: BorderRadius.circular(4)
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//             InkWell(
//               onTap: (){
//                 setState(() {
//                   widget.onChange(1);
//                 });
//               },
//               child: Column(
//                 children: [
//                   GlobalText(
//                     str: widget.secondText,
//                     color: ColorRes.primaryColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     textAlign: TextAlign.center,
//                     fontFamily: 'Rubik',
//                   ),
//                   sizedBoxH(8),
//                   Container(
//                     height: 7,
//                     width: 130,
//                     decoration: BoxDecoration(
//                         color: widget.currentValue == 1 ? ColorRes.blueColor : Colors.transparent,
//                         borderRadius: BorderRadius.circular(4)
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//             InkWell(
//               onTap: (){
//                 setState(() {
//                   widget.onChange(2);
//                 });
//               },
//               child: Column(
//                 children: [
//                   GlobalText(
//                     str: widget.thirdText,
//                     color: ColorRes.primaryColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     textAlign: TextAlign.center,
//                     fontFamily: 'Rubik',
//                   ),
//                   sizedBoxH(8),
//                   Container(
//                     height: 7,
//                     width: 130,
//                     decoration: BoxDecoration(
//                         color: widget.currentValue == 2 ? ColorRes.blueColor : Colors.transparent,
//                         borderRadius: BorderRadius.circular(4)
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             InkWell(
//               onTap: (){
//                 setState(() {
//                   widget.onChange(3);
//                 });
//               },
//               child: Column(
//                 children: [
//                   GlobalText(
//                     str: widget.fourText,
//                     color: ColorRes.primaryColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     textAlign: TextAlign.center,
//                     fontFamily: 'Rubik',
//                   ),
//                   sizedBoxH(8),
//                   Container(
//                     height: 7,
//                     width: 130,
//                     decoration: BoxDecoration(
//                         color: widget.currentValue == 3 ? ColorRes.blueColor : Colors.transparent,
//                         borderRadius: BorderRadius.circular(4)
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

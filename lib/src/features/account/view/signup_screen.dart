
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_bottom_widget.dart';
import '../../../global/widget/global_couple_text_button.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../../global/widget/global_textform_field.dart';
import '../controller/account_controller.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onSwitch;
  const SignUpScreen({
    super.key,
    required this.onSwitch
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  TextEditingController confirmPassCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (accountController){
      return Column(
        children: [
          sizedBoxH(20),
          const GlobalText(
            str: "Sign Up",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),

          sizedBoxH(10),
          GlobalTextFormField(
            controller: emailCon,
            titleText: 'Email',
            filled: true,
            fillColor: ColorRes.listTileBackColor,
            isDense: true,
          ),

          sizedBoxH(8),
          GlobalTextFormField(
            controller: passCon,
            titleText: 'Password',
            filled: true,
            fillColor: ColorRes.listTileBackColor,
            isDense: true,
            isPasswordField: true,
          ),

          sizedBoxH(8),
          GlobalTextFormField(
            controller: confirmPassCon,
            titleText: 'Confirm Password',
            filled: true,
            fillColor: ColorRes.listTileBackColor,
            isDense: true,
            isPasswordField: true,
          ),

          sizedBoxH(30),
          GlobalButtonWidget(
            str: "Sign Up",
            height: 40,
            buttomColor: ColorRes.appRedColor,
            radius: 8,
            textSize: 13,
            onTap: (){

            },
          ),

          sizedBoxH(10),
          GestureDetector(
            onTap: widget.onSwitch,
            child: const Align(
              alignment: Alignment.center,
              child: CoupleTextButton(
                  firstText: "Already have a account? ",
                  secondText: "Log In"),
            ),
          ),

          sizedBoxH(30),

        ],
      );
    });
  }
}
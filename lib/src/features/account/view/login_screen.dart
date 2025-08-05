
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_bottom_widget.dart';
import '../../../global/widget/global_couple_text_button.dart';
import '../../../global/widget/global_sized_box.dart';
import '../../../global/widget/global_text.dart';
import '../../../global/widget/global_textform_field.dart';
import '../controller/account_controller.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onSwitch;
  const LoginScreen({
    super.key,
    required this.onSwitch
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (accountController){
      return Column(
        children: [
          sizedBoxH(20),
          const GlobalText(
            str: "Log In",
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
            isPasswordField: true,
            isDense: true,
          ),

          sizedBoxH(5),
          const Align(
            alignment: Alignment.centerRight,
            child: GlobalText(
              str: "Forget Password?",
              color: ColorRes.appRedColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),

          sizedBoxH(30),
          GlobalButtonWidget(
            str: "Log In",
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
                  firstText: "Don't have and any account? ",
                  secondText: "Sign Up"),
            ),
          ),

          sizedBoxH(30),

        ],
      );
    });
  }
}
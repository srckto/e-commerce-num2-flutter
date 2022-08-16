import 'package:e_commerce_num2/components/custom_button.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/components/custom_form_field.dart';
import 'package:e_commerce_num2/controllers/auth/register_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/helpers/functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetWidget<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          CustomCard(
            child: Column(
              children: [
                CustomFormField(
                  labelText: "EMAIL",
                  imageSvgPath: "assets/images/001-mail.svg",
                  controller: controller.email,
                  validator: emailValidator,
                ),
                CustomFormField(
                  labelText: "USERNAME",
                  imageSvgPath: "assets/images/Profile.svg",
                  controller: controller.userName,
                  validator: usernameValidator,
                ),
                CustomFormField(
                  labelText: "PASSWORD",
                  imageSvgPath: "assets/images/002-password.svg",
                  controller: controller.password,
                  obscureText: true,
                  validator: passwordValidator,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          CustomButton(
            onTap: () async {
              controller.createAccount();
            },
            text: "SIGN UP",
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "By creating an account, you agree to our ",
                    style: TextStyle(color: AppColor.fontColor),
                  ),
                  TextSpan(
                    text: "Terms of Service",
                    style: TextStyle(color: AppColor.primaryColor),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: " and ",
                    style: TextStyle(color: AppColor.fontColor),
                  ),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(color: AppColor.primaryColor),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

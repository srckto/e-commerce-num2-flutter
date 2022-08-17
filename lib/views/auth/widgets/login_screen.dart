import 'package:e_commerce_num2/components/custom_button.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/components/custom_form_field.dart';
import 'package:e_commerce_num2/controllers/auth/login_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/helpers/functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          CustomCard(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  CustomFormField(
                    labelText: "EMAIL",
                    imageSvgPath: "assets/images/001-mail.svg",
                    controller: controller.email,
                    validator: emailValidator,
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
          ),
          SizedBox(height: 20),
          GetBuilder<LoginController>(
            builder: (controller) {
              return CustomButton(
                onTap: controller.isLoading
                    ? null
                    : () async {
                        controller.login();
                      },
                text: "LOG IN",
                buttonColor: controller.isLoading ? Colors.brown : AppColor.primaryColor,
              );
            },
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Don’t have an account? Swipe right to ",
                    style: TextStyle(color: AppColor.fontColor),
                  ),
                  TextSpan(
                    text: "create a new account.",
                    style: TextStyle(color: AppColor.primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        controller.onClickCreateAccount();
                      },
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

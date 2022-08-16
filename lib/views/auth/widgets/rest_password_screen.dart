import 'package:e_commerce_num2/components/custom_button.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/components/custom_form_field.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/auth/rest_password_controller.dart';
import 'package:e_commerce_num2/helpers/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestPasswordScreen extends GetWidget<RestPasswordController> {
  const RestPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Container(
            width: Get.width * 0.75,
            child: CustomText(
              text:
                  "Enter the email address you used to create your account and we will email you a link to reset your password",
              fontSize: 15,
            ),
          ),
          SizedBox(height: 20),
          CustomCard(
            child: Column(
              children: [
                CustomFormField(
                  labelText: "EMAIL",
                  imageSvgPath: "assets/images/001-mail.svg",
                  controller: controller.email,
                  validator: emailValidator,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          CustomButton(
            onTap: () async {
              controller.sendPasswordResetEmail();
            },
            text: "SEND EMAIL",
          ),
        ],
      ),
    );
  }
}

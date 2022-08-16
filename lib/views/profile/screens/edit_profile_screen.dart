import 'package:e_commerce_num2/components/custom_button.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/components/custom_form_field.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/profile/edit_profile_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/helpers/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends GetWidget<EditProfileController> {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Edit Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.primaryColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: Get.width,
          height: Get.height * 0.8,
          alignment: Alignment.center,
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      CustomFormField(
                        imageSvgPath: "assets/images/Profile.svg",
                        controller: controller.userName,
                        hintText: "Your Name",
                        validator: usernameValidator,
                      ),
                      Divider(
                        endIndent: 20,
                        indent: 20,
                      ),
                      CustomFormField(
                        imageSvgPath: "assets/images/phone_icon.svg",
                        controller: controller.phoneNumber,
                        hintText: "Phone Number",
                        validator: phoneNumberValidator,
                      ),
                      Divider(
                        endIndent: 20,
                        indent: 20,
                      ),
                      CustomFormField(
                        imageSvgPath: "assets/images/country-icon.svg",
                        controller: controller.country,
                        hintText: "Country",
                      ),
                      Divider(
                        endIndent: 20,
                        indent: 20,
                      ),
                      CustomFormField(
                        imageSvgPath: "assets/images/resident-location-icon.svg",
                        controller: controller.address,
                        hintText: "Address",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GetBuilder<EditProfileController>(
                  builder: (controller) {
                    return CustomButton(
                      buttonColor: controller.isLoading ? Colors.brown : AppColor.primaryColor,
                      text: "Save",
                      onTap: controller.isLoading
                          ? null
                          : () {
                              controller.onSave();
                            },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

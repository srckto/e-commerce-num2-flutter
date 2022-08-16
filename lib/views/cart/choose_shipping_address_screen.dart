import 'package:e_commerce_num2/components/custom_button.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/components/custom_form_field.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/cart/choose_shipping_address_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/views/cart/check_out_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseShippingAddressScreen extends GetWidget<ChooseShippingAddressController> {
  const ChooseShippingAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.primaryColor,
          ),
        ),
        title: CustomText(text: "Add your shipping address"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.16,
              ),
              CustomCard(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    CustomFormField(
                      imageSvgPath: null,
                      controller: controller.name,
                      hintText: "Name",
                    ),
                    Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    CustomFormField(
                      imageSvgPath: null,
                      controller: controller.mainStreet,
                      hintText: "Main Street",
                    ),
                    Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    CustomFormField(
                      imageSvgPath: null,
                      controller: controller.subStreet,
                      hintText: "Sub Street",
                    ),
                    Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    CustomFormField(
                      imageSvgPath: null,
                      controller: controller.country,
                      hintText: "Country",
                    ),
                    Divider(
                      endIndent: 20,
                      indent: 20,
                    ),
                    CustomFormField(
                      imageSvgPath: null,
                      controller: controller.city,
                      hintText: "City",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GetBuilder<ChooseShippingAddressController>(
                builder: (controller) {
                  return CustomButton(
                    buttonColor: AppColor.primaryColor,
                    text: "Next",
                    onTap: () async {
                      await controller.saveCurrentShippingAddress();
                      Get.to(() => CheckoutScreen());
                    },
                  );
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}




/*

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
             

*/
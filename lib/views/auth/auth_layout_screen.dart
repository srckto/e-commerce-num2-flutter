import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/auth/auth_layout_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthLayoutScreen extends GetWidget<AuthLayoutController> {
  const AuthLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AuthLayoutController>(
          builder: (_) {
            return Container(
              width: Get.width,
              height: Get.height,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          controller.items.length,
                          (index) => Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.onChange(index);
                                },
                                child: CustomText(
                                  text: controller.items[index].text,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                  color: controller.index == index ? AppColor.fontColor : AppColor.fontGrayColor
                                ),
                              ),
                              if (index < controller.items.length - 1) SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    controller.chooseScreen(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

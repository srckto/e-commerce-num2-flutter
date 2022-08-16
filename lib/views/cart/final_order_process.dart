import 'package:e_commerce_num2/components/custom_button.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/views/layout/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinalOrderProcess extends StatelessWidget {
  const FinalOrderProcess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: AppColor.primaryColor,
            ),
            onPressed: () => Get.off(() => LayoutScreen()),
          ),
        ],
      ),
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 50,
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(height: 20),
            CustomText(
              text: "Order Placed!",
              fontSize: 30,
            ),
            SizedBox(height: 20),
            CustomText(
              text:
                  "Your order was placed successfully. For more details, check All My Orders page under Profile tab",
              fontSize: 16,
            ),
            SizedBox(height: 30),
            CustomButton(
              width: 165,
              onTap: () {
                Get.off(() => LayoutScreen());
              },
              text: "MY ORDERS",
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/more/more_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MoreScreen extends GetWidget<MoreController> {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "More",
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 20),
            CustomCard(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _BuildItem(
                    title: "Shipping Address",
                    svgImagePath: "assets/images/shipping.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Payment Method",
                    svgImagePath: "assets/images/payment.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Currency",
                    svgImagePath: "assets/images/currency.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Language",
                    svgImagePath: "assets/images/language.svg",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            CustomCard(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _BuildItem(
                    onTap: () {},
                    title: "Notification Settings",
                    svgImagePath: "assets/images/notifications.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Privacy Policy",
                    svgImagePath: "assets/images/privacy.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Frequently Asked Questions",
                    svgImagePath: "assets/images/faq.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Legal Information",
                    svgImagePath: "assets/images/legal.svg",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem({
    Key? key,
    required this.svgImagePath,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final String svgImagePath;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SvgPicture.asset(svgImagePath),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  textAlign: TextAlign.start,
                  fontSize: 15,
                  text: title,
                ),
              ),
            ),
            SvgPicture.asset("assets/images/arrow_right_s.svg"),
          ],
        ),
      ),
    );
  }
}

import 'package:e_commerce_num2/views/profile/screens/edit_profile_screen.dart';
import 'package:e_commerce_num2/views/profile/screens/my_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:e_commerce_num2/components/build_image.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/profile/profile_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/helpers/main_user.dart';

class ProfileScreen extends GetWidget<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                BuildImage(
                  imageUrl: MainUser.model!.image!,
                  width: 120,
                  height: 120,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: MainUser.model!.username!,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                      SizedBox(height: 5),
                      CustomText(
                        text: MainUser.model!.email!,
                        fontSize: 16,
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => EditProfileScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: AppColor.fontGrayColor,
                            ),
                          ),
                          child: CustomText(
                            text: "EDIT PROFILE",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomCard(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _BuildItem(
                    title: "All My Orders",
                    svgImagePath: "assets/images/all order.svg",
                    onTap: () => Get.to(() => MyOrdersScreen()),
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Pending Shipments",
                    svgImagePath: "assets/images/pending shipments.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Pending Payments",
                    svgImagePath: "assets/images/pending payment.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Finished Orders",
                    svgImagePath: "assets/images/finished.svg",
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
                    title: "Invite Friends",
                    svgImagePath: "assets/images/invite.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Customer Support",
                    svgImagePath: "assets/images/support.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Rate Our App",
                    svgImagePath: "assets/images/rate.svg",
                  ),
                  Divider(
                    indent: 40,
                  ),
                  _BuildItem(
                    title: "Make a Suggestion",
                    svgImagePath: "assets/images/suggest.svg",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => controller.logOut(),
              child: Container(
                width: Get.width * 0.6,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: CustomText(
                  text: "LOGOUT",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
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

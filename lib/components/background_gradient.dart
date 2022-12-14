import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({
    Key? key,
    this.child,
  }) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            AppColor.canvasColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}

import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/layout/layout_controller.dart';

class LayoutScreen extends GetWidget<LayoutController> {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
            actions: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _BuildActionItem(
                    imagePath: "assets/images/Messages.svg",
                    number: 5,
                  ),
                  SizedBox(width: 13),
                  _BuildActionItem(
                    imagePath: "assets/images/notifications.svg",
                    number: 7,
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ],
          ),
          body: IndexedStack(
            children: controller.items.map((e) => e.screen).toList(),
            index: controller.index,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            currentIndex: controller.index,
            backgroundColor: Colors.white,
            onTap: controller.onChange,
            selectedItemColor: AppColor.primaryColor,
            unselectedItemColor: AppColor.fontColor,
            selectedFontSize: 12,
            items: controller.items
                .map(
                  (element) => BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      element.iconPath,
                      color: controller.isItemSelected(element) ? AppColor.primaryColor : null,
                    ),
                    label: element.name,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _BuildActionItem extends StatelessWidget {
  const _BuildActionItem({
    Key? key,
    required this.imagePath,
    required this.number,
  }) : super(key: key);
  final String imagePath;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        SvgPicture.asset(
          imagePath,
          width: 25,
          height: 25,
          fit: BoxFit.scaleDown,
        ),
        Container(
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.primaryColor,
          ),
          child: CustomText(
            text: "$number",
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

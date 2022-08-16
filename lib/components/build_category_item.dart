import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/home/categories_controller.dart';
import 'package:e_commerce_num2/helpers/hex_color.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_num2/models/category_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BuildCategoryItem extends StatelessWidget {
  const BuildCategoryItem({
    Key? key,
    required this.model,
  }) : super(key: key);
  final CategoryItemModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<CategoriesController>().onTapCategory(model.name!);
      },
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            child: SvgPicture.network(
              model.icon!,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: HexColor.fromHex(model.color!).withOpacity(0.5),
                  offset: Offset(0, 8),
                  blurRadius: 15,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          CustomText(
            text: model.name!,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

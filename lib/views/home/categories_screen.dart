import 'package:e_commerce_num2/components/build_category_item.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/home/categories_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoriesScreen extends GetWidget<CategoriesController> {
  CategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close_rounded,
                color: AppColor.primaryColor,
                size: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "All Categories",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: controller.categoryModel.items
                          .map((e) => Column(
                                children: [
                                  BuildCategoryItem(
                                    model: e,
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ))
                          .toList(),
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "MEN’S APPAREL",
                            color: AppColor.fontGrayColor,
                          ),
                          SizedBox(height: 10),
                          CustomCard(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.categoryModel.menApparel.length,
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(height: 20);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.find<CategoriesController>().onTapCategory(
                                        controller.categoryModel.menApparel[index],
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            text: controller.categoryModel.menApparel[index]),
                                        SvgPicture.asset("assets/images/arrow_right_s.svg"),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(),
                          SizedBox(height: 10),
                          CustomText(
                            text: "WOMEN APPAREL",
                            color: AppColor.fontGrayColor,
                          ),
                          SizedBox(height: 10),
                          CustomCard(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.categoryModel.womenApparel.length,
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(height: 20);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.find<CategoriesController>().onTapCategory(
                                        controller.categoryModel.womenApparel[index],
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            text: controller.categoryModel.womenApparel[index]),
                                        SvgPicture.asset("assets/images/arrow_right_s.svg"),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

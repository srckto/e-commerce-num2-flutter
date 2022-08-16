import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/views/home/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_num2/components/build_image.dart';
import 'package:e_commerce_num2/components/custom_form_field.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/components/empty_screen.dart';
import 'package:e_commerce_num2/controllers/search/search_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/helpers/functions.dart';
import 'package:e_commerce_num2/models/product_model.dart';

class SearchScreen extends GetWidget<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GetBuilder<SearchController>(
        builder: (controller) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.fontColor.withOpacity(0.1),
                  ),
                  child: CustomFormField(
                    imageSvgPath: "assets/images/Search.svg",
                    hintText: "Search something",
                    colorOfIcon: AppColor.fontGrayColor,
                    controller: controller.searchController,
                    validator: searchValidator,
                    onFieldSubmitted: controller.onFieldSubmitted,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "RECENTLY VIEWED",
                      color: AppColor.fontGrayColor,
                    ),
                    TextButton(
                      child: CustomText(
                        text: "CLEAR",
                        color: AppColor.primaryColor,
                      ),
                      onPressed: () => controller.removeRecentlyViewedItems(),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: controller.recentlyViewItems.isEmpty
                      ? EmptyScreen(
                          message: "No items yet",
                        )
                      : ListView.separated(
                          itemCount: controller.recentlyViewItems.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 10);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return _BuildRecentlyItem(
                              model: controller.recentlyViewItems[index],
                            );
                          },
                        ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "RECOMMENDED",
                      color: AppColor.fontGrayColor,
                    ),
                    TextButton(
                      child: CustomText(
                        text: "REFRESH",
                        color: AppColor.primaryColor,
                      ),
                      onPressed: () {
                        print("Doesn't work now");
                      },
                    )
                  ],
                ),
                Wrap(
                  spacing: 8,
                  children: controller.recommended
                      .map(
                        (element) => GestureDetector(
                          onTap: () {
                            print(element);
                            controller.onClickOnChip(element);
                          },
                          child: Chip(
                            label: CustomText(text: element),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BuildRecentlyItem extends StatelessWidget {
  final ProductModel model;
  const _BuildRecentlyItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(model: model)),
      child: CustomCard(
        width: 185,
        height: 70,
        radius: 10,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: BuildImage(imageUrl: model.image!),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: model.title!),
                  CustomText(text: "\$${model.price!}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:e_commerce_num2/components/build_image.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:e_commerce_num2/components/build_category_item.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/home/home_controller.dart';
import 'package:e_commerce_num2/models/product_model.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Categories",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        child: Container(
                          height: 120,
                          child: Row(
                            children: [
                              ListView.separated(
                                clipBehavior: Clip.none,
                                itemCount: 3,
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(width: 15);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return BuildCategoryItem(
                                      model: controller.categoryModel.items[index]);
                                },
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: controller.navigateToCategoriesScreen,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      child: SvgPicture.asset(
                                        "assets/images/arrow_right.svg",
                                        fit: BoxFit.scaleDown,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            offset: Offset(0, 8),
                                            blurRadius: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    CustomText(
                                      text: "See More",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomText(
                        text: "Latest",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: Get.width,
                        height: 185,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          children: [
                            Image.asset(
                              "assets/images/Base.jpg",
                              fit: BoxFit.cover,
                              width: Get.width,
                              height: 185,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "For all your\nsummer clothing\nneeds",
                                    fontSize: 18,
                                    color: Colors.white,
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 8),
                                          blurRadius: 15,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomText(text: "SEE MORE"),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/images/small_arrow_right.svg",
                                            fit: BoxFit.scaleDown,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 150,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.products.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 10);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return _BuildProductItem(
                              model: controller.products[index],
                              onTap: () => controller.navigateToProductDetails(
                                controller.products[index],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class _BuildProductItem extends StatelessWidget {
  const _BuildProductItem({
    Key? key,
    required this.model,
    required this.onTap,
  }) : super(key: key);
  final ProductModel model;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
        width: 130,
        radius: 15,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildImage(
              imageUrl: model.image!,
              width: 80,
              height: 80,
            ),
            CustomText(
              text: model.title!,
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
            CustomText(
              text: "\$${model.price!}",
              maxLines: 1,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

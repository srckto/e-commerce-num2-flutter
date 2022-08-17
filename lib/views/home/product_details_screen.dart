import 'package:e_commerce_num2/components/custom_button.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/controllers/cart/cart_controller.dart';
import 'package:e_commerce_num2/helpers/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:e_commerce_num2/components/background_gradient.dart';
import 'package:e_commerce_num2/components/build_image.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/home/product_details_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/models/product_model.dart';

class ProductDetailsScreen extends GetWidget<ProductDetailsController> {
  const ProductDetailsScreen({
    Key? key,
    required this.model,
  }) : super(key: key);
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: GetBuilder<ProductDetailsController>(
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _appBar(),
            body: Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  BuildImage(
                    imageUrl: model.image!,
                    width: 220,
                    height: 200,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.info.length,
                      (index) => GestureDetector(
                        onTap: () => controller.onChangeInfo(index),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                controller.indexOfInfo == index ? Colors.white : Colors.transparent,
                          ),
                          child: CustomText(
                            text: controller.info[index],
                            color: controller.indexOfInfo == index
                                ? AppColor.primaryColor
                                : AppColor.fontColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  if (controller.indexOfInfo == 0) _contentOfProduct(),
                  if (controller.indexOfInfo == 1) _contentOfDetails(),
                  if (controller.indexOfInfo == 2) Expanded(child: _contentOfReviews()),
                  // Center(
                  //   child: CustomText(text: "Reviews"),
                  // )
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        controller.shareLink(model);
                      },
                      text: "SHARE THIS",
                      height: 50,
                      buttonColor: Colors.white,
                      fontColor: AppColor.fontColor,
                      shadowColor: Colors.grey,
                      iconImageSvgPath: "assets/images/share-arrow.svg",
                      iconColor: Colors.white,
                      colorOfBackgroundIcon: AppColor.fontColor,
                    ),
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        print("ADD TO CART");
                        controller.addToCart(model);
                      },
                      text: "ADD TO CART",
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailsRow({
    required String rightTitle,
    required String rightSubTitle,
    required String leftTitle,
    required String leftSubTitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: rightTitle,
                fontSize: 14,
                color: AppColor.fontGrayColor,
              ),
              CustomText(
                text: rightSubTitle,
                fontSize: 16,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: leftTitle,
                fontSize: 14,
                color: AppColor.fontGrayColor,
              ),
              CustomText(
                text: leftSubTitle,
                fontSize: 16,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _contentOfDetails() {
    return Column(
      children: [
        _buildDetailsRow(
          rightTitle: "BRAND",
          rightSubTitle: model.brand!,
          leftTitle: "SKU",
          leftSubTitle: "${model.sku!}",
        ),
        _buildDetailsRow(
          rightTitle: "CONDITION",
          rightSubTitle: model.condition!,
          leftTitle: "MATERIAL",
          leftSubTitle: model.material!,
        ),
        _buildDetailsRow(
          rightTitle: "CATEGORY",
          rightSubTitle: model.category!,
          leftTitle: "FITTING",
          leftSubTitle: model.fitting!,
        ),
      ],
    );
  }

  Widget _contentOfProduct() {
    return Column(
      children: [
        Container(
          width: Get.width,
          child: CustomText(
            text: "SELECT COLOR",
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: model.colors!.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 15);
            },
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  controller.onChangeColor(index);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: HexColor.fromHex(model.colors![index]),
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (controller.indexOfColor == index)
                      Icon(
                        Icons.check,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                          )
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: Get.width,
          child: CustomText(
            text: "SELECT SIZE (US)",
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: model.sizes!.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 15);
            },
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  controller.onChangeSize(index);
                },
                child: Container(
                  width: 70,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomText(
                    text: model.sizes![index],
                    color: controller.indexOfSize == index
                        ? AppColor.primaryColor
                        : AppColor.fontColor,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _contentOfReviews() {
    if (model.reviews == null) return Center(child: CustomText(text: "Reviews"));
    return ListView.separated(
      itemCount: model.reviews!.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 15);
      },
      itemBuilder: (BuildContext context, int index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCard(
              radius: 50,
              width: 60,
              clipBehavior: Clip.antiAlias,
              child: BuildImage(
                imageUrl: model.reviews![index].image!,
                height: 60,
                width: 60,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    glow: false,
                    ignoreGestures: true,
                    initialRating: model.reviews![index].rating!.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemSize: 15,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppColor.primaryColor,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  SizedBox(height: 2),
                  CustomText(
                    text: model.reviews![index].name!,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 3),
                  CustomText(
                    text: model.reviews![index].description!,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: AppColor.primaryColor,
      ),
      centerTitle: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: model.name!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "\$${model.price!}",
                maxLines: 1,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 5),
              Container(
                width: 60,
                height: 25,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 17,
                    ),
                    SizedBox(width: 1),
                    CustomText(
                      text: "${model.rating}",
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SvgPicture.asset(
                "assets/images/Cart.svg",
                width: 21,
                height: 21,
              ),
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryColor.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0, 7),
                    ),
                  ],
                ),
                child: GetBuilder<CartController>(
                  builder: (controller) {
                    return CustomText(
                      text: controller.carts.length.toString(),
                      color: Colors.white,
                      fontSize: 10,
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

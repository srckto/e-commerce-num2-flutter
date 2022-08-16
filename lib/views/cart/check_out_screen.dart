import 'package:e_commerce_num2/components/build_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:e_commerce_num2/components/custom_button.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/controllers/cart/check_out_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/models/cart_model.dart';

class CheckoutScreen extends GetWidget<CheckoutController> {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.primaryColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Checkout",
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 15),
            CustomText(
              text: "SHIPPING ADDRESS",
              color: AppColor.fontGrayColor,
              fontSize: 12,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: controller.shippingAddress?.name ?? "name",
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: controller.shippingAddress?.subStreet ?? "subStreet",
                      fontSize: 17,
                    ),
                    CustomText(
                      text: controller.shippingAddress?.mainStreet ?? "subStreet",
                      fontSize: 17,
                    ),
                    CustomText(
                      text: controller.shippingAddress?.city ?? "subStreet",
                      fontSize: 17,
                    ),
                    CustomText(
                      text: controller.shippingAddress?.country ?? "subStreet",
                      fontSize: 17,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset("assets/images/arrow_right_s.svg"),
                ),
              ],
            ),
            Divider(),
            CustomText(
              text: "PAYMENT METHOD",
              color: AppColor.fontGrayColor,
              fontSize: 12,
            ),
            Row(
              children: [
                SvgPicture.asset("assets/images/master_card.svg"),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(
                      text: "Master Card ending **00",
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print("Master Card Button");
                  },
                  icon: SvgPicture.asset("assets/images/arrow_right_s.svg"),
                ),
              ],
            ),
            Divider(),
            CustomText(
              text: "ITEMS",
              color: AppColor.fontGrayColor,
              fontSize: 12,
            ),
            Expanded(
              child: GetBuilder<CheckoutController>(
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        controller.carts.length,
                        (index) => _BuildCartItem(
                          model: controller.carts[index],
                          incrementFunction: () =>
                              controller.incrementQuantity(controller.carts[index]),
                          decrementFunction: () =>
                              controller.decrementQuantity(controller.carts[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Row(
              children: [
                SvgPicture.asset("assets/images/tag.svg"),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomText(
                      text: "Add Promo Code",
                      color: AppColor.primaryColor,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print("Add Promo Code Button");
                  },
                  icon: SvgPicture.asset("assets/images/arrow_right_s.svg"),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "TOTAL",
                    fontSize: 10,
                    color: AppColor.fontGrayColor,
                  ),
                  GetBuilder<CheckoutController>(
                    builder: (controller) {
                      return CustomText(
                        text: "\$${controller.totalPrice.toStringAsFixed(2)}",
                        fontSize: 20,
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.bold,
                      );
                    },
                  ),
                  CustomText(
                    text: "Free Domestic Shipping",
                    fontSize: 12,
                    color: AppColor.fontColor,
                  ),
                ],
              ),
            ),
            GetBuilder<CheckoutController>(
              builder: (controller) {
                return Expanded(
                  child: CustomButton(
                    text: "PLACE ORDER",
                    buttonColor: controller.isLoading ? Colors.brown : AppColor.primaryColor,
                    onTap: controller.isLoading
                        ? null
                        : () async {
                            await controller.addOrder();
                            print("PLACE ORDER");
                          },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildCartItem extends StatelessWidget {
  const _BuildCartItem({
    Key? key,
    required this.model,
    this.incrementFunction,
    this.decrementFunction,
  }) : super(key: key);
  final CartModel model;
  final void Function()? incrementFunction;
  final void Function()? decrementFunction;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: BuildImage(
            imageUrl: model.image!,
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: model.title!,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: model.subTitle!,
                          fontSize: 16,
                        ),
                        SizedBox(height: 5),
                        CustomText(
                          text: "${model.price}",
                          fontSize: 16,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: decrementFunction,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColor.fontGrayColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.remove,
                            color: AppColor.fontColor,
                            size: 18,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: CustomText(
                          text: "${model.quantity!}",
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: incrementFunction,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColor.fontGrayColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: AppColor.fontColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ],
    );
  }
}

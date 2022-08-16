import 'package:e_commerce_num2/components/custom_button.dart';
import 'package:e_commerce_num2/views/cart/choose_shipping_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_num2/components/build_image.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/components/empty_screen.dart';
import 'package:e_commerce_num2/controllers/cart/cart_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/models/cart_model.dart';

class CartScreen extends GetWidget<CartController> {
  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        if (controller.carts.isEmpty)
          return EmptyScreen(
            message: "You don't have any cart item",
          );
        return Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Cart",
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      controller.carts.length,
                      (index) => _BuildCartItem(
                        model: controller.carts[index],
                        index: index,
                        lengthOfList: controller.carts.length,
                        onDelete: () => controller.deleteCartItem(controller.carts[index]),
                        incrementFunction: () =>
                            controller.incrementQuantity(controller.carts[index]),
                        decrementFunction: () =>
                            controller.decrementQuantity(controller.carts[index]),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
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
                          CustomText(
                            text: "\$${controller.totalPrice.toStringAsFixed(2)}",
                            fontSize: 20,
                            color: AppColor.fontColor,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            text: "Free Domestic Shipping",
                            fontSize: 12,
                            color: AppColor.fontColor,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        text: "CHECKOUT",
                        onTap: () => Get.to(() => ChooseShippingAddressScreen()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BuildCartItem extends StatelessWidget {
  const _BuildCartItem({
    Key? key,
    required this.model,
    required this.index,
    required this.lengthOfList,
    this.incrementFunction,
    this.decrementFunction,
    this.onDelete,
  }) : super(key: key);

  final CartModel model;
  final void Function()? incrementFunction;
  final void Function()? decrementFunction;
  final void Function()? onDelete;

  final int index;
  final int lengthOfList;

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: model.title!,
                fontSize: 16,
              ),
              CustomText(
                text: model.subTitle!,
                fontSize: 14,
                color: AppColor.fontGrayColor,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "${model.price}",
                fontSize: 16,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 8),
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
              SizedBox(height: 5),
              if (index < lengthOfList - 1) Divider(),
            ],
          ),
        ),
        IconButton(
          onPressed: onDelete,
          icon: Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

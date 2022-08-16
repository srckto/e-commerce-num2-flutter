import 'package:e_commerce_num2/components/build_image.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/components/empty_screen.dart';
import 'package:e_commerce_num2/controllers/home/my_orders_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersScreen extends GetWidget<MyOrdersController> {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: AppColor.primaryColor,
            ),
            onPressed: () => Get.back(),
          ),
        ],
        leading: Container(),
      ),
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<MyOrdersController>(
          builder: (controller) {
            if (controller.isLoading) return Center(child: CircularProgressIndicator());
            if (controller.orders.isEmpty) return EmptyScreen();
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "My Orders",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 15),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.orders.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 30);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: controller.orders[index].dateTime!,
                            color: AppColor.fontGrayColor,
                            fontSize: 12,
                          ),
                          SizedBox(height: 5),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.orders[index].carts!.length,
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(height: 10);
                            },
                            itemBuilder: (BuildContext context, int indexOfCarts) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomCard(
                                    width: 70,
                                    height: 70,
                                    padding: EdgeInsets.all(15),
                                    radius: 70,
                                    child: BuildImage(
                                      imageUrl:
                                          controller.orders[index].carts![indexOfCarts].image!,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text:
                                              controller.orders[index].carts![indexOfCarts].title!,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text:
                                                '\$${controller.orders[index].carts![indexOfCarts].price!}',
                                            style: TextStyle(
                                              color: AppColor.primaryColor,
                                              fontSize: 16,
                                            ),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    "  x${controller.orders[index].carts![indexOfCarts].quantity!}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: AppColor.fontColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            text: 'Total : ',
                                            style: TextStyle(
                                              color: AppColor.fontColor,
                                              fontSize: 16,
                                            ),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: "\$" +
                                                    (controller.orders[index].carts![indexOfCarts]
                                                                .quantity! *
                                                            controller.orders[index]
                                                                .carts![indexOfCarts].price!)
                                                        .toStringAsFixed(2),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColor.primaryColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Divider(),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          Container(
                            width: Get.width,
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(
                                text: "Total Price Of Order : ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.fontColor,
                                ),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: "\$" +
                                        controller.orders[index].totalPrice!.toStringAsFixed(2),
                                    // "  x${controller.orders[index].carts![indexOfCarts].quantity!}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

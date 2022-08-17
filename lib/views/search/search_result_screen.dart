import 'package:e_commerce_num2/components/build_image.dart';
import 'package:e_commerce_num2/components/custom_card.dart';
import 'package:e_commerce_num2/views/home/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_num2/components/custom_form_field.dart';
import 'package:e_commerce_num2/components/custom_text.dart';
import 'package:e_commerce_num2/components/empty_screen.dart';
import 'package:e_commerce_num2/controllers/search/search_result_controller.dart';
import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/helpers/functions.dart';
import 'package:e_commerce_num2/models/product_model.dart';

class SearchResultScreen extends GetWidget<SearchResultController> {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.primaryColor,
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.fontColor.withOpacity(0.1),
          ),
          child: Form(
            child: CustomFormField(
              imageSvgPath: "assets/images/Search.svg",
              hintText: "Search something",
              colorOfIcon: AppColor.fontGrayColor,
              controller: controller.textController,
              validator: searchValidator,
              onFieldSubmitted: (String? value) {
                controller.search(value!);
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_alt),
            color: AppColor.fontColor,
            onPressed: () {},
          )
        ],
      ),
      body: GetBuilder<SearchResultController>(
        builder: (controller) {
          if (controller.isLoading) return Center(child: CircularProgressIndicator());
          if (controller.productsOfSearch.isEmpty)
            return EmptyScreen(
              message: "Not found any item",
            );
          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 20,
              childAspectRatio: 14 / 18,
            ),
            itemCount: controller.productsOfSearch.length,
            itemBuilder: (BuildContext context, int index) {
              return _BuildSearchItem(
                model: controller.productsOfSearch[index],
              );
            },
          );
        },
      ),
    );
  }
}

class _BuildSearchItem extends StatelessWidget {
  const _BuildSearchItem({
    Key? key,
    required this.model,
  }) : super(key: key);
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsScreen(model: model)),
      child: CustomCard(
        radius: 15,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildImage(
              imageUrl: model.image!,
              width: 100,
              height: 130,
            ),
            CustomText(
              text: model.name!,
              fontWeight: FontWeight.w100,
              fontSize: 16,
              maxLines: 1,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "\$${model.price}", fontWeight: FontWeight.bold),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 15),
                      CustomText(
                        text: "${model.rating}",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 9,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

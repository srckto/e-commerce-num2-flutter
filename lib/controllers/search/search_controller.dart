import 'dart:convert';

import 'package:e_commerce_num2/controllers/search/search_result_controller.dart';
import 'package:e_commerce_num2/helpers/cache_storage.dart';
import 'package:e_commerce_num2/helpers/constants.dart';
import 'package:e_commerce_num2/models/product_model.dart';
import 'package:e_commerce_num2/views/search/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  List<ProductModel> recentlyViewItems = [];
  TextEditingController searchController = TextEditingController();
  List<String> recommended = [
    "Denim Jeans",
    "Mini Skirt",
    "Jacket",
    "Accessories",
    "Sports Accessories",
    "Yoga Pants",
    "Eye Shadow",
    "Scarf",
  ];

  onInit() async {
    super.onInit();
    recentlyViewItems = getRecentlyViewedItems();
  }

  bool _hasAlreadyContainCurrentItem(ProductModel model) {
    for (int i = 0; i < recentlyViewItems.length; i++) {
      if (recentlyViewItems[i].id == model.id) return true;
    }
    return false;
  }

  List<ProductModel> getRecentlyViewedItems() {
    List<ProductModel> products = [];
    var jsonString = CacheStorage.get(CACHE_RECENTLY_VIEWED);

    if (jsonString != null) {
      var parseJsonData = jsonDecode(jsonString) as List;

      for (int i = 0; i < parseJsonData.length; i++) {
        products.add(ProductModel.fromMap(parseJsonData[i]));
        if (i == 5) break;
      }
    }

    return products;
  }

  Future<void> removeRecentlyViewedItems() async {
    await CacheStorage.remove(CACHE_RECENTLY_VIEWED);
    recentlyViewItems = getRecentlyViewedItems();
    print(recentlyViewItems.length);
    update();
  }

  Future<void> saveToRecentlyViewed(ProductModel model) async {
    recentlyViewItems = getRecentlyViewedItems();

    if (_hasAlreadyContainCurrentItem(model)) return;

    recentlyViewItems.insert(0, model);

    List<Map<String, dynamic>> productsToMap =
        recentlyViewItems.map((element) => element.toMap()).toList();

    String convertToJson = jsonEncode(productsToMap);

    await CacheStorage.save(CACHE_RECENTLY_VIEWED, convertToJson);
    update();
    // print("////////////////////////////////////////////");
    // log(convertToJson);
    // print(productsToMap.length);
    // print("////////////////////////////////////////////");
  }

  void onClickOnChip(String text) {
    searchController.text = text;
    Get.to(() => SearchResultScreen());
    Get.find<SearchResultController>().search(text);
  }

  void onFieldSubmitted(String? text) {
    Get.to(() => SearchResultScreen());
    Get.find<SearchResultController>().search(searchController.text);
  }
}

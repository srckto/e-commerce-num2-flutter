import 'package:e_commerce_num2/models/product_model.dart';
import 'package:e_commerce_num2/network/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultController extends GetxController {
  late TextEditingController textController;
  List<ProductModel> productsOfSearch = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    // textController = Get.find<SearchController>().searchController;
    // search();
  }

  Future<void> search(String text) async {
    textController.text = text;
    text = text.toLowerCase();
    productsOfSearch = [];
    isLoading = true;
    update();

    try {
      var querySnapshot = await FirestoreService.instance.searchProducts(text);
      querySnapshot.docs.forEach((element) {
        productsOfSearch.add(ProductModel.fromMap(element.data()));
      });
      print(productsOfSearch);
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      print(e.toString());
      throw e;
    }
  }
}

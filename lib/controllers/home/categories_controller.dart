import 'package:e_commerce_num2/controllers/home/home_controller.dart';
import 'package:e_commerce_num2/controllers/search/search_result_controller.dart';
import 'package:e_commerce_num2/views/search/search_result_screen.dart';
import 'package:get/get.dart';

import 'package:e_commerce_num2/models/category_model.dart';

class CategoriesController extends GetxController {
  late CategoryModel categoryModel;

  @override
  void onInit() {
    super.onInit();
    categoryModel = Get.find<HomeController>().categoryModel;
  }

  void onTapCategory(String text) {
    Get.to(() => SearchResultScreen());
    Get.find<SearchResultController>().search(text);
  }
}

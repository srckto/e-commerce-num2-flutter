import 'package:e_commerce_num2/controllers/search/search_controller.dart';
import 'package:e_commerce_num2/models/category_model.dart';
import 'package:e_commerce_num2/models/product_model.dart';
import 'package:e_commerce_num2/network/firestore_service.dart';
import 'package:e_commerce_num2/views/home/categories_screen.dart';
import 'package:e_commerce_num2/views/home/product_details_screen.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late CategoryModel categoryModel;
  List<ProductModel> products = [];
  bool isLoading = false;

  onInit() async {
    super.onInit();
    isLoading = true;
    update();

    await getCategories();
    await getProducts();

    isLoading = false;
    update();
  }

  Future<void> getCategories() async {
    try {
      var data = await FirestoreService.instance.getCategories();
      categoryModel = CategoryModel.formJson(data.data()!);
    } catch (e) {
      print(" getCategories ${e.toString()}");
      throw "getCategories function";
    }
  }

  Future<void> getProducts() async {
    products = [];
    try {
      var data = await FirestoreService.instance.getProducts();
      data.docs.forEach((element) {
        products.add(ProductModel.fromMap(element.data()));
      });
      update();
    } catch (e) {
      print(" getProducts ${e.toString()}");
      throw "getProducts function";
    }
  }

  void navigateToCategoriesScreen() async {
    Get.to(() => CategoriesScreen());
  }

  void navigateToProductDetails(ProductModel model) {
    Get.to(() => ProductDetailsScreen(model: model));
    Get.find<SearchController>().saveToRecentlyViewed(model);
  }
}

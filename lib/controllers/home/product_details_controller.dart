
import 'package:e_commerce_num2/controllers/cart/cart_controller.dart';
import 'package:e_commerce_num2/models/cart_model.dart';
import 'package:e_commerce_num2/models/product_model.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  int indexOfInfo = 0;
  int indexOfColor = 0;
  int indexOfSize = 0;
  List<String> info = ["Product", "Details", "Reviews"];

  void onChangeInfo(int newIndex) {
    indexOfInfo = newIndex;
    update();
  }

  void onChangeColor(int newIndex) {
    indexOfColor = newIndex;
    update();
  }

  void onChangeSize(int newIndex) {
    indexOfSize = newIndex;
    update();
  }

  
  Future<void> addToCart(ProductModel model) async {
    await Get.find<CartController>().addToCart(
      CartModel(
        productId: model.id,
        title: model.title,
        subTitle: "Medium, Green",
        image: model.image,
        price: model.price,
        quantity: 1,
        color: model.colors![indexOfColor],
        size: model.sizes![indexOfSize],
      ),
    );
  }
}

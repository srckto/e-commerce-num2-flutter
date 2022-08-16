import 'package:e_commerce_num2/helpers/cart_db_helper.dart';
import 'package:e_commerce_num2/models/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  late List<CartModel> carts;
  late double totalPrice;

  @override
  void onInit() async {
    super.onInit();
    carts = [];
    totalPrice = 0.0;
    await getCarts();
    getTotalPrice();
    update();
  }

  Future<void> getCarts() async {
    carts = [];
    var query = await CartDbHelper.query();
    if (query.isNotEmpty) {
      query.forEach((element) {
        carts.add(CartModel.fromMap(element));
      });
    }
    update();
  }

  bool hasAlreadyContainCurrentCart(CartModel cartModel) {
    for (int i = 0; i != carts.length; i++) {
      if (carts[i].productId == cartModel.productId) {
        return true;
      }
    }

    return false;
  }

  Future<void> addToCart(CartModel cartModel) async {
    if (!hasAlreadyContainCurrentCart(cartModel)) {
      CartModel cart = await CartDbHelper.insert(cartModel);
      carts.add(cart);
      getTotalPrice();
      update();
    }
  }

  Future<void> incrementQuantity(CartModel cartModel) async {
    cartModel.quantity = cartModel.quantity! + 1;
    await CartDbHelper.update(cartModel);

    getTotalPrice();
    update();
  }

  Future<void> decrementQuantity(CartModel cartModel) async {
    if (cartModel.quantity! > 1) {
      cartModel.quantity = cartModel.quantity! - 1;
      await CartDbHelper.update(cartModel);

      getTotalPrice();
      update();
    }
  }

  Future<void> getTotalPrice() async {
    totalPrice = 0.0;
    if (carts.isNotEmpty) {
      carts.forEach((element) {
        totalPrice += (element.price! * element.quantity!);
      });
    }
  }

  Future<void> deleteCartItem(CartModel cartModel) async {
    await CartDbHelper.delete(cartModel);
    carts.remove(cartModel);
    getTotalPrice();
    update();
  }
}

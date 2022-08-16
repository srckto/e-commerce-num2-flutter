import 'package:e_commerce_num2/controllers/cart/cart_controller.dart';
import 'package:e_commerce_num2/controllers/cart/choose_shipping_address_controller.dart';
import 'package:e_commerce_num2/helpers/cart_db_helper.dart';
import 'package:e_commerce_num2/models/cart_model.dart';
import 'package:e_commerce_num2/models/order_model.dart';
import 'package:e_commerce_num2/models/shipping_address_model.dart';
import 'package:e_commerce_num2/network/firestore_service.dart';
import 'package:e_commerce_num2/views/cart/final_order_process.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutController extends GetxController {
  late ShippingAddressModel? shippingAddress;
  late List<CartModel> carts;
  late double totalPrice;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    shippingAddress = Get.find<ChooseShippingAddressController>().shippingAddressModel;
    carts = Get.find<CartController>().carts;
    totalPrice = Get.find<CartController>().totalPrice;
  }

  Future<void> getTotalPrice() async {
    totalPrice = 0.0;
    if (carts.isNotEmpty) {
      carts.forEach((element) {
        totalPrice += (element.price! * element.quantity!);
      });
    }
  }

  Future<void> incrementQuantity(CartModel cartModel) async {
    await Get.find<CartController>().incrementQuantity(cartModel);
    getTotalPrice();

    update();
  }

  Future<void> decrementQuantity(CartModel cartModel) async {
    await Get.find<CartController>().decrementQuantity(cartModel);
    getTotalPrice();

    update();
  }

  Future<void> addOrder() async {
    isLoading = true;
    update();
    OrderModel orderModel = OrderModel(
      carts: carts,
      dateTime: DateFormat("y/M/d ,H:m:s").format(DateTime.now()),
      shippingAddress: shippingAddress,
      totalPrice: totalPrice,
    );

    try {
      var reference = await FirestoreService.instance.addOrder(orderModel);
      await reference.update({"id": reference.id});
      await CartDbHelper.deleteCartTable();
      Get.find<CartController>().onInit();
      isLoading = false;
      update();
      Get.to(() => FinalOrderProcess());
    } catch (e) {
      isLoading = false;
      update();
      print(e.toString());
      throw e;
    }
  }
}

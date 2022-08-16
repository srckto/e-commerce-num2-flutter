import 'package:e_commerce_num2/models/order_model.dart';
import 'package:e_commerce_num2/network/firestore_service.dart';
import 'package:get/get.dart';

class MyOrdersController extends GetxController {
  late List<OrderModel> orders;
  late bool isLoading;

  onInit() async {
    super.onInit();
    isLoading = true;
    update();

    orders = await getOrders();

    isLoading = false;
    update();
  }

  Future<List<OrderModel>> getOrders() async {
    List<OrderModel> tempOrders = [];
    var querySnapshot = await FirestoreService.instance.getOrders();
    querySnapshot.docs.forEach((element) {
      tempOrders.add(OrderModel.fromMap(element.data()));
    });
    print(tempOrders);
    return tempOrders;
  }
}

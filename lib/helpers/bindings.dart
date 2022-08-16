import 'package:e_commerce_num2/controllers/auth/auth_layout_controller.dart';
import 'package:e_commerce_num2/controllers/auth/login_controller.dart';
import 'package:e_commerce_num2/controllers/auth/register_controller.dart';
import 'package:e_commerce_num2/controllers/auth/rest_password_controller.dart';
import 'package:e_commerce_num2/controllers/cart/cart_controller.dart';
import 'package:e_commerce_num2/controllers/cart/check_out_controller.dart';
import 'package:e_commerce_num2/controllers/cart/choose_shipping_address_controller.dart';
import 'package:e_commerce_num2/controllers/home/categories_controller.dart';
import 'package:e_commerce_num2/controllers/home/home_controller.dart';
import 'package:e_commerce_num2/controllers/home/my_orders_controller.dart';
import 'package:e_commerce_num2/controllers/home/product_details_controller.dart';
import 'package:e_commerce_num2/controllers/layout/layout_controller.dart';
import 'package:e_commerce_num2/controllers/more/more_controller.dart';
import 'package:e_commerce_num2/controllers/profile/edit_profile_controller.dart';
import 'package:e_commerce_num2/controllers/profile/profile_controller.dart';
import 'package:e_commerce_num2/controllers/search/search_controller.dart';
import 'package:e_commerce_num2/controllers/search/search_result_controller.dart';
import 'package:e_commerce_num2/controllers/splash/splash_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => RestPasswordController(), fenix: true);
    Get.lazyPut(() => LayoutController(), fenix: true);
    Get.lazyPut(() => AuthLayoutController(), fenix: true);
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => SearchController(), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => MoreController(), fenix: true);
    Get.lazyPut(() => CategoriesController(), fenix: true);
    Get.lazyPut(() => ProductDetailsController(), fenix: true);
    Get.lazyPut(() => SearchResultController(), fenix: true);
    Get.lazyPut(() => EditProfileController(), fenix: true);
    Get.lazyPut(() => ChooseShippingAddressController(), fenix: true);
    Get.lazyPut(() => CheckoutController(), fenix: true);
    Get.lazyPut(() => MyOrdersController(), fenix: true);
  }
}

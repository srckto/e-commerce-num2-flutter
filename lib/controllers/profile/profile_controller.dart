import 'package:e_commerce_num2/helpers/cache_storage.dart';
import 'package:e_commerce_num2/helpers/cart_db_helper.dart';
import 'package:e_commerce_num2/helpers/constants.dart';
import 'package:e_commerce_num2/views/auth/auth_layout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await CacheStorage.remove(CACHE_USER);
    await CacheStorage.remove(CACHE_RECENTLY_VIEWED);
    await CacheStorage.remove(CACHE_SHIPPING_ADDRESS);
    await CartDbHelper.deleteCartTable();
    await Get.off(() => AuthLayoutScreen());
  }

}

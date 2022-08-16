import 'package:e_commerce_num2/helpers/cache_storage.dart';
import 'package:e_commerce_num2/helpers/constants.dart';
import 'package:e_commerce_num2/views/auth/auth_layout_screen.dart';
import 'package:e_commerce_num2/views/layout/layout_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(Duration(seconds: 2));
    var isUserAvailable = CacheStorage.get(CACHE_USER);

    if (isUserAvailable == null) return await Get.off(() => AuthLayoutScreen());
    return await Get.off(() => LayoutScreen());
  }
}

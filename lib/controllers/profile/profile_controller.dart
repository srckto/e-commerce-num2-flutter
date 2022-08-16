import 'package:e_commerce_num2/helpers/cache_storage.dart';
import 'package:e_commerce_num2/helpers/constants.dart';
import 'package:e_commerce_num2/views/auth/auth_layout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // List<String> sectionOne = [
  //   "All My Orders",
  //   "Pending Shipments",
  //   "Pending Payments",
  //   "Finished Orders",
  // ];

  //  List<String> sectionTwo = [
  //   "Invite Friends",
  //   "Customer Support",
  //   "Rate Our App",
  //   "Make a Suggestion",
  // ];

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await CacheStorage.remove(CACHE_USER);
    await Get.off(() => AuthLayoutScreen());
  }
}

import 'dart:convert';

import 'package:e_commerce_num2/controllers/auth/auth_layout_controller.dart';
import 'package:e_commerce_num2/helpers/cache_storage.dart';
import 'package:e_commerce_num2/helpers/constants.dart';
import 'package:e_commerce_num2/helpers/main_user.dart';
import 'package:e_commerce_num2/network/auth_service.dart';
import 'package:e_commerce_num2/network/firestore_service.dart';
import 'package:e_commerce_num2/views/layout/layout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLoading = false;

  Future<void> login() async {
    isLoading = true;
    update();

    try {
      if (!formKey.currentState!.validate()) return;

      UserCredential userCredential =
          await AuthService.instance.login(email: email.text, password: password.text);

      var userData = await FirestoreService.instance.getUser(userCredential.user!.uid);

      var convertDataToJson = jsonEncode(userData.data());

      await CacheStorage.save(CACHE_USER, convertDataToJson);

      MainUser.getOrUpdateUserFromCache();

      await Get.off(() => LayoutScreen());

      isLoading = false;
      update();
    } on FirebaseAuthException catch (error) {
      isLoading = false;
      update();

      Get.closeAllSnackbars();

      Get.snackbar(
        "Something is wrong!",
        error.message!,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );
    } catch (error) {
      isLoading = false;
      update();

      Get.closeAllSnackbars();
      Get.snackbar(
        "Something is wrong!",
        "Please try again another time",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      );
    }
  }

  void onClickCreateAccount() {
    Get.find<AuthLayoutController>().onChange(1);
  }
}

import 'dart:convert';

import 'package:e_commerce_num2/helpers/cache_storage.dart';
import 'package:e_commerce_num2/helpers/constants.dart';
import 'package:e_commerce_num2/helpers/main_user.dart';
import 'package:e_commerce_num2/models/user_model.dart';
import 'package:e_commerce_num2/network/auth_service.dart';
import 'package:e_commerce_num2/network/firestore_service.dart';
import 'package:e_commerce_num2/views/layout/layout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;
  Future<void> createAccount() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading = true;
      update();
      UserCredential credential =
          await AuthService.instance.register(email: email.text, password: password.text);
      UserModel _model = UserModel(
        uId: credential.user!.uid,
        email: credential.user!.email,
        username: userName.text,
        dateOfRegister: DateFormat("y/M/d ,H:m:s").format(DateTime.now()),
        image:
            "https://firebasestorage.googleapis.com/v0/b/e-commerce-num2.appspot.com/o/defult_user_icon.png?alt=media&token=723a59af-edef-4db6-bfdd-4638530813c9",
      );

      await FirestoreService.instance.saveUser(_model);

      var convertDataToJson = jsonEncode(_model.toMap);

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
}

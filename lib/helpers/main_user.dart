import 'dart:convert';

import 'package:e_commerce_num2/helpers/constants.dart';
import 'package:e_commerce_num2/models/user_model.dart';
import 'package:e_commerce_num2/network/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'cache_storage.dart';

class MainUser {
  MainUser._();

  static UserModel? model;
  static final _auth = FirebaseAuth.instance;

  static void getOrUpdateUserFromCache() async {
    var value = CacheStorage.get(CACHE_USER);
    if (value == null) return;
    var convertDataToMap = jsonDecode(value);
    model = UserModel.fromJson(convertDataToMap);
  }

  static Future<void> getUserFromFirestoreAndUpdateModel() async {
    if (_auth.currentUser == null) return;
    var userData = await FirestoreService.instance.getUser(_auth.currentUser!.uid);
    if (userData.data() == null) return;
    model = UserModel.fromJson(userData.data()!);
    await CacheStorage.save(CACHE_USER, jsonEncode(userData.data()));
    Get.forceAppUpdate();
  }
}

import 'dart:convert';

import 'package:e_commerce_num2/helpers/cache_storage.dart';
import 'package:e_commerce_num2/helpers/constants.dart';
import 'package:e_commerce_num2/helpers/main_user.dart';
import 'package:e_commerce_num2/models/shipping_address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseShippingAddressController extends GetxController {
  ShippingAddressModel? shippingAddressModel;
  late TextEditingController name;
  late TextEditingController mainStreet;
  late TextEditingController subStreet;
  late TextEditingController city;
  late TextEditingController country;



  @override
  void onInit() {
    super.onInit();
    shippingAddressModel = getDataFromCache();
    name = TextEditingController(text: shippingAddressModel?.name ?? MainUser.model?.username);
    mainStreet = TextEditingController(text: shippingAddressModel?.mainStreet);
    subStreet = TextEditingController(text: shippingAddressModel?.subStreet);
    city = TextEditingController(text: shippingAddressModel?.city);
    country = TextEditingController(text: shippingAddressModel?.country);
    
  }

  ShippingAddressModel? getDataFromCache() {
    ShippingAddressModel? addressModel;
    String? jsonString = CacheStorage.get(CACHE_SHIPPING_ADDRESS);
    if (jsonString == null) return null;
    var decodeJsonData = jsonDecode(jsonString);
    addressModel = ShippingAddressModel.fromMap(decodeJsonData);
    return addressModel;
  }

  Future<void> saveCurrentShippingAddress() async {
    ShippingAddressModel addressModel = ShippingAddressModel(
      name: name.text,
      mainStreet: mainStreet.text,
      subStreet: subStreet.text,
      city: city.text,
      country: country.text,
    );
    shippingAddressModel = addressModel;
    var convertToJson = jsonEncode(addressModel.toMap());
    await CacheStorage.save(CACHE_SHIPPING_ADDRESS, convertToJson);
  }
}

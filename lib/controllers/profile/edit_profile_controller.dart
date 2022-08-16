import 'package:e_commerce_num2/helpers/main_user.dart';
import 'package:e_commerce_num2/models/user_model.dart';
import 'package:e_commerce_num2/network/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  late TextEditingController userName;
  late TextEditingController phoneNumber;
  late TextEditingController address;
  late TextEditingController country;
  late GlobalKey<FormState> formKey;
  late bool isLoading;
  @override
  void onInit() async {
    super.onInit();
    formKey = GlobalKey<FormState>();
    isLoading = false;
    userName = TextEditingController(text: MainUser.model?.username);
    phoneNumber = TextEditingController(text: MainUser.model!.phoneNumber?.toString());
    country = TextEditingController(text: MainUser.model!.country);
    address = TextEditingController(text: MainUser.model!.address);
  }

  void onSave() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    update();

    UserModel model = UserModel(
      uId: MainUser.model!.uId,
      email: MainUser.model!.email,
      image: MainUser.model!.image,
      phoneNumber: int.parse(phoneNumber.text),
      username: userName.text,
      dateOfRegister: MainUser.model!.dateOfRegister,
      address: address.text,
      country: country.text,
    );

    await FirestoreService.instance.updateUser(model);

    await MainUser.getUserFromFirestoreAndUpdateModel();

    isLoading = false;
    update();
    Get.back();
  }
}

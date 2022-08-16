import 'package:e_commerce_num2/views/auth/widgets/login_screen.dart';
import 'package:e_commerce_num2/views/auth/widgets/register_screen.dart';
import 'package:e_commerce_num2/views/auth/widgets/rest_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _AuthItem {
  final String text;
  final Widget screen;
  _AuthItem({
    required this.text,
    required this.screen,
  });
}

class AuthLayoutController extends GetxController {
  late int index;
  late List<_AuthItem> items;

  @override
  void onInit() {
    super.onInit();
    index = 0;
    items = [
      _AuthItem(text: "Log In", screen: LoginScreen()),
      _AuthItem(text: "Sign Up", screen: RegisterScreen()),
      _AuthItem(text: "Rest Password", screen: RestPasswordScreen()),
    ];
  }

  void onChange(int newIndex) {
    index = newIndex;
    update();
  }

  Widget chooseScreen() {
    return items.elementAt(index).screen;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:e_commerce_num2/views/cart/cart_screen.dart';
import 'package:e_commerce_num2/views/home/home_screen.dart';
import 'package:e_commerce_num2/views/more/more_screen.dart';
import 'package:e_commerce_num2/views/profile/profile_screen.dart';
import 'package:e_commerce_num2/views/search/search_screen.dart';

class _LayoutItem {
  String name;
  Widget screen;
  String iconPath;

  _LayoutItem({
    required this.name,
    required this.screen,
    required this.iconPath,
  });
}

class LayoutController extends GetxController {
  late List<_LayoutItem> items;
  late int index;

  @override
  void onInit() {
    super.onInit();
    index = 0;
    items = [
      _LayoutItem(name: "Home", screen: HomeScreen(), iconPath: "assets/images/Home.svg"),
      _LayoutItem(name: "Search", screen: SearchScreen(), iconPath: "assets/images/Search.svg"),
      _LayoutItem(name: "Cart", screen: CartScreen(), iconPath: "assets/images/Cart.svg"),
      _LayoutItem(name: "Profile", screen: ProfileScreen(), iconPath: "assets/images/Profile.svg"),
      _LayoutItem(name: "More", screen: MoreScreen(), iconPath: "assets/images/More.svg"),
    ];
  }

  void onChange(int newIndex) {
    index = newIndex;
    update();
  }

  // int indexOfElement(_LayoutItem element) {
  //   return items.indexOf(element);
  // }

  bool isItemSelected(_LayoutItem element) {
    return items.indexOf(element) == index;
  }
}

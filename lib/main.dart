import 'package:e_commerce_num2/helpers/app_color.dart';
import 'package:e_commerce_num2/helpers/bindings.dart';
import 'package:e_commerce_num2/helpers/cart_db_helper.dart';
import 'package:e_commerce_num2/helpers/main_user.dart';
import 'package:e_commerce_num2/views/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  await CartDbHelper.open();
  // await CartDbHelper.deleteCartTable();
  // await CacheStorage.erase();
  MainUser.getOrUpdateUserFromCache();
  MainUser.getUserFromFirestoreAndUpdateModel();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Commerce App",
      theme: ThemeData(
        primarySwatch: AppColor.primaryColor,
        canvasColor: AppColor.canvasColor,
        fontFamily: GoogleFonts.mulish().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      home: SplashScreen(),
      initialBinding: Binding(),
    );
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/sessionPages/splashScreen/controller.dart';

// import '../../welcome/controller.dart';dart
class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  onInit(){
    print("inside oninti");
    StorePrefrences sp = StorePrefrences();
    FirebaseAuth auth = FirebaseAuth.instance;
    Future.delayed(Duration(seconds: 3), () async {
      bool? val = (await sp.getIsFirstOpen());
      print(val);
      if (val == true && auth.currentUser == null) {
        print("true + null");

        Get.offAllNamed(AppRoutes.SIGN_IN);
      } else if (val == true && auth.currentUser != null) {
        print("true + !null");
        Get.offAllNamed(AppRoutes.Application);
      } else if (val == false && auth.currentUser == null || val==null) {
        print("false + null");
        Get.offAllNamed(AppRoutes.Welcome);
      } else if (val == false && auth.currentUser != null) {
        print("false + not null");
      }
    }

    );
    print("Function called ");

  }

  @override
  Widget build(BuildContext context) {
    onInit();
    return Scaffold(
      body: SafeArea(child: Center(child: Text("Splash Scrren"),)),
    );
  }
}
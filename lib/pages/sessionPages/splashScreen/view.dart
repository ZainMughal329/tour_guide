import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/sessionPages/splashScreen/controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  onInit() {
    StorePrefrences sp = StorePrefrences();
    FirebaseAuth auth = FirebaseAuth.instance;
    final _dbCompnay = FirebaseFirestore.instance.collection('company');
    Future.delayed(Duration(seconds: 3), () async {
      bool? val = (await sp.getIsFirstOpen());
      if (val == true && auth.currentUser == null) {
        Get.offAllNamed(AppRoutes.SIGN_IN);
      } else if (val == true && auth.currentUser != null) {
        final companyData = await _dbCompnay
            .where('id', isEqualTo: auth.currentUser!.uid.toString())
            .get();
        if (companyData.docs.isNotEmpty) {
          Get.offAllNamed(AppRoutes.Company_Home);
        } else {
          Get.offAllNamed(AppRoutes.Application);
        }
      } else if (val == false && auth.currentUser == null || val == null) {
        Get.offAllNamed(AppRoutes.Welcome);
      } else if (val == false && auth.currentUser != null) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    onInit();
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("Splash Scrren"),
      )),
    );
  }
}

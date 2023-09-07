import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/sessionPages/splashScreen/controller.dart';
import 'package:video_player/video_player.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  onInit() {
    StorePrefrences sp = StorePrefrences();
    FirebaseAuth auth = FirebaseAuth.instance;
    final _dbCompnay = FirebaseFirestore.instance.collection('company');
    Future.delayed(Duration(seconds: 7), () async {
      bool? val = (await sp.getIsFirstOpen());
      if (val == true && auth.currentUser == null) {
        Get.offAllNamed(AppRoutes.LOGIN_SIGN_UP);
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
      body: Center(
        child: GetBuilder<SplashScreenController>(
          builder: (con) {
            return con.videoPlayerController!.value.isInitialized
                  ? Stack(
                    children: [
                      AspectRatio(
                aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
                child: VideoPlayer(con.videoPlayerController!),
              ),
                      Positioned(
                        top: 16, // Adjust the top position as needed
                        left: 16, // Adjust the left position as needed
                        child: Center(
                          child: Text(
                            'Traveling is Love',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
                  : CircularProgressIndicator();
          }
        ),

      ),
    );
  }
}

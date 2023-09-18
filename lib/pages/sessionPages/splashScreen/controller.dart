import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/exception_alert.dart';
import 'package:video_player/video_player.dart';

import '../../../ReUsable/Prefrences/storage_pref.dart';
import '../../../ReUsable/routes/names.dart';
import 'index.dart';

class SplashScreenController extends GetxController {
  SplashScreenState state = SplashScreenState();

  SplashScreenController();

  VideoPlayerController? videoPlayerController;

  @override
  void onInit() {

    // videoPlayerController =
    //     VideoPlayerController.asset('assets/videos/splash_video.mp4')
    //       ..initialize().then((_) {
    //         update();
    //
    //         // Ensure the first frame is shown
    //         videoPlayerController!.play().whenComplete(() {
    //           // Navigate to the desired screen after the video finishes
    //           // Get.off(HomeScreen());
    //
    //         });
    //       });

    try{
      StorePrefrences sp = StorePrefrences();
      FirebaseAuth auth = FirebaseAuth.instance;
      final _dbCompnay =
      FirebaseFirestore.instance.collection('company');
      Future.delayed(Duration(milliseconds: 4000), () async {
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
        } else if (val == false && auth.currentUser == null ||
            val == null) {
          Get.offAllNamed(AppRoutes.Welcome);
        } else if (val == false && auth.currentUser != null) {

        }
      });

    }catch(e){
      // ExceptionAlert.showExceptionAlert(context, e.toString());
      // Get.dialog(Container(
      //   height: 50,
      //   width: 100,
      //   color: Colors.white,
      //   child: Center(
      //     child: Text('Error occurs'),
      //   ),
      // ));
    }
    super.onInit();
  }

  @override
  void onClose() {
    // videoPlayerController!.dispose();
    super.onClose();
  }
}

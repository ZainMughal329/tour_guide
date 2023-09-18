import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/exception_alert.dart';
import 'package:tours_guide/ReUsable/Exceptions/app_exceptions.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/sessionPages/splashScreen/controller.dart';
import 'package:video_player/video_player.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  onInit(BuildContext context) {
    try {
      StorePrefrences sp = StorePrefrences();
      FirebaseAuth auth = FirebaseAuth.instance;
      final _dbCompnay = FirebaseFirestore.instance.collection('company');
      Future.delayed(Duration(milliseconds: 4000), () async {
        bool? val = (await sp.getIsFirstOpen());
        if (val == true && auth.currentUser == null) {
          Get.toNamed(AppRoutes.LOGIN_SIGN_UP);
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
    } catch (e) {
      print("Exception Blocked Called");

      ExceptionAlert.showExceptionAlert(context, e.toString());
      // Get.dialog(Container(
      //   height: 50,
      //   width: 100,
      //   color: Colors.white,
      //   child: Center(
      //     child: Text('Error occurs'),
      //   ),
      // ));
    }
  }

  @override
  Widget build(BuildContext context) {
    try{
      onInit(context);
    }catch(e){
      print("Inside e block ");
      ExceptionAlert.showExceptionAlert(context, e.toString());
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image(
                image: AssetImage('assets/images/nws.png'),
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(top: 100.h, right: 90.w),
                child: Row(
                  children: [
                    const SizedBox(width: 20.0),
                    const Text(
                      'Journey\nAwaits',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      // width: 250.0,
                      height: 100.h,
                      child: DefaultTextStyle(
                          style: TextStyle(fontSize: 40.sp, color: Colors.black
                              // fontFamily: 'Horizon',
                              ),
                          child: AnimatedTextKit(
                            repeatForever: false,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              // TypewriterAnimatedText(
                              //   'Travel...Travel alot!\nBut once in a while,\ntravel back to your roots ...',
                              //   textStyle: controller.state.colorizeTextStyle,
                              //   speed: Duration(milliseconds: 60),
                              //   // colors: controller.state.colorizeColors,
                              // ),
                              RotateAnimatedText(
                                'Travel',
                                duration: Duration(milliseconds: 1000),
                              ),
                              RotateAnimatedText(
                                'Explore',
                                duration: Duration(milliseconds: 1000),
                              ),
                              RotateAnimatedText(
                                'Repeat',
                                duration: Duration(milliseconds: 1000),
                              ),
                            ],
                            isRepeatingAnimation: true,
                            onTap: () {
                              // print("Tap Event");
                            },
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        )

        // body: Center(
        //   child: GetBuilder<SplashScreenController>(
        //     builder: (con) {
        //       return con.videoPlayerController!.value.isInitialized
        //             ? Stack(
        //               children: [
        //                 AspectRatio(
        //           aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
        //           child: VideoPlayer(con.videoPlayerController!),
        //         ),
        //                 Positioned(
        //                   top: 16, // Adjust the top position as needed
        //                   left: 16, // Adjust the left position as needed
        //                   child: Center(
        //                     child: Text(
        //                       'Traveling is Love',
        //                       style: TextStyle(
        //                         color: Colors.white,
        //                         fontSize: 24,
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //
        //               ],
        //             )
        //             : CircularProgressIndicator();
        //     }
        //   ),
        //
        // ),
        );
  }
}

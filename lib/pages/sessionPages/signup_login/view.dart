import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/sessionPages/signup_login/pages/company_sign_up_page.dart';
import 'package:tours_guide/pages/sessionPages/signup_login/pages/login_page.dart';
import 'package:tours_guide/pages/sessionPages/signup_login/pages/sign_up_page.dart';
import 'package:tours_guide/pages/sessionPages/splashScreen/controller.dart';

import '../../../ReUsable/Components/tab_bar_settings.dart';
import '../../../ReUsable/Components/top_image.dart';
import 'controller.dart';

class SignupLoginView extends GetView<SignupLoginController> {
  const SignupLoginView({Key? key}) : super(key: key);


  // _mobileLoginScreen() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         TopImage(),
  //         Row(
  //           children: [
  //             Spacer(),
  //             Expanded(
  //               flex: 8,
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     child: Align(
  //                       alignment: Alignment.topLeft,
  //                       child: TabBar(
  //                         isScrollable: true,
  //                         labelPadding: EdgeInsets.only(right: 20, left: 20),
  //                         indicator:
  //                         CircleTabIndicator(color: Colors.cyan, radius: 4),
  //                         controller: controller.tabController,
  //                         labelColor: Colors.cyan,
  //                         unselectedLabelColor: Colors.grey,
  //                         tabs: [
  //                           Tab(
  //                             text: 'Login',
  //                           ),
  //                           Tab(
  //                             text: '     User\nRegistration',
  //                           ),
  //                           Tab(
  //                             text: ' Company\nRegistration',
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   SingleChildScrollView(
  //                     child: Container(
  //                       margin: EdgeInsets.only(top: 30),
  //                       height: 290,
  //                       width: double.infinity,
  //                       child: TabBarView(
  //                         controller: controller.tabController,
  //                         children: [
  //                           // Get.offAndToNamed(page)
  //                           LoginPage(),
  //                           SignUpPage(),
  //
  //                           CompanySignUp(),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Spacer(),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TopImage(),
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Container(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: TabBar(
                              isScrollable: true,
                              labelPadding: EdgeInsets.only(right: 20, left: 20),
                              indicator:
                              CircleTabIndicator(color: Colors.cyan, radius: 4),
                              controller: controller.tabController,
                              labelColor: Colors.cyan,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(
                                  text: 'Login',
                                ),
                                Tab(
                                  text: '     User\nRegistration',
                                ),
                                Tab(
                                  text: ' Company\nRegistration',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          height: 390.h,
                          width: double.infinity,
                          child: TabBarView(
                            controller: controller.tabController,
                            children: [
                              // Get.offAndToNamed(page)
                              LoginPage(),
                              SignUpPage(),

                              CompanySignUp(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


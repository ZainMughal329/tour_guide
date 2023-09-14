import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/drawer.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/screens/PersonPage/card_view.dart';
import 'package:tours_guide/pages/screens/PersonPage/community_guidlines.dart';
import 'package:tours_guide/pages/screens/PersonPage/contact_us.dart';
import 'package:tours_guide/pages/screens/PersonPage/faqs.dart';
import 'package:tours_guide/pages/screens/PersonPage/privacy_policy.dart';
import 'package:tours_guide/pages/screens/PersonPage/term_of_use.dart';
import 'package:tours_guide/pages/screens/PersonPage/update.dart';

import '../../../ReUsable/models/userModel.dart';
import 'controller.dart';

class PersonView extends GetView<PersonController> {
  PersonView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBgColor,
      key: _scaffoldKey,
      drawer: BuildDrawer.buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h, right: 20.w, left: 20.w),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: InkWell(
                            onTap: () {
                              _scaffoldKey.currentState!.openDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              color: AppColors.lightActiveIconColor,
                              size: 35.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    color: AppColors.lightTextColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.verified_user_outlined,
                          color: AppColors.lightActiveIconColor,
                          size: 35.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.getNodeData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // UserModel userModel = snapshot.data as UserModel;
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // Obx(()
                        // {
                        //   return
                        Container(
                          height: 60.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              // color: Color(0xff11151c),
                              // color: controller.state.isDarkMode.value
                              //     ? Colors.black
                              //     : Colors.white,
                              // color: Color(0xff0c3e4f),
                              color: AppColors.lightCardColor.withOpacity(0.2)),
                          child: ListTile(
                            onTap: () {
                              Get.to(() => UpdateScreen());
                            },
                            leading: Container(
                              height: 50.w,
                              width: 50.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: AppColors.lightActiveIconColor,
                                  width: 2.0.w,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: controller.image == null
                                    ? snapshot.data!['photoUrl'].toString() ==
                                            ''
                                        ? Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 30.sp,
                                              color: AppColors
                                                  .lightActiveIconColor,
                                            ),
                                          )
                                        : Image(
                                            image: NetworkImage(snapshot
                                                .data!['photoUrl']
                                                .toString()),
                                            fit: BoxFit.cover,
                                          )
                                    : Image.file(
                                        File(controller.image!.path).absolute,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            title: Text(
                              snapshot.data!['email'].toString(),
                              style: TextStyle(color: AppColors.lightTextColor),
                            ),
                            subtitle: Text(
                              snapshot.data!['phone'],
                              style: TextStyle(color: AppColors.lightTextColor),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.lightActiveIconColor,
                            ),
                          ),
                        ),
                        // }
                        // ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // color: Color(0xff0c3e4f),
                            color: AppColors.lightCardColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.all_Tours);
                                  },
                                  leading: Icon(
                                    Icons.shopping_cart_rounded,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                  title: Text(
                                    'All Bookings',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: InkWell(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.all_Tours);
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: AppColors.lightActiveIconColor,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 5.h,
                              ),
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => PaymentView());
                                  },
                                  leading: Icon(
                                    Icons.payment_outlined,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                  title: Text(
                                    'Add Cards',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: InkWell(
                                    onTap: () {
                                      Get.to(() => PaymentView());
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: AppColors.lightActiveIconColor,
                                    ),
                                  ),
                                ),
                              ),
                              // Divider(
                              //   color: Colors.grey,
                              //   height: 5.h,
                              // ),
                              // Container(
                              //   height: 40.h,
                              //   child: ListTile(
                              //     onTap: () {
                              //       Get.toNamed(AppRoutes.fvrtTours);
                              //     },
                              //     leading: Icon(
                              //       Icons.favorite_outline,
                              //       color: AppColors.lightActiveIconColor,
                              //     ),
                              //     title: Text(
                              //       'Favourite Tours',
                              //       style: TextStyle(
                              //           color: AppColors.lightTextColor),
                              //     ),
                              //     trailing: InkWell(
                              //       onTap: () {
                              //         Get.toNamed(AppRoutes.fvrtTours);
                              //       },
                              //       child: Icon(
                              //         Icons.arrow_forward_ios_outlined,
                              //         color: AppColors.lightActiveIconColor,
                              //       ),
                              //     ),
                              //   ),
                              // ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 225.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // color: Color(0xff0c3e4f),
                            color: AppColors.lightCardColor.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => ContactUsWidget());
                                  },
                                  title: Text(
                                    'Contact Us',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5),
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => FAQsWidget());
                                  },
                                  title: Text(
                                    'FAQ\'s',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5),
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => CommunityGuidelinesScreen());
                                  },
                                  title: Text(
                                    'Community Guidelines',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5),
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => TermsOfUseScreen());
                                  },
                                  title: Text(
                                    'Term of use',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5),
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => PrivacyPolicyScreen());
                                  },
                                  title: Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              final auth = FirebaseAuth.instance;
                              auth.signOut().then((value) {
                                Get.offAndToNamed(AppRoutes.LOGIN_SIGN_UP);
                                Get.snackbar(
                                  'Congrats',
                                  'Successfully logOut ',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.green,
                                  backgroundColor:
                                      Colors.green.withOpacity(0.1),
                                );
                              }).onError((error, stackTrace) {
                                Get.snackbar(
                                  'Error',
                                  'Something went wrong + ' + error.toString(),
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.green,
                                  backgroundColor:
                                      Colors.green.withOpacity(0.1),
                                );
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 30.h),
                              child: InkWell(
                                child: Container(
                                    height: 50.h,
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.lightButtonColor,
                                    ),
                                    child: Obx(() {
                                      return controller.state.loading.value
                                          ? Center(child: CircularProgressIndicator(color: Colors.white,))
                                          : Center(
                                              child: Text(
                                                'Logout',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17),
                                              ),
                                            );
                                    })),
                                onTap: () {
                                  controller.signOut();
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.lightTextColor,
                      ),
                    ],
                  );
                  // return Text('Something went wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

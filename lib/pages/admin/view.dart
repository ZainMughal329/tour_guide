import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/admin/showAllTours.dart';
import 'package:tours_guide/pages/admin/show_companies.dart';

import '../../ReUsable/Components/tab_bar_settings.dart';
import 'controller.dart';

class AdminHomePage extends GetView<AdminController> {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBgColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu , color: AppColors.lightActiveIconColor,),),
        backgroundColor: AppColors.lightBgColor,
        elevation: 0,
        title: Text('Admin Panel' , style: TextStyle(
          color: AppColors.lightTextColor
        ),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              final auth = FirebaseAuth.instance;
              auth.signOut().then((value) {
                Get.offAndToNamed(AppRoutes.LOGIN_SIGN_UP);
                Get.snackbar('Success', 'Logout success');
              }).onError((error, stackTrace) {
                Get.snackbar('Error', 'Something went wrong');
              });
            },
            icon: Icon(Icons.logout,color: AppColors.lightActiveIconColor,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(right: 20.w, left: 20.w),
                  indicator: CircleTabIndicator(color: AppColors.lightButtonColor, radius: 4),
                  controller: controller.tabController,
                  labelColor: AppColors.lightTextColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      text: 'Profile',
                    ),
                    Tab(
                      text: 'All tour',
                    ),

                  ],
                ),
              ),
            ),
            Container(
              height: 590.h,
              width: double.infinity,
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  // Get.offAndToNamed(page)
                  ShowCompanies(),
                  ShowAllTours(),
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }
}

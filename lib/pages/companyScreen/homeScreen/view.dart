import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import 'controller.dart';

// import '../../welcome/controller.dart';dart

class CompanyHomePage extends GetView<CompanyHomeController> {
  CompanyHomePage({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('CompanyHome'),
          backgroundColor: AppColors.activeIconColor,
        ),
        body: SafeArea(
          child: Center(child: Column(
            children: [
              Text("HomeScreen of Company" ),
              SizedBox(height: 200,),
              InkWell(
                // CHange this code and use it in controller
                onTap: ()async{
                  await auth.signOut();
                  Get.offAllNamed(AppRoutes.SIGN_IN);
                },
                child: Container(
                  height: 20.h,
                  width: double.infinity,
                  color: AppColors.buttonBgColor,
                  child: Center(child: Text("Logout")),
                ),
              )
            ],
          )),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';

import 'controller.dart';

// import '../../welcome/controller.dart';dart

class CompanyHomePage extends GetView<CompanyHomeController> {
  CompanyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('CompanyHome'),
          backgroundColor: AppColors.activeIconColor,
        ),
        body: SafeArea(
          child: Center(child: Text("HomeScreen of Company" )),
        ));
  }
}

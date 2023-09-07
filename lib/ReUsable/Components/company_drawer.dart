import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/screens/home_screen/index.dart';

import '../../pages/companyScreen/company_profile/controller.dart';
import '../../pages/screens/PersonPage/controller.dart';
import '../models/userModel.dart';

class BuildCompanyDrawer {
  static Drawer buildDrawer(BuildContext context) {
    var controller = Get.put(CompanyProfileController());
    return Drawer(
      width: 300.w,
      backgroundColor: AppColors.lightBgColor,
      child: FutureBuilder(
        future: controller.showCompanyData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CompanyModel companyModel = snapshot.data as CompanyModel;
            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      color: AppColors.lightCardColor.withOpacity(0.1)),
                  accountName: Text(
                    companyModel.companyName.capitalize.toString(),
                    style: TextStyle(color: AppColors.lightTextColor),
                  ),
                  accountEmail: Text(
                    companyModel.companyEmail,
                    style: TextStyle(color: AppColors.lightTextColor),
                  ),
                  currentAccountPicture: Container(
                    height: 120.w,
                    width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.lightTextColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: controller.image == null
                          ? companyModel.logo == ''
                              ? Icon(
                                  Icons.person,
                                  size: 50.sp,
                                  color: Colors.blue,
                                )
                              : Image(
                                  image: NetworkImage(companyModel.logo),
                                  fit: BoxFit.cover,
                                )
                          : Image.file(
                              File(controller.image!.path).absolute,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                ListTile(
                  // style: ListTileStyle.list,
                  // tileColor: AppColors.bgColor,
                  leading: Icon(
                    Icons.home,
                    color: AppColors.iconsColor,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.offAndToNamed(AppRoutes.Application);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: AppColors.iconsColor,
                  ),
                  title: Text(
                    'My Profile',
                    style: TextStyle(color: AppColors.lightTextColor),
                  ),
                  onTap: () {
                    // Handle profile tap
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.work,
                    color: AppColors.iconsColor,
                  ),
                  title: Text(
                    'My Network',
                    style: TextStyle(color: AppColors.lightTextColor),
                  ),
                  onTap: () {
                    // Handle network tap
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.message,
                    color: AppColors.iconsColor,
                  ),
                  title: Text(
                    'Messaging',
                    style: TextStyle(color: AppColors.lightTextColor),
                  ),
                  onTap: () {
                    // Handle messaging tap
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: AppColors.iconsColor,
                  ),
                  title: Text(
                    'Settings & Privacy',
                    style: TextStyle(color: AppColors.lightTextColor),
                  ),
                  onTap: () {
                    // Handle settings tap
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.help,
                    color: AppColors.iconsColor,
                  ),
                  title: Text(
                    'Help & Support',
                    style: TextStyle(color: AppColors.lightTextColor),
                  ),
                  onTap: () {
                    // Handle help tap
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            print('Error is : ' + snapshot.error.toString());
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text('Something went wrong');
          }
        },
      ),
    );
  }
}

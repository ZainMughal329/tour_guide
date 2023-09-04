import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/screens/home_screen/index.dart';

import '../../pages/screens/PersonPage/controller.dart';
import '../models/userModel.dart';

class BuildDrawer {
  static Drawer buildDrawer(BuildContext context) {
    var controller = Get.put(PersonController());
    return Drawer(
      width: 300.w,
      backgroundColor: AppColors.bgColor,
      child: FutureBuilder(
        future: controller.getUsersData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userModel = snapshot.data as UserModel;
              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: AppColors.activeIconColor),
                    accountName: Text(userModel.userName.capitalize.toString()),
                    accountEmail: Text(userModel.email),
                    currentAccountPicture: Container(
                      height: 120.w,
                      width: 120.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColors.bgColor),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: controller.image == null
                            ? userModel.photoUrl == ''
                                ? Icon(
                                    Icons.person,
                                    size: 50,
                          color: Colors.white,
                                  )
                                : Image(
                                    image: NetworkImage(userModel.photoUrl),
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
                    leading: Icon(Icons.home , color: AppColors.iconsColor,),
                    title: Text('Home',style: TextStyle(color: Colors.white),),
                    onTap: () {
                      Navigator.pop(context);
                      Get.offAndToNamed(AppRoutes.Application);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person , color: AppColors.iconsColor,),
                    title: Text('My Profile',style: TextStyle(color: Colors.white),),
                    onTap: () {
                      // Handle profile tap
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.work,color: AppColors.iconsColor,),
                    title: Text('My Network',style: TextStyle(color: Colors.white),),
                    onTap: () {
                      // Handle network tap
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.message,color: AppColors.iconsColor,),
                    title: Text('Messaging',style: TextStyle(color: Colors.white),),
                    onTap: () {
                      // Handle messaging tap
                      Navigator.pop(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings,color: AppColors.iconsColor,),
                    title: Text('Settings & Privacy',style: TextStyle(color: Colors.white),),
                    onTap: () {
                      // Handle settings tap
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help,color: AppColors.iconsColor,),
                    title: Text('Help & Support',style: TextStyle(color: Colors.white),),
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
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/screens/home_screen/index.dart';

import '../../pages/screens/PersonPage/controller.dart';
import '../models/userModel.dart';

class BuildDrawer {
  static Drawer buildDrawer(BuildContext context){
    var controller = Get.put(PersonController());
    return Drawer(
      width: 300.w,
      child: FutureBuilder(
        future: controller.getUsersData(),
        builder: (context , snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData) {
              UserModel userModel = snapshot.data as UserModel;
              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(userModel.userName),
                    accountEmail: Text(userModel.email),
                    currentAccountPicture: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(100),
                        border: Border.all(color: Colors.black),
                      ),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(100),
                        child: controller.image == null
                            ? userModel.photoUrl == ''
                            ? Icon(
                          Icons.person,
                          size: 50,
                        )
                            : Image(
                          image: NetworkImage(
                              userModel.photoUrl),
                          fit: BoxFit.cover,
                        )
                            : Image.file(
                          File(controller.image!.path)
                              .absolute,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade900,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                      Get.offAndToNamed(AppRoutes.Application);

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('My Profile'),
                    onTap: () {
                      // Handle profile tap
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text('My Network'),
                    onTap: () {
                      // Handle network tap
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Messaging'),
                    onTap: () {
                      // Handle messaging tap
                      Navigator.pop(context);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings & Privacy'),
                    onTap: () {
                      // Handle settings tap
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help),
                    title: Text('Help & Support'),
                    onTap: () {
                      // Handle help tap
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }else if(snapshot.hasError) {
              print('Error is : ' + snapshot.error.toString());
              return Center(child: CircularProgressIndicator(),);
            }else {
              return Text('Something went wrong');
            }
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },

      ),
    );
  }

}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/contact_us.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/faqs.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/privacy_policy.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/term_of_use.dart';
import 'package:tours_guide/pages/screens/home_screen/index.dart';
import 'package:tours_guide/pages/screens/home_screen/show_all_tours.dart';

import '../../pages/screens/PersonPage/controller.dart';
import '../../pages/screens/PersonPage/view.dart';
import '../Prefrences/storage_pref.dart';
import '../models/userModel.dart';

class BuildDrawer {
  static Drawer buildDrawer(BuildContext context) {
    var controller = Get.put(PersonController());
    return Drawer(
      width: 300.w,
      backgroundColor: AppColors.lightBgColor,
      child:
      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.getNodeData(),
        builder: (context, snapshot) {
            if (snapshot.hasData) {
              // UserModel userModel = snapshot.data as UserModel;
              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: AppColors.lightCardColor.withOpacity(0.1)),
                    accountName: Text(snapshot.data!['userName'].toString().capitalize.toString(),style:TextStyle(color: AppColors.lightTextColor,fontWeight: FontWeight.bold,fontSize: 20.sp),),
                    accountEmail: Text(snapshot.data!['email'],style:TextStyle(color: AppColors.lightTextColor),),
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
                            ? snapshot.data!['photoUrl'] == ''
                                ? Icon(
                                    Icons.person,
                                    size: 50.sp,
                          color: Colors.blue,
                                  )
                                : Image(
                                    image: NetworkImage(snapshot.data!['photoUrl']),
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
                    leading: Icon(Icons.tour , color: AppColors.iconsColor,),
                    title: Text('All tours',style: TextStyle(color: Colors.black),),
                    onTap: () {
                      Navigator.pop(context);
                      // Get.offAndToNamed(AppRoutes.Application);
                      Get.to( () => ShowAllToursToUser(),);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart_outlined , color: AppColors.iconsColor,),
                    title: Text('All Bookings',style: TextStyle(color: AppColors.lightTextColor),),
                    onTap: () {
                      // Handle profile tap
                      Navigator.pop(context);
                      // Get.offAndToNamed(AppRoutes.Application);
                      Get.toNamed(AppRoutes.all_Tours);

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_page,color: AppColors.iconsColor,),
                    title: Text('Contact Us',style: TextStyle(color: AppColors.lightTextColor),),
                    onTap: () {
                      // Handle network tap
                      Navigator.pop(context);
                      Get.to( () => ContactUsWidget(),);

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.question_answer_outlined,color: AppColors.iconsColor,),
                    title: Text('FAQ\'s',style: TextStyle(color: AppColors.lightTextColor),),
                    onTap: () {
                      // Handle messaging tap
                      Navigator.pop(context);
                      Get.to( () => FAQsWidget(),);
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings,color: AppColors.iconsColor,),
                    title: Text('Privacy Policy',style: TextStyle(color: AppColors.lightTextColor),),
                    onTap: () {
                      // Handle settings tap
                      Navigator.pop(context);
                      Get.to( () => PrivacyPolicyScreen(),);

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help,color: AppColors.iconsColor,),
                    title: Text('Term of use',style: TextStyle(color: AppColors.lightTextColor),),
                    onTap: () {
                      // Handle help tap
                      Navigator.pop(context);
                      Get.to( () => TermsOfUseScreen(),);

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_outlined,color: AppColors.iconsColor,),
                    title: Text('LogOut',style: TextStyle(color: AppColors.lightTextColor),),
                    onTap: () async {
                      // Handle help tap
                      Navigator.pop(context);
                      // Get.to( () => TermsOfUseScreen(),);
                      final auth = FirebaseAuth.instance;
                      try {
                        await auth.signOut().then((value) async {
                          StorePrefrences sp = StorePrefrences();
                          await sp.setIsFirstOpen(false);

                          Get.snackbar('Sign Out ', 'Successfully');
                          Get.toNamed(AppRoutes.LOGIN_SIGN_UP);
                        }).onError((error, stackTrace) {
                          Get.snackbar('Error', error.toString());
                        });
                      } catch (e) {
                        Get.snackbar("Error while logout", e.toString());
                      }

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

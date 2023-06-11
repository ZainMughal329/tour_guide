import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/sessionPages/sigin/controller.dart';

import '../../../ReUsable/Components/app_colors.dart';
import '../../../ReUsable/Components/round_button.dart';
import '../../../ReUsable/models/userModel.dart';

class PickProfileImage extends GetView<SignInController> {
  final String email;
  final String pass;
  final String name;
  final String phone;

  PickProfileImage(
      {Key? key,
      required this.email,
      required this.pass,
      required this.name,
      required this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Pic'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              controller.showImage(context);
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  child: GetBuilder<SignInController>(
                    builder: (controller) {
                      return Column(
                        children: [
                          Container(
                            height: 200.h,
                            width: double.infinity,
                            // padding: EdgeInsets.symmetric(horizontal: 20.w),
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.black,
                            )),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(100.r),
                              child: controller.image == null
                                  ? Icon(
                                      Icons.image,
                                      size: 50,
                                      color: AppColors.activeTabElementColor,
                                    )
                                  : Container(
                                      height: 150.h,
                                      width: double.infinity,
                                      child: Image.file(
                                        File(controller.image!.path).absolute,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          controller.image == null
                              ? Text("Tap to Upload Image")
                              : Text(''),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: RoundButton(
                title: 'SignUp',
                loading: controller.state.loading.value,
                onPress: () {
                  var user = UserModel(
                    email: controller.emailController.text.trim().toString(),
                    password:
                        controller.passwordController.text.trim().toString(),
                    phone: '+92**********',
                    userName: controller.userController.text.trim().toString(),
                    photoUrl: controller.state.userProfileImage,
                  );
                  controller.storeUser(user, context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

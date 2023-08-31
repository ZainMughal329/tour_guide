import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/input_fields.dart';
import 'package:tours_guide/pages/screens/PersonPage/view.dart';

import '../../../ReUsable/models/userModel.dart';
import 'controller.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var controller = Get.put(PersonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.iconsColor,
          ),
        ),
        title: const Text('Edit Profile'),
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: FutureBuilder(
            future: controller.getUsersData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userModel = snapshot.data as UserModel;
                  final email = TextEditingController(text: userModel.email);
                  final phone = TextEditingController(text: userModel.phone);
                  final pass = TextEditingController(text: userModel.password);
                  final name = TextEditingController(text: userModel.userName);
                  final id = TextEditingController(text: userModel.id);

                  return Column(
                    children: [
                      GetBuilder<PersonController>(
                        builder: (controller) {
                          return Stack(
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(color: AppColors.iconsColor),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
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
                                          File(controller.image!.path).absolute,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 0,
                                child: InkWell(
                                  onTap: () {
                                    controller.showImage(context, userModel);
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        child: Column(
                          children: [
                            UpdateInputTextField(
                                obsecure: false,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                icon: Icons.person,
                                contr: name,
                                textColor: Colors.white,
                                filledColor: AppColors.cardBgColor,
                                descrip: 'Enter your username',
                                focNode: controller.userFocus,
                                color: Colors.white,
                                labelText: 'Username'),
                            SizedBox(
                              height: 5.h,
                            ),
                            UpdateInputTextField(
                                obsecure: false,
                                color: Colors.white,
                                textColor: Colors.white,
                                filledColor: AppColors.cardBgColor,
                                keyboardType: TextInputType.emailAddress,
                                icon: Icons.email_outlined,
                                contr: email,
                                descrip: 'Enter your email',
                                focNode: controller.emailFocus,
                                textInputAction: TextInputAction.next,
                                labelText: 'Email'),
                            SizedBox(
                              height: 5.h,
                            ),
                            UpdateInputTextField(
                                textInputAction: TextInputAction.next,
                                color: Colors.white,
                                textColor: Colors.white,
                                filledColor: AppColors.cardBgColor,
                                obsecure: true,
                                keyboardType: TextInputType.visiblePassword,
                                icon: Icons.lock_open,
                                contr: pass,
                                descrip: 'Enter your password',
                                focNode: controller.passwordFocus,
                                labelText: 'Password'),
                            SizedBox(
                              height: 5.h,
                            ),
                            UpdateInputTextField(
                                obsecure: false,
                                keyboardType: TextInputType.phone,
                                color: Colors.white,
                                textColor: Colors.white,
                                filledColor: AppColors.cardBgColor,
                                icon: Icons.phone,
                                textInputAction: TextInputAction.done,
                                contr: phone,
                                descrip: 'Enter your phone number',
                                focNode: controller.phoneFocus,
                                labelText: 'Phone'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            var userData = UserModel(
                              id: id.text,
                              email: email.text.trim(),
                              phone: phone.text.trim(),
                              password: pass.text.trim(),
                              userName: name.text.trim(),
                              photoUrl: controller.userProfileImage == ''
                                  ? userModel.photoUrl.toString()
                                  : controller.userProfileImage,
                              location: '',
                              fcmToken: '',
                              addTime: Timestamp.now(),
                            );
                            await controller.updateUser(userData);
                            // Get.to(() => PersonView());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.h),
                            child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.activeIconColor,
                                ),
                                child: Obx(() {
                                  return controller.state.loading.value
                                      ? CircularProgressIndicator()
                                      : Center(
                                          child: Text(
                                            'Save Profile',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                        );
                                })),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 50,
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       var userData = UserModel(
                      //         id: id.text,
                      //         email: email.text.trim(),
                      //         phone: phone.text.trim(),
                      //         password: pass.text.trim(),
                      //         userName: name.text.trim(),
                      //         photoUrl: controller.userProfileImage == ''
                      //             ? userModel.photoUrl.toString()
                      //             : controller.userProfileImage,
                      //       );
                      //       await controller.updateUser(userData);
                      //       // Get.to(() => PersonView());
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.black,
                      //       side: BorderSide.none,
                      //       shape: const StadiumBorder(),
                      //     ),
                      //     child: const Center(
                      //       child: Text(
                      //         'Save Profile',
                      //         style:
                      //             TextStyle(color: Colors.white, fontSize: 18),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text('Error occurs');
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

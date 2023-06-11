import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import '../../../ReUsable/Components/input_fields.dart';
import 'controller.dart';

class CompanySignUpPage extends GetView<CompanySignUpController> {
  CompanySignUpPage({Key? key}) : super(key: key);

  final auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final viewInsets = mediaQuery.viewInsets;
    return Scaffold(
      // resizeToAvoidBottomInset: controller.state.keyboardStatus.value,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Company Info'),
        backgroundColor: AppColors.activeIconColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              children: [
                GetBuilder<CompanySignUpController>(builder: (con) {
                  return Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: con.state.companyLogo == ''
                              ? Icon(
                                  Icons.person,
                                  size: 50,
                                )
                              : Image.file(
                                  File(con.image!.path).absolute,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            controller.showImage(context);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.black,
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
                }),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      InputTextField(
                          obsecure: false,
                          keyboardType: TextInputType.text,
                          icon: Icons.person_outline,
                          contr: controller.state.nameController,
                          descrip: 'Enter company name',
                          focNode: controller.state.nameNode,
                          labelText: 'Name'),
                      SizedBox(
                        height: 8.h,
                      ),
                      InputTextField(
                          obsecure: false,
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email_outlined,
                          contr: controller.state.emailController,
                          descrip: 'Enter company email',
                          focNode: controller.state.emailNode,
                          labelText: 'Company\'s email'),
                      SizedBox(
                        height: 8.h,
                      ),
                      InputTextField(
                          obsecure: false,
                          keyboardType: TextInputType.phone,
                          icon: Icons.phone,
                          contr: controller.state.phoneNumberController,
                          descrip: 'Enter company phoneNumber',
                          focNode: controller.state.phoneNumberNode,
                          labelText: 'Company\'s Phone'),
                      SizedBox(
                        height: 8.h,
                      ),
                      InputTextField(
                          obsecure: false,
                          keyboardType: TextInputType.text,
                          icon: Icons.description,
                          contr: controller.state.descController,
                          descrip: 'Enter company description',
                          focNode: controller.state.descNode,
                          labelText: 'Company\'s description'),
                      SizedBox(
                        height: 8.h,
                      ),
                      InputTextField(
                          obsecure: true,
                          keyboardType: TextInputType.visiblePassword,
                          icon: Icons.lock_open,
                          contr: controller.state.passController,
                          descrip: 'Enter password',
                          focNode: controller.state.passNode,
                          labelText: 'Password'),
                      SizedBox(height: 32.0.h),
                      Obx(() {
                        return InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final CompanyUser =
                                  CompanyModel(
                                      companyEmail: controller
                                          .state.emailController.text
                                          .trim()
                                          .toString(),
                                      companyName: controller
                                          .state.nameController.text
                                          .trim()
                                          .toString(),
                                      status: 'false',
                                      companyPhone: controller
                                          .state.phoneNumberController.text
                                          .trim()
                                          .toString(),
                                      companyDescription:
                                          controller
                                              .state.descController.text
                                              .trim()
                                              .toString(),
                                      pass: controller.state.passController.text
                                          .trim()
                                          .toString(),
                                      logo: controller.state.companyLogo
                                          .toString());
                              controller.storeUser(CompanyUser, context);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: AppColors.activeIconColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: controller.state.loading.value == true
                                  ? CircularProgressIndicator()
                                  : Text(
                                      "Sign In",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _formKey = GlobalKey<FormState>();

  Widget _companySignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 15.h,
          ),
          SignInInputTextField(
              textInputAction: TextInputAction.next,
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
          SignInInputTextField(
              obsecure: false,
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email_outlined,
              contr: controller.state.emailController,
              descrip: 'Enter company email',
              focNode: controller.state.emailNode,
              textInputAction: TextInputAction.next,
              labelText: 'Company\'s email'),
          SizedBox(
            height: 8.h,
          ),
          SignInInputTextField(
              obsecure: false,
              keyboardType: TextInputType.phone,
              icon: Icons.phone,
              contr: controller.state.phoneNumberController,
              descrip: 'Enter company phoneNumber',
              focNode: controller.state.phoneNumberNode,
              textInputAction: TextInputAction.next,
              labelText: 'Company\'s Phone'),
          SizedBox(
            height: 8.h,
          ),
          SignInInputTextField(
              obsecure: false,
              keyboardType: TextInputType.text,
              icon: Icons.description,
              contr: controller.state.descController,
              descrip: 'Enter company description',
              focNode: controller.state.descNode,
              textInputAction: TextInputAction.next,
              labelText: 'Company\'s description'),
          SizedBox(
            height: 8.h,
          ),
          SignInInputTextField(
              obsecure: true,
              keyboardType: TextInputType.visiblePassword,
              icon: Icons.lock_open,
              contr: controller.state.passController,
              descrip: 'Enter password',
              focNode: controller.state.passNode,
              textInputAction: TextInputAction.done,
              labelText: 'Password'),
        ],
      ),
    );
  }

  CompanySignUpPage({Key? key}) : super(key: key);

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // final viewInsets = mediaQuery.viewInsets;
    // return Scaffold(
    //   // resizeToAvoidBottomInset: controller.state.keyboardStatus.value,
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text('Company Info'),
    //     backgroundColor: AppColors.activeIconColor,
    //   ),
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Padding(
    //         padding: EdgeInsets.all(16.0.h),
    //         child: Column(
    //           children: [
    //             GetBuilder<CompanySignUpController>(builder: (con) {
    //               return Stack(
    //                 children: [
    //                   Container(
    //                     height: 120,
    //                     width: 120,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(100),
    //                       border: Border.all(color: Colors.black),
    //                     ),
    //                     child: ClipRRect(
    //                       borderRadius: BorderRadius.circular(100),
    //                       child: con.state.companyLogo == ''
    //                           ? Icon(
    //                               Icons.person,
    //                               size: 50,
    //                             )
    //                           : Image.file(
    //                               File(con.image!.path).absolute,
    //                               fit: BoxFit.cover,
    //                             ),
    //                     ),
    //                   ),
    //                   Positioned(
    //                     right: 10,
    //                     bottom: 0,
    //                     child: InkWell(
    //                       onTap: () {
    //                         controller.showImage(context);
    //                       },
    //                       child: Container(
    //                         height: 25,
    //                         width: 25,
    //                         decoration: BoxDecoration(
    //                           color: Colors.black,
    //                           borderRadius: BorderRadius.circular(100),
    //                           border: Border.all(color: Colors.black),
    //                         ),
    //                         child: ClipRRect(
    //                           borderRadius: BorderRadius.circular(100),
    //                           child: const Icon(
    //                             Icons.edit,
    //                             size: 20,
    //                             color: Colors.white,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               );
    //             }),
    //             _companySignUpForm(),
    //             SizedBox(height: 32.0.h),
    //             Obx(
    //               () {
    //                 return InkWell(
    //                   onTap: () {
    //                     if (_formKey.currentState!.validate()) {
    //                       final CompanyUser = CompanyModel(
    //                           companyEmail: controller
    //                               .state.emailController.text
    //                               .trim()
    //                               .toString(),
    //                           companyName: controller.state.nameController.text
    //                               .trim()
    //                               .toString(),
    //                           status: 'false',
    //                           companyPhone: controller
    //                               .state.phoneNumberController.text
    //                               .trim()
    //                               .toString(),
    //                           companyDescription: controller
    //                               .state.descController.text
    //                               .trim()
    //                               .toString(),
    //                           pass: controller.state.passController.text
    //                               .trim()
    //                               .toString(),
    //                           logo: '');
    //                       controller.storeUser(CompanyUser, context);
    //                     }
    //                   },
    //                   child: Container(
    //                     width: double.infinity,
    //                     height: 50.h,
    //                     decoration: BoxDecoration(
    //                       color: AppColors.activeIconColor,
    //                       borderRadius: BorderRadius.circular(10.r),
    //                     ),
    //                     child: Center(
    //                       child: controller.state.loading.value == true
    //                           ? CircularProgressIndicator()
    //                           : Text(
    //                               "Sign In",
    //                               style: TextStyle(color: Colors.white),
    //                             ),
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Create Company\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          _companySignUpForm(),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final CompanyUser = CompanyModel(
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
                                          companyDescription: controller
                                              .state.descController.text
                                              .trim()
                                              .toString(),
                                          pass: controller
                                              .state.passController.text
                                              .trim()
                                              .toString(),
                                          logo: '',
                                          location: '',
                                          fcmToken: '',
                                          addTime: Timestamp.now(),
                                        );
                                        controller.storeUser(
                                            CompanyUser, context);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

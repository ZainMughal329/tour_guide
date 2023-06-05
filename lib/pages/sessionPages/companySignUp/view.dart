import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import 'controller.dart';


class CompanySignUpPage extends GetView<CompanySignUpController> {
  CompanySignUpPage({Key? key}) : super(key: key);

  final auth=FirebaseAuth.instance;


  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Company Info'),
          backgroundColor: AppColors.activeIconColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16.0.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: controller.state.nameController,
                        focusNode: controller.state.nameNode,
                        onFieldSubmitted: (value) {},
                        validator: (value) {},
                        decoration: InputDecoration(
                          labelText: "Name",
                        ),
                      ),
                      SizedBox(height: 16.0.h),
                      TextFormField(
                        controller: controller.state.emailController,
                        focusNode: controller.state.emailNode,
                        onFieldSubmitted: (value) {},
                        validator: (value) {},
                        decoration: InputDecoration(
                          labelText: "Company's Email",
                        ),
                      ),
                      SizedBox(height: 16.0.h),
                      TextFormField(
                        controller: controller.state.phoneNumberController,
                        focusNode: controller.state.phoneNumberNode,
                        onFieldSubmitted: (value) {},
                        validator: (value) {},
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                        ),
                      ),
                      SizedBox(height: 16.0.h),
                      TextFormField(
                        controller: controller.state.descController,
                        focusNode: controller.state.descNode,
                        onFieldSubmitted: (value) {},
                        validator: (value) {},
                        decoration: InputDecoration(
                          labelText: "Description",
                        ),
                      ),
                      SizedBox(height: 16.0.h),
                      TextFormField(
                        controller: controller.state.passController,
                        focusNode: controller.state.passNode,
                        onFieldSubmitted: (value) {},
                        validator: (value) {},
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                      ),
                      SizedBox(height: 32.0.h),
                      Obx((){
                        return InkWell(

                          onTap: () {

                            if(_formKey.currentState!.validate()){

                              final CompanyUser= CompanyModel(

                                companyEmail: controller.state.emailController.text.trim().toString(),
                                companyName: controller.state.nameController.text.trim().toString(),
                                companyPhone: controller.state.phoneNumberController.text.trim().toString(),
                                companyDescription: controller.state.descController.text.trim().toString(),
                                pass: controller.state.passController.text.trim().toString(),
                              );
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
                                child: controller.state.loading.value==true? CircularProgressIndicator() : Text(
                                  "Sign In",
                                  style: TextStyle(color: Colors.white),
                                ),
                            ),
                          ),
                        );
                      }),

                      TextButton(
                        onPressed: () async{
                          await FirebaseAuth.instance.signOut();
                          StorePrefrences sp = StorePrefrences();
                          sp.setIsFirstOpen(false);
                          Get.offAllNamed(AppRoutes.SIGN_IN);
                          // Navigate to forgot password screen
                        },
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}

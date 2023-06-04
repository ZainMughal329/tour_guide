import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import 'controller.dart';

// import '../../welcome/controller.dart';dart

class CompanySignUpPage extends GetView<CompanySignUpController> {
  CompanySignUpPage({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  FocusNode nameNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();

  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberNode = FocusNode();

  TextEditingController descController = TextEditingController();
  FocusNode descNode = FocusNode();

  TextEditingController passController = TextEditingController();
  FocusNode passNode = FocusNode();

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
                        controller: nameController,
                        focusNode: nameNode,
                        onFieldSubmitted: (value) {},
                        validator: (value) {},
                        decoration: InputDecoration(
                          labelText: "Name",
                        ),
                      ),
                      SizedBox(height: 16.0.h),
                      TextFormField(
                        controller: emailController,
                        focusNode: emailNode,
                        onFieldSubmitted: (value) {},
                        validator: (value) {},
                        decoration: InputDecoration(
                          labelText: "Company's Email",
                        ),
                      ),
                      SizedBox(height: 16.0.h),
                      TextFormField(
                        controller: phoneNumberController,
                        focusNode: phoneNumberNode,
                        onFieldSubmitted: (value) {},
                        validator: (value) {},
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                        ),
                      ),
                      SizedBox(height: 16.0.h),
                      TextFormField(
                        controller: descController,
                        focusNode: descNode,
                        onFieldSubmitted: (value) {},
                        validator: (value) {},
                        decoration: InputDecoration(
                          labelText: "Description",
                        ),
                      ),
                      SizedBox(height: 16.0.h),
                      TextFormField(
                        controller: passController,
                        focusNode: passNode,
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
                              controller.registerUserWithEmailAndPassword(emailController.text.trim(), passController.text.trim());
                              final CompanyUser= CompanyModel(
                                id: controller.auth.currentUser!.uid.toString(),
                                companyEmail: emailController.text.trim().toString(),
                                companyName: nameController.text.trim().toString(),
                                companyPhone: phoneNumberController.text.trim().toString(),
                                companyDescription: descController.text.trim().toString(),
                                pass: passController.text.trim().toString(),
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
                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Perform sign-in action
                      //   },
                      //   child: Text('Sign In'),
                      //   style: ButtonStyle(
                      //     backgroundColor: Colors.blue
                      //   ),
                      // ),
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

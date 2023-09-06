import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/input_fields.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/index.dart';

import 'controller.dart';

class UpdateCompanyData extends GetView<CompanyProfileController> {
  UpdateCompanyData({Key? key}) : super(key: key);

  final auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.lightActiveIconColor,
          ),
        ),
        centerTitle: true,
        title: Text('Company Info',style: TextStyle(color: AppColors.lightTextColor),),
        backgroundColor: AppColors.lightBgColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: FutureBuilder(
              future: controller.showCompanyData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    CompanyModel companyModel = snapshot.data as CompanyModel;
                    final email =
                        TextEditingController(text: companyModel.companyEmail);
                    final phone =
                        TextEditingController(text: companyModel.companyPhone);
                    final pass = TextEditingController(text: companyModel.pass);
                    final name =
                        TextEditingController(text: companyModel.companyName);
                    final des = TextEditingController(
                        text: companyModel.companyDescription);

                    return Column(
                      children: [
                        GetBuilder<CompanyProfileController>(
                            builder: (controller) {
                          return Stack(
                            children: [
                              Container(
                                height: 120.w,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(color: AppColors.lightActiveIconColor),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: controller.image == null
                                      ? companyModel.logo.toString() == ''
                                          ? Icon(
                                              Icons.person,
                                              size: 50.sp,
                                              color: AppColors.lightActiveIconColor,
                                            )
                                          : Image(
                                              image: NetworkImage(
                                                  companyModel.logo.toString()),
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
                                    controller.showImage(context);
                                  },
                                  child: Container(
                                    height: 25.w,
                                    width: 25.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightActiveIconColor,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Icon(
                                        Icons.edit,
                                        size: 20.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFieldContainer(
                                child: UpdateInputTextField(
                                    contr: name,
                                    descrip: 'Company Name',
                                    focNode: controller.state.nameNode,
                                    labelText: 'Name',
                                    textInputAction: TextInputAction.next,
                                    // filledColor: AppColors.cardBgColor,
                                    color: AppColors.lightTextColor,
                                    textColor: AppColors.lightTextColor,
                                    keyboardType: TextInputType.text,
                                    obsecure: false,
                                    icon: Icons.person),
                              ),
                              SizedBox(height: 5.0.h),
                              TextFieldContainer(
                                child: UpdateInputTextField(
                                    contr: email,
                                    descrip: 'Company Email',
                                    focNode: controller.state.emailNode,
                                    labelText: 'Email',
                                    textInputAction: TextInputAction.next,
                                    // filledColor: AppColors.cardBgColor,
                                    color: AppColors.lightTextColor,
                                    textColor: AppColors.lightTextColor,
                                    keyboardType: TextInputType.text,
                                    obsecure: false,
                                    icon: Icons.email_outlined),
                              ),
                              SizedBox(height: 5.0.h),
                              TextFieldContainer(
                                child: UpdateInputTextField(
                                    contr: phone,
                                    descrip: 'Company Phone',
                                    focNode: controller.state.phoneNumberNode,
                                    labelText: 'PhoneNo',
                                    textInputAction: TextInputAction.next,
                                    // filledColor: AppColors.cardBgColor,
                                    color: AppColors.lightTextColor,
                                    textColor: AppColors.lightTextColor,
                                    keyboardType: TextInputType.text,
                                    obsecure: false,
                                    icon: Icons.phone),
                              ),

                              SizedBox(height: 5.0.h),
                              TextFieldContainer(
                                child: UpdateInputTextField(
                                    contr: des,
                                    descrip: 'Company Description',
                                    focNode: controller.state.descNode,
                                    labelText: 'Description',
                                    textInputAction: TextInputAction.next,
                                    // filledColor: AppColors.cardBgColor,
                                    color: AppColors.lightTextColor,
                                    textColor: AppColors.lightTextColor,
                                    keyboardType: TextInputType.text,
                                    obsecure: false,
                                    icon: Icons.description_outlined),
                              ),

                              SizedBox(height: 5.0.h),
                              TextFieldContainer(
                                child: UpdateInputTextField(
                                    contr: pass,
                                    descrip: 'Company Password',
                                    focNode: controller.state.passNode,
                                    labelText: 'Password',
                                    textInputAction: TextInputAction.done,
                                    // filledColor: AppColors.cardBgColor,
                                    color: AppColors.lightTextColor,
                                    textColor: AppColors.lightTextColor,
                                    keyboardType: TextInputType.text,
                                    obsecure: false,
                                    icon: Icons.lock_open_outlined),
                              ),

                              SizedBox(height: 10.0.h),

                              Center(
                                child: InkWell(
                                  onTap: () async {
                                    var userData = CompanyModel(
                                      id: auth.currentUser!.uid.toString(),
                                      status: companyModel.status,
                                      companyEmail: email.text.trim(),
                                      companyName: name.text.trim(),
                                      companyPhone: phone.text.trim(),
                                      companyDescription: des.text.trim(),
                                      logo: companyModel.logo.toString(),
                                      pass: pass.text.trim(),
                                      location: '',
                                      fcmToken: '',
                                      addTime: Timestamp.now(),
                                    );
                                    await controller.updateCompany(userData);
                                    Get.offAllNamed(AppRoutes.LOGIN_SIGN_UP);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Container(
                                        height: 50.h,
                                        width: 300.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: AppColors.lightButtonColor,
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
                              //       var userData = CompanyModel(
                              //           id: auth.currentUser!.uid.toString(),
                              //           status: companyModel.status,
                              //           companyEmail: email.text.trim(),
                              //           companyName: name.text.trim(),
                              //           companyPhone: phone.text.trim(),
                              //           companyDescription: des.text.trim(),
                              //           logo: companyModel.logo.toString(),
                              //           pass: pass.text.trim());
                              //       await controller.updateUser(userData);
                              //       Get.offAllNamed(AppRoutes.SIGN_IN);
                              //     },
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: Colors.black,
                              //       side: BorderSide.none,
                              //       shape: const StadiumBorder(),
                              //     ),
                              //     child: const Center(
                              //       child: Text(
                              //         'Save Profile',
                              //         style: TextStyle(
                              //             color: Colors.white, fontSize: 18),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
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
      ),
    );
  }
}




class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size * 0.8;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      width: size.width,
      decoration: BoxDecoration(
        color: AppColors.lightTextFormFieldColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}


import 'dart:io';

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
        centerTitle: true,
        title: Text('Company Info'),
        backgroundColor: AppColors.bgColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: FutureBuilder(
              future: controller.getUsersData(),
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
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: controller.image == null
                                      ? companyModel.logo.toString() == ''
                                          ? Icon(
                                              Icons.person,
                                              size: 50,
                                              color: AppColors.iconsColor,
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
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: AppColors.iconsColor,
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
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              UpdateInputTextField(
                                  contr: name,
                                  descrip: 'Company Name',
                                  focNode: controller.state.nameNode,
                                  labelText: 'Name',
                                  textInputAction: TextInputAction.next,
                                  filledColor: AppColors.cardBgColor,
                                  color: Colors.white,
                                  textColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  obsecure: false,
                                  icon: Icons.person),
                              SizedBox(height: 5.0.h),
                              UpdateInputTextField(
                                  contr: email,
                                  descrip: 'Company Email',
                                  focNode: controller.state.emailNode,
                                  labelText: 'Email',
                                  textInputAction: TextInputAction.next,
                                  filledColor: AppColors.cardBgColor,
                                  color: Colors.white,
                                  textColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  obsecure: false,
                                  icon: Icons.person),
                              SizedBox(height: 5.0.h),
                              UpdateInputTextField(
                                  contr: phone,
                                  descrip: 'Company Phone',
                                  focNode: controller.state.phoneNumberNode,
                                  labelText: 'PhoneNo',
                                  textInputAction: TextInputAction.next,
                                  filledColor: AppColors.cardBgColor,
                                  color: Colors.white,
                                  textColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  obsecure: false,
                                  icon: Icons.person),


                              SizedBox(height: 5.0.h),
                              UpdateInputTextField(
                                  contr: des,
                                  descrip: 'Company Description',
                                  focNode: controller.state.descNode,
                                  labelText: 'Description',
                                  textInputAction: TextInputAction.next,
                                  filledColor: AppColors.cardBgColor,
                                  color: Colors.white,
                                  textColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  obsecure: false,
                                  icon: Icons.person),


                              SizedBox(height: 5.0.h),
                              UpdateInputTextField(
                                  contr: pass,
                                  descrip: 'Company Password',
                                  focNode: controller.state.passNode,
                                  labelText: 'Password',
                                  textInputAction: TextInputAction.done,
                                  filledColor: AppColors.cardBgColor,
                                  color: Colors.white,
                                  textColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  obsecure: false,
                                  icon: Icons.person),

                              SizedBox(height: 32.0.h),

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
                                        pass: pass.text.trim());
                                    await controller.updateUser(userData);
                                    Get.offAllNamed(AppRoutes.SIGN_IN);
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

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
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
        appBar: AppBar(
          centerTitle: true,
          title: Text('Company Info'),
          backgroundColor: AppColors.activeIconColor,
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
                      final email = TextEditingController(
                          text: companyModel.companyEmail);
                      final phone = TextEditingController(
                          text: companyModel.companyPhone);
                      final pass =
                      TextEditingController(text: companyModel.pass);
                      final name =
                      TextEditingController(text: companyModel.companyName);
                      final des = TextEditingController(
                          text: companyModel.companyDescription);
                      // final id = TextEditingController(text: companyModel.id);

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
                                        )
                                            : Image(
                                          image: NetworkImage(companyModel
                                              .logo
                                              .toString()),
                                          fit: BoxFit.cover,
                                        )
                                            : Image.file(
                                          File(controller.image!.path)
                                              .absolute,
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
                                            borderRadius:
                                            BorderRadius.circular(100),
                                            border: Border.all(color: Colors.black),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(100),
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
                                TextFormField(
                                  controller: name,
                                  focusNode: controller.state.nameNode,
                                  onFieldSubmitted: (value) {},
                                  validator: (value) {},
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                  ),
                                ),
                                SizedBox(height: 16.0.h),
                                TextFormField(
                                  controller: email,
                                  focusNode: controller.state.emailNode,
                                  onFieldSubmitted: (value) {},
                                  validator: (value) {},
                                  decoration: InputDecoration(
                                    labelText: "Company's Email",
                                  ),
                                ),
                                SizedBox(height: 16.0.h),
                                TextFormField(
                                  controller: phone,
                                  focusNode: controller.state.phoneNumberNode,
                                  onFieldSubmitted: (value) {},
                                  validator: (value) {},
                                  decoration: InputDecoration(
                                    labelText: "Phone Number",
                                  ),
                                ),
                                SizedBox(height: 16.0.h),
                                TextFormField(
                                  controller: des,
                                  focusNode: controller.state.descNode,
                                  onFieldSubmitted: (value) {},
                                  validator: (value) {},
                                  decoration: InputDecoration(
                                    labelText: "Description",
                                  ),
                                ),
                                SizedBox(height: 16.0.h),
                                TextFormField(
                                  controller: pass,
                                  focusNode: controller.state.passNode,
                                  onFieldSubmitted: (value) {},
                                  validator: (value) {},
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                  ),
                                ),
                                SizedBox(height: 32.0.h),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      var userData = CompanyModel(
                                        id: auth.currentUser!.uid.toString(),
                                          // status: companyModel.,
                                          companyEmail: email.text.trim(),
                                          companyName: name.text.trim(),
                                          companyPhone: phone.text.trim(),
                                          companyDescription: des.text.trim(),
                                          logo: companyModel.logo.toString(),
                                          pass: pass.text.trim());
                                      await controller.updateUser(userData);
                                      // Get.to(() => CompanyProfileView());

                                      // Get.offAndToNamed(AppRoutes.Company_profile);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      side: BorderSide.none,
                                      shape: const StadiumBorder(),
                                    ),
                                    child: const Center(
                                        child: Text(
                                          'Save Profile',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                      ;
                    } else if (snapshot.hasError) {
                      print('Error is : ' + snapshot.error.toString());
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
        ));
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Edit Profile'),
        backgroundColor: Colors.black,
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
                  // final user = TextEditingController(text: 'user');
                  final id = TextEditingController(text: userModel.id);

                  return Column(
                    children: [
                      GetBuilder<PersonController>(builder: (controller) {
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
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        child: Column(
                          children: [
                            InputTextField(
                              controller: name,
                              formfieldValidator: (value) {},
                              obsecure: false,
                              onFieldSubmitedVlaue: (value) {},
                              icon: Icons.person_outline,
                              focusnode: controller.userFocus,
                              hint: 'UserName',
                              keyboardType: TextInputType.text,
                            ),

                            InputTextField(
                              controller: email,
                              formfieldValidator: (value) {},
                              obsecure: false,
                              onFieldSubmitedVlaue: (value) {},
                              icon: Icons.email_outlined,
                              focusnode: controller.emailFocus,
                              hint: 'Email',
                              keyboardType: TextInputType.emailAddress,
                            ),

                            InputTextField(
                              controller: pass,
                              formfieldValidator: (value) {},
                              obsecure: true,
                              onFieldSubmitedVlaue: (value) {},
                              icon: Icons.lock_open,
                              focusnode: controller.passwordFocus,
                              hint: 'Password',
                              keyboardType: TextInputType.visiblePassword,
                            ),

                            InputTextField(
                              controller: phone,
                              formfieldValidator: (value) {},
                              obsecure: false,
                              onFieldSubmitedVlaue: (value) {},
                              icon: Icons.phone,
                              focusnode: controller.phoneFocus,
                              hint: 'Phone',
                              keyboardType: TextInputType.phone,
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            var userData = UserModel(
                              id: id.text,
                              email: email.text.trim(),
                              phone: phone.text.trim(),
                              password: pass.text.trim(),
                              userName: name.text.trim(),
                              photoUrl: userModel.photoUrl,
                            );
                            await controller.updateUser(userData);
                            Get.to(() => PersonView());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                          ),
                          child: const Center(
                              child: Text(
                            'Save Profile',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                        ),
                      ),
                    ],
                  );
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
    );
  }
}
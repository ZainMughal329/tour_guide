import 'dart:io';

import 'package:flutter/material.dart';
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
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        child: Column(
                          children: [
                            InputTextField(
                                obsecure: false,
                                keyboardType: TextInputType.text,
                                icon: Icons.person,
                                contr: name,
                                descrip: 'Enter your username',
                                focNode: controller.userFocus,
                                labelText: 'Username'),
                            InputTextField(
                                obsecure: false,
                                keyboardType: TextInputType.emailAddress,
                                icon: Icons.email_outlined,
                                contr: email,
                                descrip: 'Enter your email',
                                focNode: controller.emailFocus,
                                labelText: 'Email'),
                            InputTextField(

                                obsecure: true,
                                keyboardType: TextInputType.visiblePassword,
                                icon: Icons.lock_open,
                                contr: pass,
                                descrip: 'Enter your password',
                                focNode: controller.passwordFocus,
                                labelText: 'Username'),
                            InputTextField(
                              obsecure: false,
                                keyboardType: TextInputType.phone,
                                icon: Icons.phone,
                                contr: phone,
                                descrip: 'Enter your phone number',
                                focNode: controller.phoneFocus,
                                labelText: 'Phone'),
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
                              photoUrl: controller.userProfileImage == ''
                                  ? userModel.photoUrl.toString()
                                  : controller.userProfileImage,
                            );
                            await controller.updateUser(userData);
                            // Get.to(() => PersonView());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                          ),
                          child: const Center(
                            child: Text(
                              'Save Profile',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
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
    );
  }
}

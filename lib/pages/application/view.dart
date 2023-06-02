import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/round_button.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/application/controller.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: RoundButton(
                title: 'Logout',
                onPress: () async {
                  final auth = await FirebaseAuth.instance;
                  await auth.signOut();
                  Get.offAndToNamed(AppRoutes.SIGN_IN);
                }),
          ),
        ],
      ),
    );
  }
}

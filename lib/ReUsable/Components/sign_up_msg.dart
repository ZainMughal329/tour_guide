import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

class SignUpMsg extends StatelessWidget {
  const SignUpMsg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDE2E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Your Account has send for approval. We can inform you when it gets approved.Thank You.',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final auth = await FirebaseAuth.instance;
                  auth.signOut().then((value) {
                    // print('Sign out succesfull');
                    Snackbar.showSnackBar("Sign-out", "Successfully");
                    Get.offAndToNamed(AppRoutes.LOGIN_SIGN_UP);
                  }).onError((error, stackTrace) {
                    Snackbar.showSnackBar("Error", error.toString());
                    // print("Error while signing out is : " + error.toString());
                  });

                  // Get.offAndToNamed(AppRoutes.LOGIN_SIGN_UP);
                },
                child: Text('Back to login page'),



              ),
            ],
          ),
        ),
      ),
    );
  }
}

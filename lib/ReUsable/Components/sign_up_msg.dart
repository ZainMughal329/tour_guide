import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

class CompanyApprovalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.hourglass_empty,
              size: 100,
              color: AppColors.lightCardColor,
            ),
            SizedBox(height: 20),
            Text(
              'Your account is pending approval from the admin.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: () async {
                final auth = await FirebaseAuth.instance;
                auth.signOut().then((value) {
                  // print('Sign out succesfull');
                  Snackbar.showSnackBar("Sign-out", "Successfully");
                  Get.offAndToNamed(AppRoutes.LOGIN_SIGN_UP);
                }).onError((error, stackTrace) {
                  Snackbar.showSnackBar("Error", error.toString());
                  // print("Error while signing out is : " + error.toString());
                });
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: AppColors.lightCardColor,

                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text('Logout', style: TextStyle(color: Colors.white,fontSize: 16.sp),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

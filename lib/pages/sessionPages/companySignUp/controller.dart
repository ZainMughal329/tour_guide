import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/Exceptions/signin_exceptions.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/models/userModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import 'index.dart';



class CompanySignUpController extends GetxController {
  final state = CompanySignUpState();
  CompanySignUpController();

  final _db = FirebaseFirestore.instance.collection('company');
  // final _db = FirebaseFirestore.instance.collection('users');
  final auth=FirebaseAuth.instance;


  void registerUserWithEmailAndPassword(String email,String password) async {
    state.loading.value = true;
    try {
      var user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            print(value.user!.uid.toString());

        state.loading.value = false;
        StorePrefrences sp = StorePrefrences();
        sp.setIsFirstOpen(true);
        // Write code to move to screen that show unApproved Status

        Get.offAllNamed(AppRoutes.SIGN_IN);

      }).onError((error, stackTrace) {
        print("this is error block of registery code");
        state.loading.value = false;
        toastInfo(msg: error.toString());
      });
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      toastInfo(msg: ex.toString());
      state.loading.value = false;
      print('Firebase Auth Exception : ' + e.code.toString());
    } catch (_) {
      state.loading.value = false;
    }
  }






  createUser(CompanyModel user) async {
    state.loading.value = true;
    await _db.add(user.toJson()).whenComplete(() {
      // sp.setIsFirstOpen(true);
      toastInfo(msg: 'Successfully created account');
      state.loading.value = false;
    }).catchError((error, stackTrace) {
      toastInfo(msg: "Error occurred");
      print('Error is : ' + error.toString());
      state.loading.value = false;
    });
  }

//
  void storeUser(CompanyModel user, BuildContext context) async {
    await createUser(user);
    registerUserWithEmailAndPassword(user.companyEmail, user.pass);
  }




}
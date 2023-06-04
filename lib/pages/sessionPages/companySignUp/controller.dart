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


  void registerUserWithEmailAndPassword(CompanyModel Compuser,String email,String password) async {
    state.loading.value = true;
    try {
      var user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            print(value.user!.uid.toString());
            toastInfo(msg: "Information Recieved");
            toastInfo(msg: "You'll recieve confirmation \nmail shortyly");

        state.loading.value = false;
        StorePrefrences sp = StorePrefrences();
        sp.setIsFirstOpen(true);
        Compuser.id=auth.currentUser!.uid.toString();
        // Write code to move to screen that show unApproved Status
           create(Compuser);



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



  create(CompanyModel user) async{
    state.loading.value=true;
    try{

      await _db.doc(auth.currentUser!.uid.toString()).set(user.toJson()).then((value){
        print("Successfully created user in doc ");
        auth.signOut();
        Get.offAllNamed(AppRoutes.SIGN_IN);
        state.loading.value=false;

      }).onError((error, stackTrace){
        state.loading.value=false;
        toastInfo(msg: error.toString());
        print("inside create code");
      });
    }catch(e){
      toastInfo(msg: e.toString());
      print(" Error Inside create user code");
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
  void storeUser(CompanyModel compUser, BuildContext context)  {

    registerUserWithEmailAndPassword(compUser,compUser.companyEmail, compUser.pass);

  }




}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/Exceptions/signin_exceptions.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/pages/sessionPages/sigin/state.dart';

import '../../../ReUsable/models/userModel.dart';
import '../../../ReUsable/routes/names.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();

class SignInController extends GetxController {
  late final Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance.collection('users');
  final _dbCompnay = FirebaseFirestore.instance.collection('company');
  final _dbCompanySnap =FirebaseFirestore.instance.collection('company').snapshots();
  var verificationId = "".obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userController = TextEditingController();
  final emailFocus = FocusNode();
  final userFocus = FocusNode();
  final passwordFocus = FocusNode();

  void dispose() {
    // TODO: implement dispose
    // super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    userFocus.dispose();
    userController.dispose();
    passwordFocus.dispose();
  }

  @override
  void onReady() {
    firebaseUser = Rx<User?>(auth.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print('Login Page');
      Get.offAll(() => AppRoutes.SIGN_IN);
    } else {
      Get.offAll(() => AppRoutes.Application);
    }
  }

  final state = SignInState();

  SignInController();

  final db = FirebaseFirestore.instance;

  void registerUserWithEmailAndPassword(UserModel userinfo,String email, password) async {
    state.loading.value = true;
    try {
      var user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            userinfo.id=auth.currentUser!.uid.toString();
            StorePrefrences sp= StorePrefrences();
            sp.setIsFirstOpen(true);
        createUser(userinfo);

      }).onError((error, stackTrace) {
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

  void loginUserWithEmailAndPassword(String email, password) async {
    state.loading.value = true;
    try {
      var user = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            print(value);

        if (auth.currentUser!.uid == _dbCompnay.doc(auth.currentUser!.uid).id) {

          _dbCompnay
              .doc(auth.currentUser!.uid)
              .get()
              .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {

            if (documentSnapshot.exists) {
              var status = documentSnapshot['status'];
              print(status.toString());
              handelNavigation(status);
            }
          }).onError((error, stackTrace) {
            toastInfo(msg: error.toString());

          });
        }



        else if (auth.currentUser!.uid == db.doc(auth.currentUser!.uid).id){
          Get.offAndToNamed(AppRoutes.Application);
          toastInfo(msg: 'Successfully log in');
          StorePrefrences sp = StorePrefrences();
          sp.setIsFirstOpen(true);

        }

        state.loading.value = false;
        emailController.clear();
        passwordController.clear();
        userController.clear();
      }).onError((error, stackTrace) {
        final ex = SignUpWithEmailAndPasswordFailure.code(error.toString());
        toastInfo(msg: ex.toString());
        print('Error is : ' + error.toString());
        state.loading.value = false;
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

  handelNavigation(String status) async{

    if (status == "notApproved") {
      await auth.signOut();
      toastInfo(msg: "Verification Still in Progress");
      toastInfo(msg: "You'll get verification mail shortyly");

    } else {
      StorePrefrences sp = StorePrefrences();
      sp.setIsFirstOpen(true);

      Get.offAllNamed(AppRoutes.Company_Home);
    }
  }

  Future<UserModel> getUserData(String email) async {
    final snapshot = await _db.where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
    return userData;
  }

  createUser(UserModel user) async {
    print("inside create user");
    state.loading.value = true;
    await _db.doc(auth.currentUser!.uid).set(user.toJson()).whenComplete(() {
      print("insdie create 2nd line");

      toastInfo(msg: 'Successfully created account');

      state.loading.value = false;
      StorePrefrences sp = StorePrefrences();
      sp.setIsFirstOpen(true);
      Get.offAllNamed(AppRoutes.Application);
    }).catchError((error, stackTrace) {
      toastInfo(msg: "Error occurred");
      // print('Error is : ' + error.toString());
      state.loading.value = false;
    });
  }

//
  void storeUser(UserModel user, BuildContext context) async {
    registerUserWithEmailAndPassword( user,user.email, user.password);

  }

  updateUserData(UserModel user) async {
    await db.collection('users').doc(user.id).update(user.toJson());
  }

}

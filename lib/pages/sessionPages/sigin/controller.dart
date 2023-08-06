import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/Exceptions/signin_exceptions.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/pages/sessionPages/sigin/state.dart';

import '../../../ReUsable/models/userModel.dart';
import '../../../ReUsable/routes/names.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


GoogleSignIn _googleSignIn = GoogleSignIn();

class SignInController extends GetxController {
  late final Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance.collection('users');
  final _dbCompnay = FirebaseFirestore.instance.collection('company');
  var verificationId = "".obs;

  final state = SignInState();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userController = TextEditingController();
  final emailFocus = FocusNode();
  final userFocus = FocusNode();
  final passwordFocus = FocusNode();

  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  XFile? _image;

  XFile? get image => _image;


  Future pickedImageFromGallery(
      BuildContext context) async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context);
      update();
    }
  }

  //
  Future pickedImageFromCamera(
      BuildContext context) async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context);
      update();
    }
  }

  void showImage(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 130,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                ListTile(
                  onTap: () {
                    pickedImageFromCamera(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickedImageFromGallery(context);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.image),
                  title: Text('Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future uploadImage(BuildContext context) async {
    // state.loading.value = true;
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + DateTime.now().toString());
    firebase_storage.UploadTask uploadTask =
    storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    state.userProfileImage = await storageRef.getDownloadURL();
    print('path is : ' + state.userProfileImage);
    return state.userProfileImage;


    // _db.collection('users').doc(auth.currentUser!.uid.toString()).update({
    //   'photoUrl': userProfileImage.toString(),
    // }).then((value) {
    //   // setLoading(false);
    //   Get.snackbar('Congrats', 'Update successfull');
    //   _image = null;
    // }).onError((error, stackTrace) {
    //   // setLoading(false);
    //   Get.snackbar('Error is', error.toString());
    // });
  }

  void dispose() {
    super.dispose();
    // TODO: implement dispose
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
      Get.offAll(() => AppRoutes.SIGN_IN);
    } else {
      Get.offAll(() => AppRoutes.Application);
    }
  }

  // final state = SignInState();

  SignInController();

  final db = FirebaseFirestore.instance;

  void registerUserWithEmailAndPassword(
      UserModel userinfo, String email, password) async {
    state.loading.value = true;
    try {
      var user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userinfo.id = auth.currentUser!.uid.toString();
        StorePrefrences sp = StorePrefrences();
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
    } catch (_) {
      state.loading.value = false;
    }
  }


  void loginUserWithEmailAndPassword(String email, password) async {
    // state.loading.value = true;
    try {
      var user = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
            print('inside then');
        final companyData = await _dbCompnay
            .where('id', isEqualTo: auth.currentUser!.uid.toString())
            .get();
        if (companyData.docs.isNotEmpty) {
          print('inside company if');
          StorePrefrences().setIsFirstOpen(true);

          Get.offAndToNamed(AppRoutes.Company_Home);
        } else {
          StorePrefrences().setIsFirstOpen(true);
          Get.offAndToNamed(AppRoutes.Application);
        }
        //
        // if (auth.currentUser!.uid == _dbCompnay.doc(auth.currentUser!.uid).id) {
        //
        //   _dbCompnay
        //       .doc(auth.currentUser!.uid)
        //       .get()
        //       .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        //
        //     if (documentSnapshot.exists) {
        //       var status = documentSnapshot['status'];
        //       print(status.toString());
        //       handelNavigation(status);
        //     }
        //   }).onError((error, stackTrace) {
        //     toastInfo(msg: error.toString());
        //
        //   });
        // }
        //
        //
        //
        // else if (auth.currentUser!.uid == db.doc(auth.currentUser!.uid).id){
        //   Get.offAndToNamed(AppRoutes.Application);
        //   toastInfo(msg: 'Successfully log in');
        //   StorePrefrences sp = StorePrefrences();
        //   sp.setIsFirstOpen(true);
        //
        // }

        state.loading.value = false;
        emailController.clear();
        passwordController.clear();
        userController.clear();
      }).onError((error, stackTrace) {
        final ex = SignUpWithEmailAndPasswordFailure.code(error.toString());
        toastInfo(msg: ex.toString());
        state.loading.value = false;
      });
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      toastInfo(msg: ex.toString());
      state.loading.value = false;
    } catch (_) {
      state.loading.value = false;
    }
  }

  handelNavigation(String status) async {
    if (status == "notApproved") {
      await auth.signOut();
      toastInfo(msg: "Verification Still in Progress");
      toastInfo(msg: "You'll get verification mail shortly");
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
    state.loading.value = true;
    await _db.doc(auth.currentUser!.uid).set(user.toJson()).whenComplete(() {
      toastInfo(msg: 'Successfully created account');

      state.loading.value = false;
      StorePrefrences sp = StorePrefrences();
      sp.setIsFirstOpen(true);
      Get.offAllNamed(AppRoutes.Application);
    }).catchError((error, stackTrace) {
      toastInfo(msg: "Error occurred");
      state.loading.value = false;
    });
  }

  void storeUser(UserModel user, BuildContext context) async {
    registerUserWithEmailAndPassword(user, user.email, user.password);
  }

  updateUserData(UserModel user) async {
    await db.collection('users').doc(user.id).update(user.toJson());
  }
}

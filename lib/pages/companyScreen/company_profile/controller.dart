import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../ReUsable/Prefrences/storage_pref.dart';
import '../../../ReUsable/routes/names.dart';

class CompanyProfileController extends GetxController {
  CompanyProfileController();

  final state = CompanyProfileState();
  final auth = FirebaseAuth.instance;

  final _db = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getNodeData() {
    return FirebaseFirestore.instance
        .collection('company')
        .doc(auth.currentUser!.uid.toString())
        .snapshots();
  }

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
      print('Image path is : ' + _image!.path.toString());
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
      print('Image path is : ' + _image!.path.toString());
      uploadImage(context);
      // notifyListeners();
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
    // setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + DateTime.now().toString());
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    print('upload task is : ' + uploadTask.toString());
    await Future.value(uploadTask);

    final newUrl = await storageRef.getDownloadURL();
    print(newUrl.toString());
    // return newUrl;

    _db.collection('company').doc(auth.currentUser!.uid.toString()).update({
      'logo': newUrl.toString(),
    }).then((value) {
      // setLoading(false);
      Get.snackbar('Congrats', 'Update successfull');
      _image = null;
    }).onError((error, stackTrace) {
      // setLoading(false);
      Get.snackbar('Error is', error.toString());
    });
  }

  // void signOut() async {
  //   try {
  //     await auth.signOut().then((value) async {
  //       StorePrefrences sp = StorePrefrences();
  //       await sp.setIsFirstOpen(false);
  //
  //       print("user data is ssss" + auth.currentUser.toString());
  //
  //       Get.snackbar('Sign Out ', 'Successfully');
  //       // setLoading(false);
  //       Get.offAllNamed(AppRoutes.SIGN_IN);
  //     }).onError((error, stackTrace) {
  //       // setLoading(false);
  //       Get.snackbar('Error', error.toString());
  //     });
  //   } catch (e) {
  //     Get.snackbar("Error while logout", e.toString());
  //   }
  // }

  // final signInController = Get.put(SignInController());

  Future<CompanyModel> getUserData(String id) async {
    final snapshot =
        await _db.collection('company').where('id', isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => CompanyModel.fromJson(e)).single;
    return userData;
  }

  getUsersData() async {
    print('INSIDE FUNC');
    final id = auth.currentUser!.uid.toString();
    print('Email is : ' + id.toString());
    if (id != '') {
      return await getUserData(id);
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  updateUserData(CompanyModel companyModel) async {
    await _db
        .collection('company')
        .doc(auth.currentUser!.uid.toString())
        .update(companyModel.toJson()).then((value) {
          toastInfo(msg: 'Successfully update user data');
    }).onError((error, stackTrace) {
      toastInfo(msg: 'Something went wrong.');
      print('Error while updating is : ' +error.toString());
    });
  }

  updateUser(CompanyModel companyModel) async {
    await updateUserData(companyModel);
  }
}

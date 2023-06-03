import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ReUsable/models/userModel.dart';
import '../../../ReUsable/routes/names.dart';
import '../../sessionPages/sigin/controller.dart';
import 'index.dart';

class PersonController extends GetxController{

  PersonController();
  // String? name;


  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final userFocus = FocusNode();
  final phoneFocus = FocusNode();


  final state = PersonState();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String> [
        'openid',
      ]
  );
  final auth = FirebaseAuth.instance;
  // final db = FirebaseFirestore.instance.collection('admin');
final _db = FirebaseFirestore.instance;





  void setLoading(bool value){
    state.loading.value=value;
  }
  var doc_id = null;


  final picker = ImagePicker();


  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  XFile? _image;
  XFile? get image => _image;

  Future pickedImageFromGallery(BuildContext context , UserModel userModel) async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      print('Image path is : '+_image!.path.toString());
      uploadImage(context,userModel);
      update();

    }
  }
  //
  Future pickedImageFromCamera(BuildContext context,UserModel userModel) async {
    final pickedImage =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      print('Image path is : '+_image!.path.toString());
      uploadImage(context,userModel);
      // notifyListeners();
      update();
    }
  }
  void showImage(context , userModel) {
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
                    pickedImageFromCamera(context , userModel);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickedImageFromGallery(context , userModel);
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

  Future uploadImage(BuildContext context , UserModel userModel) async {
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

    _db.collection('users').doc(userModel.id).update({
      'photoUrl' : newUrl.toString(),
    }).then((value) {
      // setLoading(false);
      Get.snackbar('Congrats','Update successfull');
      _image = null;
    }).onError((error, stackTrace) {
      // setLoading(false);
      Get.snackbar('Error is',error.toString());
    });
  }



  void signOut ()async{
    try{
      await auth.signOut().then((value) async{
        // StorePrefrences sp = StorePrefrences();
        // await sp.setIsFirstOpen(false);

        print("user data is ssss"+auth.currentUser.toString());

        Get.snackbar('Sign Out ', 'Successfully');
        setLoading(false);
        Get.offAllNamed(AppRoutes.SIGN_IN);

      }).onError((error, stackTrace){
        setLoading(false);
        Get.snackbar('Error', error.toString());

      });

    }catch(e){
      Get.snackbar("Error while logout" , e.toString());
    }
  }

  final signInController = Get.put(SignInController());

  getUsersData() async{
    print('INSIDE FUNC');
    final email = await signInController.firebaseUser.value?.email;
    print('Email is : ' +email.toString());
    if(email != null) {
      return await signInController.getUserData(email);
    }else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }
  updateUser(UserModel user) async{
    await signInController.updateUserData(user);
  }

}
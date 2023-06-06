import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tours_guide/ReUsable/Components/sign_up_msg.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/Exceptions/signin_exceptions.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/models/userModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'index.dart';



class CompanySignUpController extends GetxController {
  final state = CompanySignUpState();
  CompanySignUpController();

  final _db = FirebaseFirestore.instance.collection('company');
  // final _db = FirebaseFirestore.instance.collection('users');
  final auth=FirebaseAuth.instance;

  XFile? _image;

  XFile? get image => _image;

//   this is to register with email and password
  // after registeration , store the user in database
  void registerUserWithEmailAndPassword(CompanyModel Compuser,String email,String password) async {
    state.loading.value = true;
    try {
      var user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            print(value.user!.uid.toString());
            toastInfo(msg: "Information Recieved");
            toastInfo(msg: "You'll recieve confirmation \nmail shortyly");
            Get.to(() => SignUpMsg());

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


// this function is to store user in Firebase FireStore
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


//  for registering and storing Company USer
  void storeUser(CompanyModel compUser, BuildContext context)  {

    registerUserWithEmailAndPassword(compUser,compUser.companyEmail, compUser.pass);

  }

  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;


  // picking up image from gallery

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

  // picking up image from camera
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

  // showing dialog box

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

  // uploading image to storage and storing its url in companyLogo
  Future uploadImage(BuildContext context) async {
    // setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/companyLogo' + DateTime.now().toString());
    firebase_storage.UploadTask uploadTask =
    storageRef.putFile(File(image!.path).absolute);

    print('upload task is : ' + uploadTask.toString());
    await Future.value(uploadTask);

    state.companyLogo = await storageRef.getDownloadURL();
    print(state.companyLogo.toString());
    return state.companyLogo;


  }


}
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';

import '../../../ReUsable/models/userModel.dart';
import '../../../ReUsable/routes/names.dart';
import 'index.dart';

class PersonController extends GetxController {
  PersonController();


  @override
  void onInit() {
    // TODO: implement onInit
    _loadThemeMode();
    super.onInit();

  }

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final userFocus = FocusNode();
  final phoneFocus = FocusNode();

  final state = PersonState();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'openid',
    ],
  );

  String userProfileImage = '';
  final auth = FirebaseAuth.instance;

  final _db = FirebaseFirestore.instance;

  void setLoading(bool value) {
    state.loading.value = value;
  }

  var doc_id = null;

  final picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  XFile? _image;

  XFile? get image => _image;

  Future pickedImageFromGallery(
      BuildContext context, UserModel userModel) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context, userModel);
      update();
    }
  }

  //
  Future pickedImageFromCamera(
      BuildContext context, UserModel userModel) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context, userModel);
      update();
    }
  }

  void showImage(context, userModel) {
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
                    pickedImageFromCamera(context, userModel);
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.camera),
                  title: Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickedImageFromGallery(context, userModel);
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

  Future uploadImage(BuildContext context, UserModel userModel) async {
    // setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + DateTime.now().toString());
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    userProfileImage = await storageRef.getDownloadURL();

    _db.collection('users').doc(auth.currentUser!.uid.toString()).update({
      'photoUrl': userProfileImage.toString(),
    }).then((value) {
      // setLoading(false);
      Get.snackbar('Congrats', 'Update successfull');
      _image = null;
    }).onError((error, stackTrace) {
      // setLoading(false);
      Get.snackbar('Error is', error.toString());
    });
  }

  void signOut() async {
    setLoading(true);
    try {
      await auth.signOut().then((value) async {
        StorePrefrences sp = StorePrefrences();
        await sp.setIsFirstOpen(false);

        Get.snackbar('Sign Out ', 'Successfully');
        setLoading(false);
        Get.offAllNamed(AppRoutes.SIGN_IN);
      }).onError((error, stackTrace) {
        setLoading(false);
        Get.snackbar('Error', error.toString());
      });
    } catch (e) {
      setLoading(false);
      Get.snackbar("Error while logout", e.toString());
    }
  }

  Future<UserModel> getUserData(String id) async {
    final snapshot =
        await _db.collection('users').where('id', isEqualTo: id).get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
    return userData;
  }

  getUsersData() async {
    final id = auth.currentUser!.uid.toString();
    if (id != '') {
      return await getUserData(id);
    } else {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  updateUserData(UserModel user) async {
    await _db.collection('users').doc(user.id).update(
          user.toJson(),
        ).then((value) {
          Get.snackbar('Update', 'Successfully Updated');
    });
  }

  updateUser(UserModel user) async {
    await updateUserData(user);
  }


  void _saveThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', state.isDarkMode.value);
  }

  void _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    state.isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
  }
  void toggleTheme() {
    state.isDarkMode.value = !state.isDarkMode.value;
    Get.changeThemeMode(state.isDarkMode.value? ThemeMode.dark : ThemeMode.light);

    _saveThemeMode(); // Save the theme mode when it changes
  }

}

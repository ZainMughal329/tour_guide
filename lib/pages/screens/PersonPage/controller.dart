import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ReUsable/models/userModel.dart';
import '../../../ReUsable/routes/names.dart';
import 'index.dart';

class PersonController extends GetxController {
  PersonController();


  @override
  void onInit() {
    // TODO: implement onInit
    state.border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    _loadThemeMode();
    super.onInit();

  }


  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final userFocus = FocusNode();
  final phoneFocus = FocusNode();

  final state = PersonState();

  String userProfileImage = '';
  final auth = FirebaseAuth.instance;

  final _db = FirebaseFirestore.instance;

  void setLoading(bool value) {
    state.loading.value = value;
  }

  var doc_id = null;


  // --------------------------------------------------------------------
  // for store and upload image
  // {
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

  // }


  // --------------------------------------------------------------------
  // signOut method

  void signOut() async {
    setLoading(true);
    try {
      await auth.signOut().then((value) async {
        StorePrefrences sp = StorePrefrences();
        await sp.setIsFirstOpen(false);

        Get.snackbar('Sign Out ', 'Successfully');
        setLoading(false);
        Get.offAllNamed(AppRoutes.LOGIN_SIGN_UP);
      }).onError((error, stackTrace) {
        setLoading(false);
        Get.snackbar('Error', error.toString());
      });
    } catch (e) {
      setLoading(false);
      Get.snackbar("Error while logout", e.toString());
    }
  }


  // --------------------------------------------------------------------

  // for fetching particular user data
  Stream<DocumentSnapshot<Map<String, dynamic>>> getNodeData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid.toString())
        .snapshots();
  }


  // --------------------------------------------------------------------

  // for update and drawer screen
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

  // --------------------------------------------------------------------

  // for updating user
  updateUserData(UserModel user) async {
    setLoading(true);
    await _db.collection('users').doc(user.id).update(
          user.toJson(),
        ).then((value) {
          setLoading(false);
          Snackbar.showSnackBar('Update', 'Successfully Updated');
    });
  }

  updateUser(UserModel user) async {
    await updateUserData(user);
  }

  // --------------------------------------------------------------------

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


  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    state.cardNumber.value = creditCardModel!.cardNumber;
    state.expiryDate.value = creditCardModel.expiryDate;
    state.cardHolderName.value = creditCardModel.cardHolderName;
    state.cvvCode.value = creditCardModel.cvvCode;
    state.isCvvFocused.value = creditCardModel.isCvvFocused;
  }

  storeCardInfo(String cardNumber, expiryDate, cardHolderName, cvvCode) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('card')
        .doc(DateTime.timestamp().microsecondsSinceEpoch.toString())
        .set({
      'name': cardHolderName,
      'cardNumber': cardNumber,
      'cvv': cvvCode,
      'expiryDate': expiryDate,
    }).then((value) {
      state.cvvCode.value = '';
      state.cardHolderName.value = '';
      state.cardNumber.value = '';
      state.expiryDate.value = '';
      Get.snackbar('Success', 'Your Card is added successfully');


    }).onError((error, stackTrace) {
      Get.snackbar('Error', 'Error is:' + error.toString());
      print('Error is:' + error.toString());
    });
    return true;
  }

  final getUserCards = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('card')
      .snapshots();


  final String emailAddress = "thedevtech2022@gmail.com"; // Replace with your email address

  launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );
    final String gmailUrl = "googlegmail:///co?to=$emailAddress"; // Gmail app URI

    if (await canLaunch(gmailUrl)) {
      await launch(gmailUrl);
    } else if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch Gmail or email';

  }
  }

}

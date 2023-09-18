import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:password_strength/password_strength.dart';
import 'package:tours_guide/ReUsable/Components/exception_alert.dart';
import 'package:tours_guide/ReUsable/Components/sign_up_msg.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/Exceptions/signin_exceptions.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import '../../../ReUsable/models/userModel.dart';
import 'index.dart';

class SignupLoginController extends GetxController
    with GetTickerProviderStateMixin {
  final state = SignupLoginState();

  SignupLoginController();

  late TabController tabController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  // function to setLoading for buttons
  void setLoading(bool value){
    state.loading.value = value;
  }
  void setSignUpLoading(bool value){
    state.userSignUpLoading.value = value;
  }

  void setCompanyLoading(bool value){
    state.companySignUpLoading.value = value;
  }

  // {

  // functions for company signUp

  final _dbCompany = FirebaseFirestore.instance.collection('company');
  final auth = FirebaseAuth.instance;

  XFile? _image;

  XFile? get image => _image;

  final picker = ImagePicker();

  void setKeyStatus(bool status) {
    state.keyboardStatus.value = status;
  }

//   this is to register with email and password
  // after registeration , store the user in database
  void registerCompanyWithEmailAndPassword(BuildContext context,
      CompanyModel Compuser, String email, String password) async {
    setCompanyLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        toastInfo(msg: "Information Received");
        toastInfo(msg: "You'll receive confirmation \nmail shortly");

        // Get.to(() => SignUpMsg());

        setCompanyLoading(false);
        StorePrefrences sp = StorePrefrences();
        sp.setIsFirstOpen(true);
        Compuser.id = auth.currentUser!.uid.toString();
        // Write code to move to screen that show unApproved Status
        createCompany(context , Compuser);
        state.companyEmailController.clear();
        state.companyPassController.clear();
        state.companyNameController.clear();
        state.companyDescController.clear();
        state.companyPhoneNumberController.clear();
      }).onError((error, stackTrace) {
        ExceptionAlert.showExceptionAlert(context, error.toString());
        state.loading.value = false;
        // toastInfo(msg: error.toString());
      });
    } on FirebaseAuthException catch (e) {
      ExceptionAlert.showExceptionAlert(context, e.toString());
      // final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      // toastInfo(msg: ex.toString());
      state.loading.value = false;
    } catch (e) {
      ExceptionAlert.showExceptionAlert(context, e.toString());
      // ExceptionAlert.showExceptionAlert(context, e.toString());
      // print("Exception while creating company is" + e.toString());

      // ExceptionAlert.showExceptionAlert(context, e.toString(), AppRoutes.LOGIN_SIGN_UP);
      state.loading.value = false;
    }
  }

// this function is to store user in Firebase FireStore
  createCompany(BuildContext context ,CompanyModel user) async {
    // state.loading.value = true;
    try {
      await _dbCompany
          .doc(auth.currentUser!.uid.toString())
          .set(user.toJson())
          .then((value) {
        Get.to(() => CompanyApprovalPage());
        // auth.signOut();
        // Get.offAllNamed(AppRoutes.LOGIN_SIGN_UP);
        setCompanyLoading(false);
      }).onError((error, stackTrace) {
        setCompanyLoading(false);
        // toastInfo(msg: error.toString());
        ExceptionAlert.showExceptionAlert(context, error.toString());
      });
    } catch (e) {
      ExceptionAlert.showExceptionAlert(context, e.toString());
      toastInfo(msg: e.toString());
      setCompanyLoading(false);
    }
  }

//  for registering and storing Company USer
  void storeCompany( CompanyModel compUser, BuildContext context) {
    registerCompanyWithEmailAndPassword(context,
        compUser, compUser.companyEmail, compUser.pass);
  }
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;


  void validateCompanyPasswordStrength(String value) {
    state.companyPassStrength.value = estimatePasswordStrength(value);
  }

  String passwordCompanyStrengthLabel() {
    if (state.companyPassStrength.value < 0.3) {
      return "Weak";
    } else if (state.companyPassStrength.value < 0.7) {
      return "Fair";
    } else {
      return "Strong";
    }
  }

  bool companyFormIsValid() {
    return (state.companyEmailController.text.trim().isNotEmpty &&
        state.companyNameController.text.trim().isNotEmpty &&
        state.companyDescController.text.trim().isNotEmpty &&
        state.companyPhoneNumberController.text.trim().isNotEmpty &&
        state.companyPassController.text.trim().isNotEmpty &&
        state.companyPassStrength.value >= 0.3); // Add other validation rules as needed
  }



  // picking up image from gallery

  Future pickedImageFromGallery(BuildContext context) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context);
      update();
    }
  }

  // picking up image from camera
  Future pickedImageFromCamera(BuildContext context) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context);
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

    await Future.value(uploadTask);

    state.companyLogo = await storageRef.getDownloadURL();
    return state.companyLogo;
  }

// }

  final _dbUser = FirebaseFirestore.instance.collection('users');

  var verificationId = "".obs;

  void registerUserWithEmailAndPassword(BuildContext context ,
      UserModel userinfo, String email, password) async {
    setSignUpLoading(true);
    try {
      var user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        userinfo.id = auth.currentUser!.uid.toString();
        StorePrefrences sp = StorePrefrences();
        sp.setIsFirstOpen(true);
        createUser(context , userinfo);
      }).onError((error, stackTrace) {
        ExceptionAlert.showExceptionAlert(context, error.toString());
        setSignUpLoading(false);
        // toastInfo(msg: error.toString());
      });
    } on FirebaseAuthException catch (e) {
      ExceptionAlert.showExceptionAlert(context, e.toString());
      // final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      // toastInfo(msg: ex.toString());
      setSignUpLoading(false);
    } catch (e) {
      ExceptionAlert.showExceptionAlert(context, e.toString());
      setSignUpLoading(false);
    }
  }

  void loginUserWithEmailAndPassword(BuildContext context,String email, password) async {
    setLoading(true);
    try {
      var user = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print('inside then');
        final companyData = await _dbCompany
            .where('id', isEqualTo: auth.currentUser!.uid.toString())
            .get();
        if (companyData.docs.isNotEmpty) {
          print('inside company if');
          StorePrefrences().setIsFirstOpen(true);
          setLoading(false);
          Get.offAndToNamed(AppRoutes.Company_Home);
        } else {
          StorePrefrences().setIsFirstOpen(true);
          setLoading(false);
          Get.offAndToNamed(AppRoutes.Application);
        }
        setLoading(false);

        // state.loading.value = false;
        state.loginEmailController.clear();
        state.loginPasswordController.clear();
        // userController.clear();
      }).onError((error, stackTrace) {
        // final ex = SignUpWithEmailAndPasswordFailure.code(error.toString());
        ExceptionAlert.showExceptionAlert(context, error.toString());
        // toastInfo(msg: ex.toString());
        setLoading(false);
      });
    } on FirebaseAuthException catch (e) {
      // final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      // toastInfo(msg: ex.toString());
      ExceptionAlert.showExceptionAlert(context, e.toString());
      setLoading(false);
    } catch (e) {

      ExceptionAlert.showExceptionAlert(context, e.toString());
      // print("Exception while login  is" + e.toString());

      setLoading(false);
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
    final snapshot = await _dbUser.where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
    return userData;
  }

  createUser(BuildContext context , UserModel user) async {
    setSignUpLoading(true);
   try{
     await _dbUser
         .doc(auth.currentUser!.uid)
         .set(user.toJson())
         .whenComplete(() {
       toastInfo(msg: 'Successfully created account');

       setSignUpLoading(false);
       StorePrefrences sp = StorePrefrences();
       sp.setIsFirstOpen(true);
       Get.offAllNamed(AppRoutes.Application);
     }).catchError((error, stackTrace) {
       toastInfo(msg: "Error occurred");
       setSignUpLoading(false);
     });
   }catch(e){
     ExceptionAlert.showExceptionAlert(context, e.toString());
   }


  }

  void storeUser(
      UserModel user, BuildContext context, String email, String pass) async {
    registerUserWithEmailAndPassword(context, user, email, pass);
  }

  updateUserData(UserModel user) async {
    await _dbUser.doc(user.id).update(user.toJson());
  }



  void validatePasswordStrength(String value) {
    state.strength.value = estimatePasswordStrength(value);
  }

  String passwordStrengthLabel() {
    if (state.strength.value < 0.3) {
      return "Weak";
    } else if (state.strength.value < 0.7) {
      return "Fair";
    } else {
      return "Strong";
    }
  }

  bool formIsValid() {
    return (state.signUpEmailController.text.trim().isNotEmpty &&
        state.signUpUserController.text.trim().isNotEmpty &&
        state.signUpPasswordController.text.trim().isNotEmpty &&
        state.strength.value >= 0.3); // Add other validation rules as needed
  }


}

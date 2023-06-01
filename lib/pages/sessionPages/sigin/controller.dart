
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/Exceptions/signin_exceptions.dart';
import 'package:tours_guide/pages/sessionPages/sigin/state.dart';

import '../../../ReUsable/routes/names.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();

class SignInController extends GetxController {
  late final Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance.collection('users');
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

  void registerUserWithEmailAndPassword(String email, password) async {
    try {
      var user = auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {})
          .onError((error, stackTrace) {});
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      toastInfo(msg: ex.toString());
      print('Firebase Auth Exception : ' + e.code.toString());
    } catch (_) {}
  }

  void loginUserWithEmailAndPassword(String email, password) async {
    try {
      var user = auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {})
          .onError((error, stackTrace) {});
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      toastInfo(msg: ex.toString());
      print('Firebase Auth Exception : ' + e.code.toString());
    } catch (_) {}
  }


// Future<void> handleGoogleSignIn() async {
//   state.loading.value = true;
//   print('Enter inside func');
//   try {
//     var user = await _googleSignIn.signIn();
//     if (user != null) {
//       state.loading.value = false;
//       final _gAuthentication = await user.authentication;
//       final credential = GoogleAuthProvider.credential(
//         idToken: _gAuthentication.idToken,
//         accessToken: _gAuthentication.accessToken,
//       );
//       await FirebaseAuth.instance.signInWithCredential(credential);
//
//       // String? displayName = user.displayName ?? user.email;
//       // String? email = user.email;
//       // String id = user.id;
//       // String photoUrl = user.photoUrl ?? '';
//       // UserModel userModel = UserModel(
//       //     userName: displayName, phone: '', email: email, photoUrl: photoUrl);
//       //
//       var userbase = await db
//           .collection('users')
//           .withConverter(
//             fromFirestore: UserModel.fromJson,
//             toFirestore: (UserData userdata, options) =>
//                 userdata.toFirestore(),
//           )
//           .where("id", isEqualTo: id)
//           .get();
//
//       if (userbase.docs.isEmpty) {
//         final data = UserData(
//           id: id,
//           email: email,
//           name: displayName,
//           location: "",
//           fcmtoken: "",
//           photourl: photoUrl,
//           addtime: Timestamp.now(),
//         );
//         await db
//             .collection('users')
//             .withConverter(
//               fromFirestore: UserData.fromFirestore,
//               toFirestore: (UserData userdata, options) =>
//                   userdata.toFirestore(),
//             )
//             .add(data);
//       }
//       toastInfo(msg: 'Login Successfull');
//       // Get.offAndToNamed(AppRoutes.Application);
//       Get.toNamed(AppRoutes.Application);
//     }
//   } catch (e) {
//     toastInfo(msg: 'Error Occured');
//     print("Error is : " + e.toString());
//     state.loading.value = false;
//   }
// }
// /
// handleSignIn(BuildContext context, String email, String password) async {
//   state.loading.value = true;
//
//   print('Enter inside func');
//   try {
//     // var user = await _googleSignIn.signIn();
//     var user = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password)
//         .then((value) {
//
//       // StorePrefrences sp = StorePrefrences();
//       // sp.setIsFirstOpen(true);
//       // toastInfo(msg: "Account Created Successfully");
//     }).onError((error, stackTrace) {
//       // toastInfo(msg: error.toString());
//     });
//     var auth = await FirebaseAuth.instance;
//     // if (user != null) {
//     //   state.loading.value = false;
//     //   await _db.doc('outer').collection('email_users').add(user.toJson()).whenComplete(() {
//     //     Get.snackbar(
//     //       'Congrats',
//     //       'Your account has successfully created',
//     //       snackPosition: SnackPosition.BOTTOM,
//     //       colorText: Colors.green,
//     //       backgroundColor: Colors.green.withOpacity(0.1),
//     //     );
//     //   }).catchError((error, stackTrace) {
//     //     Get.snackbar(
//     //       'Error',
//     //       'Something went wrong ' + error.toString(),
//     //       snackPosition: SnackPosition.BOTTOM,
//     //       colorText: Colors.green,
//     //       backgroundColor: Colors.green.withOpacity(0.1),
//     //     );
//     //   });
//     // }
//   } catch (e) {
//     toastInfo(msg: 'Error Occured');
//     print("Error is" + e.toString());
//     state.loading.value = false;
//   }
// }
//
//   handleSignIn(String email , password , BuildContext context) async {
//     var user = await auth.createUserWithEmailAndPassword(email: email, password: password);
//     String userName = user.user.u
//
//
//     if(user == null) {
//       var data = UserModel(userName: '', phone: phone, email: email, photoUrl: photoUrl)
//     }
// await db.collection('users').withConverter(fromFirestore: UserModel.fromJson, toFirestore: (UserModel userModel ,options) => userModel.toJson()).add(data);
//   }
//
//   Future<UserModel> getUserData(String email) async {
//     final snapshot = await _db.where('Email', isEqualTo: email).get();
//     final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
//     return userData;
//   }
//
//   createUser(UserModel user) async {
//     await _db.add(user.toJson()).whenComplete(() {
//       // sp.setIsFirstOpen(true);
//       Get.snackbar(
//         'Congrats',
//         'Your account has successfully created',
//         snackPosition: SnackPosition.BOTTOM,
//         colorText: Colors.green,
//         backgroundColor: Colors.green.withOpacity(0.1),
//       );
//     }).catchError((error, stackTrace) {
//       Get.snackbar(
//         'Error',
//         'Something went wrong ' + error.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         colorText: Colors.green,
//         backgroundColor: Colors.green.withOpacity(0.1),
//       );
//     });
//   }
//
//   void storeUser(UserModel user, BuildContext context) async {
//     await createUser(user);
//     handleSignIn(context, user.email, user.password);
//     Get.offAll(AppRoutes.Application);
//   }
//
//   // @override
//   // void onReady() {
//   //   // TODO: implement onReady
//   //   super.onReady();
//   //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
//   //     if (user == null) {
//   //       print('User is log out');
//   //     } else {
//   //       print('User is login');
//   //     }
//   //   });
//   // }
//
//   void login(String email, String password) {
//     state.loading.value = true;
//     try {
//       FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password)
//           .then((value) {
//         StorePrefrences sp = StorePrefrences();
//         sp.setIsFirstOpen(true);
//         state.loading.value = false;
//         Get.offAndToNamed(AppRoutes.Application);
//         toastInfo(msg: 'Login successfull');
//       }).onError((error, stackTrace) {
//         state.loading.value = false;
//         toastInfo(msg: 'Error occured \n' + error.toString());
//       });
//     } catch (e) {
//       toastInfo(msg: e.toString());
//       state.loading.value = false;
//     }
//   }
//
//   updateUserData(UserModel user) async {
//     await db.collection('users').doc(user.id).update(user.toJson());
//   }
}

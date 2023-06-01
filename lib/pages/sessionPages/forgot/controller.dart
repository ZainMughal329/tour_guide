
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/sessionPages/forgot/state.dart';

class ForgotPassController extends GetxController{
  ForgotPassState state = ForgotPassState();
  ForgotPassController();
  final auth = FirebaseAuth.instance;

  void setLoading(bool value){
    state.loading.value=value;
  }

// void sendResetMail (String email)async{
//   setLoading(true);
//   try{
//     await auth.sendPasswordResetEmail(email: email).then((value){
//       SnackBar.showSnackBar("Mail Sent", "Check your email ");
//       setLoading(false);
//       Get.offAllNamed(AppRoutes.SIGN_IN);
//     }).onError((error, stackTrace){
//       setLoading(false);
//       SnackBar.showSnackBar('Error Occured', error.toString());
//
//     });
//   }catch(e){
//     SnackBar.showSnackBar("Error", e.toString());
//   }
// }

}
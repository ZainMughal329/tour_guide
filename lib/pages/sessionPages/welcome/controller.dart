
import 'package:tours_guide/pages/sessionPages/welcome/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../ReUsable/Components/snackBar.dart';
import '../../../ReUsable/routes/names.dart';


class WelcomeController extends GetxController {
  final state = WelcomeState();
  WelcomeController();








  changePage(int index) async {
    state.index.value = index ;
  }
  // handleSignIn() async{
  //   // await ConfigStore.to.saveAlreadyOpen();
  //   // await ConfigStore.to.setFirstOpen(true);
  //   StorePrefrences sp = StorePrefrences();
  //   //new
  //   // sp.getIsFirstOpen();
  //   await sp.setIsFirstOpen(true);
  //   print("welcome first open is asfasdf"+sp.getIsFirstOpen().toString());
  //
  //
  //   try{
  //     final auth =  FirebaseAuth.instance;
  //     if(auth.currentUser!= null){
  //       print(auth.currentUser!.uid.toString());
  //       Get.offAllNamed(AppRoutes.Application);
  //     }else{
  //       print(auth.currentUser.toString()+"empty user");
  //       Get.offAndToNamed(AppRoutes.SIGN_IN);
  //     }
  //   }catch (e){
  //     SnackBar.showSnackBar('Error', e.toString());
  //   }
  //
  // }
}
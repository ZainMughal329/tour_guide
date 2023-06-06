import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/sessionPages/welcome/state.dart';

import '../../../ReUsable/Components/snackBar.dart';
import '../../../ReUsable/routes/names.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();
  WelcomeController();

  changePage(int index) async {
    state.index.value = index;
  }

  handleSignIn() async {
    try {
      final auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        Get.offAllNamed(AppRoutes.Application);
      } else {
        Get.offAndToNamed(AppRoutes.SIGN_IN);
      }
    } catch (e) {
      SnackBar.showSnackBar('Error', e.toString());
    }
  }
}

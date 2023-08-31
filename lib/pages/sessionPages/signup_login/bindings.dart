import 'package:get/get.dart';

import 'index.dart';

class SignupLoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupLoginController>(() => SignupLoginController());
  }
}

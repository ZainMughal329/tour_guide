
import 'package:get/get.dart';

import 'controller.dart';

class ForgotPassBinding implements Bindings {
  @override
  void dependencies() {
   Get.lazyPut<ForgotPassController>(() => ForgotPassController());
  }

}
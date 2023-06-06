import 'package:get/get.dart';

import 'controller.dart';

class CompanySignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanySignUpController>(() => CompanySignUpController());
  }
}

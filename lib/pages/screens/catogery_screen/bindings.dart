import 'package:get/get.dart';

import '../../companyScreen/company_profile/controller.dart';
import 'controller.dart';

class catogeryScreenBinding implements Bindings {
  @override
  void dependencies() {

    Get.lazyPut<catogeryScreenController>(() => catogeryScreenController());

  }
}

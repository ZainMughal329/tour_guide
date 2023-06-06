import 'package:get/get.dart';

import '../../companyScreen/company_profile/controller.dart';
import 'controller.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      CompanyProfileController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

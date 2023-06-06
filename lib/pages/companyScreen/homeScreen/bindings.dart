import 'package:get/get.dart';

import 'controller.dart';

// import '../../welcome/controller.dart';

class CompanyHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyHomeController> ( () => CompanyHomeController());

  }

}
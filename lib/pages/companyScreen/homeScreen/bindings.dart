import 'package:get/get.dart';
import 'package:tours_guide/pages/companyScreen/add_tour/controller.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/controller.dart';

import 'controller.dart';

// import '../../welcome/controller.dart';

class CompanyHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyHomeController> ( () => CompanyHomeController());
    Get.lazyPut<CompanyProfileController>(() => CompanyProfileController());
    Get.lazyPut<CompanyAddTourController>(() => CompanyAddTourController());
  }

}
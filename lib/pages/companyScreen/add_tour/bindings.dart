import 'package:get/get.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/controller.dart';

import 'index.dart';

class CompanyAddTourBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CompanyAddTourController>(() => CompanyAddTourController());
  }

}
import 'package:get/get.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/controller.dart';

class CompanyProfileBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CompanyProfileController>(() => CompanyProfileController());
  }

}
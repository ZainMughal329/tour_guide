import 'package:get/get.dart';
import 'package:tours_guide/pages/companyScreen/add_tour/controller.dart';
import 'package:tours_guide/pages/companyScreen/bookings/controller.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/controller.dart';
import 'package:tours_guide/pages/companyScreen/show_tour/controller.dart';

import 'controller.dart';

class CompanyHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyHomeController>(() => CompanyHomeController());
    Get.lazyPut<CompanyProfileController>(() => CompanyProfileController());
    Get.lazyPut<CompanyAddTourController>(() => CompanyAddTourController());
    Get.lazyPut<CompanyShowTourController>(() => CompanyShowTourController());
    Get.lazyPut<CompanyBookingController>(() => CompanyBookingController());
  }
}

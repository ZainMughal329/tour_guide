import 'package:get/get.dart';
import 'package:tours_guide/pages/companyScreen/bookings/controller.dart';

class CompanyBookingBindings implements  Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CompanyBookingController>(() => CompanyBookingController());
  }

}
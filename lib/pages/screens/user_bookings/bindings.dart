import 'package:get/get.dart';
import 'package:tours_guide/pages/screens/user_bookings/controller.dart';

class UserBookingBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<UserBookingController>(() => UserBookingController());
  }




}
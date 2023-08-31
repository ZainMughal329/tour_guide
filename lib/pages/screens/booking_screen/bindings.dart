import 'package:get/get.dart';
import 'package:tours_guide/pages/screens/booking_screen/controller.dart';

class BookingBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<BookingController>(() => BookingController());
  }

}
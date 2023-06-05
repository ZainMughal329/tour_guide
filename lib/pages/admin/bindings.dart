import 'package:get/get.dart';
import 'package:tours_guide/pages/admin/controller.dart';

class AdminBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
  }

}
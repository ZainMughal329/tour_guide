
import 'package:get/get.dart';

import 'index.dart';

// import '../../welcome/controller.dart';

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController> ( () => SplashScreenController());
  }

}
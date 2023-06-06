import 'package:get/get.dart';
import 'package:tours_guide/pages/screens/PersonPage/controller.dart';

import '../screens/GoogleMap/controller.dart';
import '../screens/home_screen/controller.dart';
import '../screens/search_screen/controller.dart';
import 'controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(
      () => ApplicationController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SearchController>(
      () => SearchController(),
    );
    Get.lazyPut<MapController>(
      () => MapController(),
    );
    Get.lazyPut<PersonController>(
      () => PersonController(),
    );
  }
}

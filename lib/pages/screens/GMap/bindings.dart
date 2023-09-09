import 'package:get/get.dart';
import 'package:tours_guide/pages/screens/GMap/controller.dart';

class GMapBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GMapController>(() => GMapController());
  }

}
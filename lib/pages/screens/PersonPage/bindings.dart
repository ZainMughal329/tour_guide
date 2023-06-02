// import 'package:air_proj_comp/pages/PersonPage/controller.dart';
import 'package:get/get.dart';

// import 'index.dart';
import 'index.dart';
class PersonBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<PersonController>(() => PersonController());
  }

}
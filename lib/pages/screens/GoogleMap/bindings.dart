import 'package:get/get.dart';

// import 'index.dart';
import 'index.dart';

class MapBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MapController>(() => MapController());
  }
}

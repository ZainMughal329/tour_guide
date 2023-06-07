import 'package:get/get.dart';

import 'index.dart';

class CompanyShowTourBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CompanyShowTourController>(() => CompanyShowTourController());
  }
}

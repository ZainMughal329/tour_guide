import 'package:get/get.dart';

import 'index.dart';

class CompanyAddTourBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CompanyAddTourController>(() => CompanyAddTourController());
  }
}

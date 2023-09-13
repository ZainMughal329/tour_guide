import 'package:get/get.dart';

import 'controller.dart';

class FavouriteBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<FavouriteController>(() => FavouriteController());
  }




}
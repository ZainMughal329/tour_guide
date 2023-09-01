import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SearchState {
  RxBool isDropdownOpen = false.obs;
  RxString selectedItem = ''.obs;

  final searchController = TextEditingController();

}

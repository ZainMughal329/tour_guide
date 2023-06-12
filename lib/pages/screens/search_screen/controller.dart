import 'package:get/get.dart';

import 'index.dart';

class SearchBarController extends GetxController {
  final state = SearchState();
  SearchBarController();

  toggleDropdown() {
    state.isDropdownOpen.value = !state.isDropdownOpen.value;
  }

  selectItem(String item) {
    state.selectedItem.value = item;
  }
}

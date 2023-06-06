import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/application/state.dart';

import '../../ReUsable/Components/app_colors.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();
  ApplicationController();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  void handlePageChanged(int index) {
    state.page = index;
  }

  void handleNavBarChange(int index) {
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    tabTitles = ['Home', 'Search', 'Map', 'Person'];
    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home_filled,
            color: AppColors.unActiveIconColor,
          ),
          activeIcon: Icon(
            Icons.home_filled,
            color: AppColors.activeIconColor,
          ),
          label: 'Home',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: AppColors.unActiveIconColor,
          ),
          activeIcon: Icon(
            Icons.search,
            color: AppColors.activeIconColor,
          ),
          label: 'Contact',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.map_outlined,
            color: AppColors.unActiveIconColor,
          ),
          activeIcon: Icon(
            Icons.map_outlined,
            color: AppColors.activeIconColor,
          ),
          label: 'Contact',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: AppColors.unActiveIconColor,
          ),
          activeIcon: Icon(
            Icons.person,
            color: AppColors.activeIconColor,
          ),
          label: 'Person',
          backgroundColor: AppColors.primaryBackground),
    ];
    pageController = PageController(initialPage: state.page);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
}

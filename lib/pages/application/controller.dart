
import 'package:flutter/cupertino.dart';
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

    tabTitles = ['Home', 'Search', 'Map' , 'Person'];
    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home_filled,
            color: AppColors.thirdElementText,
          ),
          activeIcon: Icon(
            Icons.home_filled,
            color: AppColors.secondaryElementText,
          ),
          label: 'Home',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: AppColors.thirdElementText,
          ),
          activeIcon: Icon(
            Icons.search,
            color: AppColors.secondaryElementText,
          ),
          label: 'Contact',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.map_outlined,
            color: AppColors.thirdElementText,
          ),
          activeIcon: Icon(
            Icons.map_outlined,
            color: AppColors.secondaryElementText,
          ),
          label: 'Contact',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: AppColors.thirdElementText,
          ),
          activeIcon: Icon(
            Icons.person,
            color: AppColors.secondaryElementText,
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

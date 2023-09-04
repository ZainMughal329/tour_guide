import 'package:cloud_firestore/cloud_firestore.dart';
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
  
  final fireStoreTours = FirebaseFirestore.instance.collection("allTours").snapshots();
  

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
            color: AppColors.lightInActiveIconColor,
          ),
          activeIcon: Icon(
            Icons.home_filled,
            color: AppColors.lightActiveIconColor,
          ),
          label: 'Home',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: AppColors.lightInActiveIconColor,
          ),
          activeIcon: Icon(
            Icons.search,
            color: AppColors.lightActiveIconColor,
          ),
          label: 'Search',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.map_outlined,
            color: AppColors.lightInActiveIconColor,
          ),
          activeIcon: Icon(
            Icons.map_outlined,
            color: AppColors.lightActiveIconColor,
          ),
          label: 'Map',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: AppColors.lightInActiveIconColor,
          ),
          activeIcon: Icon(
            Icons.person,
            color: AppColors.lightActiveIconColor,
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

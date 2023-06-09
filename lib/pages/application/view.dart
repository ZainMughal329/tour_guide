import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/pages/screens/GoogleMap/index.dart';

import '../../ReUsable/Components/app_colors.dart';
import '../screens/PersonPage/view.dart';
import '../screens/home_screen/view.dart';
import '../screens/search_screen/view.dart';
import 'controller.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({Key? key}) : super(key: key);

  Widget _buildPage() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.handlePageChanged,
      children:  [
        HomePage(),
        SearchView(),
        MapPage(),
        PersonView(),
      ],
    );
  }

  Widget _buildNavBar() {
    return Obx(
      () => BottomNavigationBar(
        backgroundColor: AppColors.unActiveIconColor.withOpacity(0.4),
        items: controller.bottomTabs,
        currentIndex: controller.state.page,
        onTap: controller.handleNavBarChange,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white ,
        unselectedItemColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.unActiveIconColor.withOpacity(0.5),
      body: _buildPage(),
      bottomNavigationBar: _buildNavBar(),
    );
  }
}

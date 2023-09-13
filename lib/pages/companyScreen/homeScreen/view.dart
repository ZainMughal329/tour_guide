import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/sign_up_msg.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/companyScreen/add_tour/index.dart';
import 'package:tours_guide/pages/companyScreen/bookings/view.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/index.dart';

import '../../../ReUsable/Components/company_drawer.dart';
import '../../../ReUsable/Components/tab_bar_settings.dart';
import '../../../ReUsable/models/companyModel.dart';
import '../show_tour/view.dart';
import 'controller.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({Key? key}) : super(key: key);

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome>
    with TickerProviderStateMixin {
  final controller = Get.put(CompanyHomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _tabController = TabController(length: 4, vsync: this);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: controller.getUsersData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  CompanyModel company = snapshot.data as CompanyModel;
                  if (company.status == 'true') {
                    return Scaffold(
                      key: _scaffoldKey,
                      drawer: BuildCompanyDrawer.buildDrawer(context),
                      resizeToAvoidBottomInset: false,
                      backgroundColor: AppColors.lightBgColor,
                      body: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 20,
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _scaffoldKey.currentState!.openDrawer();

                                      },
                                      child: Icon(Icons.menu,
                                          size: 30.sp,
                                          color:
                                              AppColors.lightActiveIconColor),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                      width: 40.w,
                                      height: 40.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        // color: AppColors.iconsColor,
                                        border: Border.all(
                                          color: AppColors.lightActiveIconColor,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: company.logo.toString() == ''
                                            ? Icon(
                                                Icons.person_outline,
                                                size: 30.sp,
                                                color: AppColors
                                                    .lightActiveIconColor,
                                              )
                                            : Image(
                                                image: NetworkImage(
                                                  company.logo.toString(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                child: Center(
                                  child: BigAppText(
                                      text: company.companyName
                                          .toString()
                                          .capitalizeFirst
                                          .toString(),
                                      size: 30),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: TabBar(
                                    isScrollable: true,
                                    labelPadding: EdgeInsets.only(
                                        right: 20.w, left: 20.w),
                                    indicator: CircleTabIndicator(
                                        color: AppColors.lightButtonColor,
                                        radius: 4),
                                    controller: _tabController,
                                    labelColor: AppColors.lightTextColor,
                                    unselectedLabelColor: Colors.grey,
                                    tabs: [
                                      Tab(
                                        text: 'Profile',
                                      ),
                                      Tab(
                                        text: 'All tour',
                                      ),
                                      Tab(
                                        text: 'Add tour',
                                      ),
                                      Tab(
                                        text: 'All Bookings',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: double.infinity,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    // Get.offAndToNamed(page)
                                    Container(
                                      child: CompanyProfileView(),
                                    ),
                                    CompanyShowTourScreen(),
                                    Scaffold(
                                      body: SafeArea(
                                        child: InkWell(
                                          onTap: (){

                                          },
                                          child: Center(
                                            child: TextButton(child: Text("Add Tour +",
                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 50.sp,color: Colors.blue),
                                            ),
                                              onPressed: (){
                                                Get.toNamed(AppRoutes.Company_AddTour);
                                              },

                                               ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    CompanyBookingsView(uid: controller.state.id.toString(),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return CompanyApprovalPage();
                  }
                } else {
                  return Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                print("here is code");
                return Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}

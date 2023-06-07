import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Prefrences/storage_pref.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/companyScreen/add_tour/index.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/index.dart';

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

  @override
  Widget build(BuildContext context) {
    final _tabController = TabController(length: 3, vsync: this);

    return Container(
      child: FutureBuilder(
        future: controller.getUsersData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              CompanyModel company = snapshot.data as CompanyModel;
              if (company.status == 'true') {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
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
                                Icon(Icons.menu,
                                    size: 30, color: Colors.black54),
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[500],
                                    border: Border.all(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: company.logo.toString() == ''
                                        ? Icon(
                                            Icons.person_outline,
                                            size: 30,
                                            color: Colors.white,
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
                                  text: company.companyName.toString(),
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
                                labelPadding:
                                    EdgeInsets.only(right: 20.w, left: 20.w),
                                indicator: CircleTabIndicator(
                                    color: Colors.black, radius: 4),
                                controller: _tabController,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                tabs: [
                                  Tab(
                                    text: 'All tour',
                                  ),
                                  Tab(
                                    text: 'Add tour',
                                  ),
                                  Tab(
                                    text: 'Profile',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 450.h,
                            width: double.infinity,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                Center(
                                  child: CompanyShowTourScreen(),
                                ),
                                Center(
                                  child: CompanyAddTourScreen(),
                                ),
                                Container(
                                  child: CompanyProfileView(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  body: SafeArea(
                      child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            height: 200.h,
                            decoration: BoxDecoration(
                              color: Color(0xFFEDE2E6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'We have recieved your information.\n'
                                'You will get confirmation shortly.\nThank You.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await controller.auth.signOut();
                            StorePrefrences sp = StorePrefrences();
                            sp.setIsFirstOpen(false);
                            Get.offAndToNamed(AppRoutes.SIGN_IN);
                          },
                          child: Text('Back to login page'),
                        ),
                      ],
                    ),
                  )),
                );
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
        },
      ),
    );
  }
}

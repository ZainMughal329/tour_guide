import 'dart:async';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/exception_alert.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/ReUsable/models/userModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/admin/showAllTours.dart';
import 'package:tours_guide/pages/screens/catogery_screen/index.dart';
import 'package:tours_guide/pages/screens/home_screen/comming_soon.dart';
import 'package:tours_guide/pages/screens/home_screen/show_all_tours.dart';

import '../../../ReUsable/Components/app_bar.dart';
import 'details.dart';
import '../../../ReUsable/Components/drawer.dart';
import 'controller.dart';

//

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final controller = Get.put<HomeController>(HomeController());

  // final con = Get.lazyPut<HomeController>(() => HomeController());
  Widget _buildCard(
      BuildContext context,
      String title,
      String loc,
      String price,
      String des,
      String imageUrl,
      String id,
      String phone,
      String companyName,
      String companyId,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: () {
          Get.to(
            () => DetailScreen(
              title: title,
              price: price,
              location: loc,
              des: des,
              img: imageUrl,
              id: id,
              phone: phone,
              comapnyName: companyName,
              companyId: companyId,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: Container(
            height: 277.h,
            width: 201.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover),
              color: Colors.transparent,
            ),
            child: Container(
              height: 277.h,
              width: 201.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Color(0xff061627).withOpacity(0),
                    Color(0xff082F45),
                    // Colors.black
                  ], stops: [
                    0.35,
                    1.0
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    child: Text(
                      'Starting at \$' + price.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLastCard(
      BuildContext context,
      String title,
      String loc,
      String price,
      String des,
      String imageUrl,
      String id,
      String phone,
      String companyName,
      String companyId
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: () {
          Get.to(
            () => ShowAllToursToUser(),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(right: 18.w),
          child: Container(
            height: 277.h,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover),
              color: Colors.transparent,
            ),
            child: Container(
              height: 277.h,
              width: 120.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Color(0xff061627).withOpacity(0.5),
                    Color(0xff082F45),
                    // Colors.black
                  ], stops: [
                    0.0,
                    1.0
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardView(String title, String img) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 40.w,
          width: 40.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.lightTextColor,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(
              image: AssetImage(img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          title,
          style: TextStyle(
              color: AppColors.lightTextColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildPopularCategory(String title, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          height: 60.w,
          width: 60.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
              child: Icon(
            icon,
            color: Colors.white,
            size: 30.sp,
          )),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          title,
          style: TextStyle(
            color: AppColors.lightTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff081921),
      backgroundColor: AppColors.lightBgColor,
      key: _scaffoldKey,

      drawer: BuildDrawer.buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Container(
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: controller.getCurrentUserData(),
                      builder: (context, snapshot) {
                        // UserModel userModel = snapshot.data as UserModel;

                          if (snapshot.hasData) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          _scaffoldKey.currentState!.openDrawer();
                                        },
                                        child: Icon(
                                          Icons.menu,
                                          color: AppColors.lightTextColor,
                                          size: 35.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Center(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Welcome back 🖐🏻',
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: AppColors.lightTextColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Text(
                                            snapshot.data!['userName']
                                                .toString()
                                                .capitalizeFirst
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: AppColors.lightTextColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 50.w,
                                  height: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color:
                                      snapshot.data!['photoUrl'].toString() ==
                                          ''
                                          ? AppColors.lightTextColor
                                          : Colors.white,
                                      width: 1.0.w,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child:
                                    snapshot.data!['photoUrl'].toString() ==
                                        ''
                                        ? Icon(
                                      Icons.person_outline,
                                      size: 30.sp,
                                      color: AppColors.lightTextColor,
                                    )
                                        : Image(
                                      image: NetworkImage(
                                        snapshot.data!['photoUrl']
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          else if(snapshot.connectionState != ConnectionState.active){

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          else if (snapshot.hasError) {
                            // WidgetsBinding.instance.addPostFrameCallback((_) {
                            //   ExceptionAlert.showExceptionAlert(context, 'Error While Fetching Data.');
                            // });

                            toastInfo(msg: "Something went wrong");
                            print('Inside snapshot error');
                            return SizedBox();
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                        // return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left:8.0),
                  child: Text(
                    'Discover',
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightTextColor),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left:8.0),
                  child: Text(
                    'Explore the best places in the world!',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.lightTextColor,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < 6; i++)
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                // color: Color(0xff0c3e4f),
                                color:
                                    AppColors.lightCardColor.withOpacity(0.07),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.lightActiveIconColor
                                      .withOpacity(0.1),
                                )
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black26,
                                //     blurRadius: 4,
                                //   ),
                                // ],
                                ),
                            child: _buildCardView(
                              controller.category[i],
                              "assets/images/img${i}.jpg",
                            ),
                          ),
                          onTap: () {
                            // Get.toNamed(AppRoutes.catScreen);
                            Get.to(() => catogeryScreenPage(
                                  catogery: controller.category[i],
                                ));
                            // Get.to(()=>catogeryScreenPage());
                          },
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 300.h,
                  child: FutureBuilder<List<TourModel>>(
                    future: controller.getAndShowALlToursData(),
                    builder: (BuildContext context, snapshot) {
                      try {
                        // TourModel tourModel = snapshot.data as TourModel;
                        if (snapshot.hasData) {
                          print("Length is : "+snapshot.data!.length.toString());
                          return snapshot.data!.length != 0
                              ? Container(
                                  height: 250.h,
                                  child: ListView.builder(
                                      // shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        if (index >= 4) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              PageTransitionSwitcher(
                                                duration: Duration(seconds: 1),
                                                transitionBuilder: (child,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    FadeThroughTransition(
                                                  fillColor: Colors.transparent,
                                                  animation: animation,
                                                  secondaryAnimation:
                                                      secondaryAnimation,
                                                  child: child,
                                                ),
                                                child: _buildLastCard(
                                                  context,
                                                  snapshot.data![index].title
                                                      .toString(),
                                                  snapshot.data![index].location
                                                      .toString(),
                                                  snapshot.data![index].price
                                                      .toString(),
                                                  snapshot.data![index]
                                                      .tourDescription
                                                      .toString(),
                                                  snapshot
                                                      .data![index].tourImage
                                                      .toString(),
                                                  snapshot.data![index].id
                                                      .toString(),
                                                  snapshot
                                                      .data![index].companyPhone
                                                      .toString(),
                                                  snapshot
                                                      .data![index].companyName
                                                      .toString(),
                                                  snapshot
                                                      .data![index].companyId
                                                      .toString(),

                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              PageTransitionSwitcher(
                                                duration: Duration(seconds: 1),
                                                transitionBuilder: (child,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    FadeThroughTransition(
                                                  fillColor: Colors.transparent,
                                                  animation: animation,
                                                  secondaryAnimation:
                                                      secondaryAnimation,
                                                  child: child,
                                                ),
                                                child: _buildCard(
                                                  context,
                                                  snapshot.data![index].title
                                                      .toString(),
                                                  snapshot.data![index].location
                                                      .toString(),
                                                  snapshot.data![index].price
                                                      .toString(),
                                                  snapshot.data![index]
                                                      .tourDescription
                                                      .toString(),
                                                  snapshot
                                                      .data![index].tourImage
                                                      .toString(),
                                                  snapshot.data![index].id
                                                      .toString(),
                                                  snapshot
                                                      .data![index].companyPhone
                                                      .toString(),
                                                  snapshot
                                                      .data![index].companyName
                                                      .toString(),
                                                  snapshot
                                                      .data![index].companyId
                                                      .toString(),

                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      }),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'No new companies to approved',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: AppColors.lightTextColor),
                                      ),
                                    ),
                                  ],
                                );
                        }


                        else if (snapshot.hasError) {

                          // print("inside 2nd circle  : " + snapshot.error.toString());
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return SizedBox();
                        }
                      } catch (e) {

                        ExceptionAlert.showExceptionAlert(context, e.toString());
                        // ExceptionAlert.showExceptionAlert(context, e.toString(), AppRoutes.Application);
                        // print('Error is : ' + e.toString());
                        return Text(
                          'data : ' + e.toString(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Popular Categories',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightTextColor,
                      fontSize: 18.sp),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => CommingSoon(
                            color: Color(0xff1C939B),
                            title: 'Trips',
                          ),
                        );
                      },
                      child: _buildPopularCategory(
                        'Trips',
                        Icons.airplanemode_active_outlined,
                        Color(0xff1C939B),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => CommingSoon(
                            color: Color(0xffDB8D1E),
                            title: 'Hotels',
                          ),
                        );
                      },
                      child: _buildPopularCategory(
                        'Hotels',
                        Icons.hotel,
                        Color(0xffDB8D1E),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => CommingSoon(
                            color: Color(0xffE5291D),
                            title: 'Events',
                          ),
                        );
                      },
                      child: _buildPopularCategory(
                        'Events',
                        Icons.event,
                        Color(0xffE5291D),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => CommingSoon(
                            color: Color(0xff3E79EA),
                            title: 'Transport',
                          ),
                        );
                      },
                      child: _buildPopularCategory(
                        'Transport',
                        Icons.car_rental_outlined,
                        Color(0xff3E79EA),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: [],),
    );
  }
}

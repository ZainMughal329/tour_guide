import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/ReUsable/models/userModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/screens/catogery_screen/index.dart';

import '../../../ReUsable/Components/app_bar.dart';
import 'details.dart';
import '../../../ReUsable/Components/drawer.dart';
import 'controller.dart';

//

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildCard(BuildContext context, String title, String loc,
      String price, String des, String imageUrl, String id, String phone) {
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
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Container(
            height: 297,
            width: 201,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover),
              color: Colors.transparent,
            ),
            child: Container(
              height: 297,
              width: 201,
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

  Widget _buildCardView(String title, String img) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 40.w,
          width: 40.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
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
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
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
            color: Colors.white,
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
      backgroundColor: Color(0xff081921),
      key: _scaffoldKey,

      drawer: BuildDrawer.buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Container(
                    child: FutureBuilder(
                      future: controller.getUsersData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // print('waiting for connection state');
                          toastInfo(
                              msg: "waiting for connection ...",
                              length: Toast.LENGTH_SHORT);
                          return Center(
                            child: SizedBox(),
                          );
                        }
                        if (snapshot.hasError) {
                          toastInfo(msg: "Something went wrong");
                          print('Inside snapshot error');
                          return SizedBox();
                        }
                        UserModel userModel = snapshot.data as UserModel;
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
                                      color: Colors.blue,
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
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Text(
                                        userModel.userName
                                            .toString()
                                            .capitalizeFirst
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white,
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
                                  color: userModel.photoUrl.toString() == ''
                                      ? Colors.blue
                                      : Colors.white,
                                  width: 1.0.w,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: userModel.photoUrl.toString() == ''
                                    ? Icon(
                                        Icons.person_outline,
                                        size: 30,
                                        color: Colors.blue,
                                      )
                                    : Image(
                                        image: NetworkImage(
                                          userModel.photoUrl.toString(),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Discover',
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Explore the best places in the world!',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20.h,
                ),
                FutureBuilder(
                  future: controller.getUsersData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // print('waiting for connection state');
                      toastInfo(
                          msg: "waiting for connection ...",
                          length: Toast.LENGTH_SHORT);
                      return Center(
                        child: SizedBox(),
                      );
                    }
                    if (snapshot.hasError) {
                      toastInfo(msg: "Something went wrong");
                      print('Inside snapshot error');
                      return SizedBox();
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < 6; i++)
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xff0c3e4f),
                                  // gradient: LinearGradient(
                                  //     colors: [
                                  //       Color(0xff11C4EC),
                                  //       Color(0xff0388D3),
                                  //     ],
                                  //     begin: Alignment.topCenter,
                                  //     end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                    ),
                                  ],
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
                    );
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: FutureBuilder<List<TourModel>>(
                    future: controller.getAndShowALlToursData(),
                    builder: (BuildContext context, snapshot) {
                      try {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          print("inside first circle");
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          print("inside 2nd circle");
                          return Center(child: CircularProgressIndicator());
                        }
                        // TourModel tourModel = snapshot.data as TourModel;
                        print(snapshot.data!.length.toString());
                        return snapshot.data!.length != 0
                            ? Container(
                                height: 330.h,
                                child: ListView.builder(
                                    // shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
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
                                              snapshot
                                                  .data![index].tourDescription
                                                  .toString(),
                                              snapshot.data![index].tourImage
                                                  .toString(),
                                              snapshot.data![index].id
                                                  .toString(),
                                              snapshot.data![index].companyPhone
                                                  .toString(),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'No new companies to approved',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ],
                              );
                        ;
                      } catch (e) {
                        print('Error is : ' + e.toString());
                        return Text(
                          'data : ' + e.toString(),
                        );
                      }
                    },
                  ),
                ),
                // SizedBox(height: 20),
                Text(
                  'Popular Categories',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.sp),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPopularCategory(
                      'Trips',
                      Icons.airplanemode_active_outlined,
                      Color(0xff1C939B),
                    ),
                    _buildPopularCategory(
                      'Hotels',
                      Icons.hotel,
                      Color(0xffDB8D1E),
                    ),
                    _buildPopularCategory(
                      'Events',
                      Icons.event,
                      Color(0xffE5291D),
                    ),
                    _buildPopularCategory(
                      'Transport',
                      Icons.car_rental_outlined,
                      Color(0xff3E79EA),
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

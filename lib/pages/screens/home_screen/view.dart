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

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _buildCard(BuildContext context, String title, String loc,
      String price, String des, String imageUrl) {
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
                img: imageUrl),
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
                  gradient: LinearGradient(
                      colors: [
                        Color(0xff061627).withOpacity(0),
                        Color(0xff082F45),
                        // Colors.black
                      ],
                      stops: [
                        0.35,
                        1.0
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
        // Container(
        //   // height: 300,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(40),
        //     color: Colors.white,
        //   ),
        //   child: Stack(
        //     children: [
        //       Container(
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(15),
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.grey,
        //                 spreadRadius: 1,
        //               ),
        //             ],
        //             border: Border.all(width: 0.9, color: Colors.black)),
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(15),
        //           child: Image.network(
        //             imageUrl,
        //             fit: BoxFit.fill,
        //             height: 300.h,
        //             width: double.infinity,
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         top: 10,
        //         left: 10,
        //         child: Container(
        //           decoration: BoxDecoration(
        //             // color: AppColors.warningColor,
        //             color: Colors.transparent.withOpacity(0.3),
        //             // color: Colors.black.withOpacity(0.1),
        //             borderRadius: BorderRadius.circular(30),
        //           ),
        //           padding: EdgeInsets.all(8.w),
        //           child: Center(
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   '\$${price}',
        //                   style: TextStyle(
        //                       fontSize: 17.sp,
        //                       color: Colors.white,
        //                       fontWeight: FontWeight.w500),
        //                 ),
        //                 Text(
        //                   '/Person',
        //                   style: TextStyle(
        //                     fontSize: 15.sp,
        //                     color: Colors.white.withOpacity(0.8),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         top: 10,
        //         right: 10,
        //         child: Container(
        //           decoration: BoxDecoration(
        //             color: Colors.black.withOpacity(0.1),
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           padding: EdgeInsets.all(2.w),
        //           child: Icon(
        //             Icons.favorite,
        //             color: Colors.red,
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 45,
        //         left: 10,
        //         child: Container(
        //           width: 100.w,
        //
        //           decoration: BoxDecoration(
        //               // color: Colors.black.withOpacity(0.1),
        //               // borderRadius: BorderRadius.circular(10),
        //               ),
        //           // width: 150.w,
        //           alignment: Alignment.topLeft,
        //           child: Padding(
        //             padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        //             child: Text(
        //               title,
        //               style: TextStyle(
        //                 fontSize: 22.sp,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 17,
        //         left: 10,
        //         child: Container(
        //           decoration: BoxDecoration(
        //             // color: Colors.black.withOpacity(0.1),
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           padding: EdgeInsets.symmetric(horizontal: 8.w),
        //           child: Row(
        //             children: [
        //               FaIcon(
        //                 Icons.location_on_outlined,
        //                 color: Colors.white,
        //                 size: 20.sp,
        //               ),
        //               Text(
        //                 loc,
        //                 style: TextStyle(color: Colors.white, fontSize: 14.sp
        //                     // fontWeight: FontWeight.w600,
        //                     ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 15,
        //         right: 10,
        //         child: Container(
        //           height: 50.h,
        //           width: 50.w,
        //           decoration: BoxDecoration(
        //             color: Colors.blue,
        //             borderRadius: BorderRadius.circular(50),
        //           ),
        //           padding: EdgeInsets.all(8),
        //           child: IconButton(
        //             icon: FaIcon(
        //               FontAwesomeIcons.arrowUpRightFromSquare,
        //             ),
        //             color: Colors.white,
        //             onPressed: () {
        //               // Perform arrow button action here
        //             },
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget _buildCardView(String title, String img) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 30.h,
          width: 30.w,
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
                                      size: 30,
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
                              height: 50.h,
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
                                            transitionBuilder: (child, animation, secondaryAnimation) =>
                                                FadeThroughTransition(
                                                  fillColor: Colors.transparent,
                                                  animation: animation,
                                                  secondaryAnimation: secondaryAnimation,
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
                    Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: Color(0xff1C939B),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.airplanemode_active,
                              color: Colors.white,
                              size: 40.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Trips',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: Color(0xffDB8D1E),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.hotel,
                            color: Colors.white,
                            size: 40.sp,
                          )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Hotels',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: Color(0xffE5291D),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.event,
                              color: Colors.white,
                              size: 40.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Events',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: Color(0xff3E79EA),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.car_rental,
                              color: Colors.white,
                              size: 40.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Transport',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
            // Container(
            //   child: StreamBuilder<QuerySnapshot>(
            //     stream: controller.fireStoreTourRef,
            //     builder: (BuildContext context,
            //         AsyncSnapshot<QuerySnapshot> snapshot) {
            //       try {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           print("inside first circle");
            //           return Center(child: CircularProgressIndicator());
            //         }
            //         if (snapshot.hasError) {
            //           print("inside 2nd circle");
            //           return Center(child: CircularProgressIndicator());
            //         }
            //         print(snapshot.data!.docs.length.toString());
            //         return snapshot.data!.docs.length != 0
            //             ? ListView.builder(
            //                 itemCount: snapshot.data!.docs.length,
            //                 itemBuilder: (context, index) {
            //                   return Column(
            //                     children: [
            //
            //                       index == 0
            //                           ? SingleChildScrollView(
            //                         scrollDirection: Axis.horizontal,
            //                             child: Padding(
            //                                 padding: EdgeInsets.symmetric(
            //                                     horizontal: 8.w, vertical: 5.h),
            //                                 child: Row(
            //                                   children: [
            //                                     for (int i = 0; i < 6; i++)
            //                                       Container(
            //                                         margin: EdgeInsets.symmetric(
            //                                             horizontal: 10.w),
            //                                         padding: EdgeInsets.all(10),
            //                                         decoration: BoxDecoration(
            //                                           color: Colors.white,
            //                                           borderRadius:
            //                                               BorderRadius.circular(10),
            //                                           boxShadow: [
            //                                             BoxShadow(
            //                                               color: Colors.black26,
            //                                               blurRadius: 4,
            //                                             ),
            //                                           ],
            //                                         ),
            //                                         child: Text(
            //                                           controller.category[i],
            //                                           style: TextStyle(
            //                                               color: Colors.black,
            //                                               fontSize: 15,
            //                                               fontWeight:
            //                                                   FontWeight.w500),
            //                                         ),
            //                                       ),
            //                                   ],
            //                                 ),
            //                               ),
            //                           )
            //                           : Container(),
            //                       _buildCard(
            //                         snapshot.data!.docs[index]['title']
            //                             .toString(),
            //                         snapshot.data!.docs[index]['location']
            //                             .toString(),
            //                         snapshot.data!.docs[index]['price']
            //                             .toString(),
            //                         snapshot.data!.docs[index]['tourImage']
            //                             .toString(),
            //                       ),
            //                     ],
            //                   );
            //                 })
            //             : Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Center(
            //                     child: Text(
            //                       'No new companies to approved',
            //                       style: TextStyle(fontSize: 30),
            //                     ),
            //                   ),
            //                 ],
            //               );
            //         ;
            //       } catch (e) {
            //         return Text(
            //           'data : ' + e.toString(),
            //         );
            //       }
            //     },
            //   ),
            // ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: [],),
    );
  }
}
// _buildCard("Naran Kaghan","Peshawar","200",'assets/images/pic1.jpg')

//

// -----------------------

// ListView.builder(
//   physics: NeverScrollableScrollPhysics(),
//   shrinkWrap: true,
//   itemCount: 6,
//   itemBuilder: (BuildContext context, int index) {
//     return Padding(
//       padding: EdgeInsets.all(15),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailScreen(),
//                 ),
//               );
//             },
//             child: Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(15),
//                 image: DecorationImage(
//                     image: AssetImage(
//                         'assets/images/pic${index + 1}.jpg'),
//                     fit: BoxFit.cover,
//                     opacity: 0.7),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'City Name',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Icon(
//                   Icons.more_vert,
//                   size: 30,
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.star,
//                 color: Colors.amber,
//                 size: 20,
//               ),
//               Text(
//                 '4.5',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   },
// ),

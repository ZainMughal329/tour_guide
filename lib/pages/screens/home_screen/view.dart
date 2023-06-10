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
import '../../../ReUsable/Components/details.dart';
import '../../../ReUsable/Components/drawer.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

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
        child: Container(
          // height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                      ),
                    ],
                    border: Border.all(width: 0.9, color: Colors.black)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                    height: 300.h,
                    width: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    // color: AppColors.warningColor,
                    color: Color(0xFF4D4D8E),
                    // color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${price}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '/Person',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(2.w),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                bottom: 45,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // width: 150.w,
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      FaIcon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 17.sp,
                      ),
                      Text(
                        " " + loc,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp
                            // fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.arrowUpRightFromSquare,
                    ),
                    color: Colors.grey,
                    onPressed: () {
                      // Perform arrow button action here
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      backgroundColor: AppColors.warningColor,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50.0.h),
      //   child: Column(
      //     children: [
      //       BuildAppBar(
      //         title: 'Profile',
      //         icon1: Icons.sort_rounded,
      //         icon2: Icons.more_vert_rounded,
      //       ),
      //
      //     ],
      //   ),
      // ),
      drawer: BuildDrawer.buildDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.h),
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
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.0.w,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: userModel.photoUrl.toString() == ''
                                        ? Icon(
                                            Icons.person_outline,
                                            size: 30,
                                            color: Colors.white,
                                          )
                                        : Image(
                                            image: NetworkImage(
                                              userModel.photoUrl.toString(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome back 🖐🏻',
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      userModel.userName.toString(),
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 5.h),
                        child: Row(
                          children: [
                            for (int i = 0; i < 6; i++)
                              InkWell(

                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    controller.category[i],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                onTap: (){
                                  // Get.toNamed(AppRoutes.catScreen);
                                  Get.to(()=>catogeryScreenPage(catogery: controller.category[i],));
                                  // Get.to(()=>catogeryScreenPage());

                                },
                              ),
                          ],
                        ),
                      ),
                    );
                  },
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
                                height:
                                    MediaQuery.of(context).size.height - 160.h,
                                child: ListView.builder(
                                    // shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          _buildCard(
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

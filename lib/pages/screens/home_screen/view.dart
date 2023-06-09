import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/models/userModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import '../../../ReUsable/Components/app_bar.dart';
import '../../../ReUsable/Components/details.dart';
import '../../../ReUsable/Components/drawer.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  Widget _buildCard(String title, String loc, String price, String imageUrl) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
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
                  height: 200,
                  width: double.infinity,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  "\$ " + price + "/person",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      loc,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.unActiveIconColor.withOpacity(0.2),
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Column(
              children: [
                Container(
                  child: FutureBuilder(
                    future: controller.getUsersData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print('waiting for connection state');
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        print('Inside snapshot error');
                        return CircularProgressIndicator();
                      }
                      UserModel userModel = snapshot.data as UserModel;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Column(
                            children: [
                              Text(
                                'Welcome back 🖐🏻',
                                style: TextStyle(
                                    fontSize: 15.sp, color: Colors.grey),
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
                Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: controller.fireStoreTourRef,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        print(snapshot.data!.docs.length.toString());
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return snapshot.data!.docs.length != 0
                                  ? Column(
                                      children: [
                                        index == 0
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w,
                                                    vertical: 5.h),
                                                child: Row(
                                                  children: [
                                                    for (int i = 0; i < 6; i++)
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w),
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black26,
                                                              blurRadius: 4,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Text(
                                                          controller
                                                              .category[i],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        _buildCard(
                                          snapshot.data!.docs[index]['title']
                                              .toString(),
                                          snapshot.data!.docs[index]['location']
                                              .toString(),
                                          snapshot.data!.docs[index]['price']
                                              .toString(),
                                          snapshot
                                              .data!.docs[index]['tourImage']
                                              .toString(),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            'No new companies to approved',
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ),
                                      ],
                                    );
                            });
                      } catch (e) {
                        return Text(
                          'data : ' + e.toString(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
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

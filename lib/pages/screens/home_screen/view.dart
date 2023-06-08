import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import '../../../ReUsable/Components/app_bar.dart';
import '../../../ReUsable/Components/details.dart';
import '../../../ReUsable/Components/drawer.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
   HomePage({Key? key}) : super(key: key);

  // Widget _buildAppBar(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.all(20),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         InkWell(
  //           onTap: () async {
  //             await FirebaseAuth.instance.signOut();
  //             Get.offAllNamed(AppRoutes.SIGN_IN);
  //             // Scaffold.of(context).openDrawer();
  //           },
  //           child: Container(
  //             padding: EdgeInsets.all(10.w),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(color: Colors.black26, blurRadius: 6),
  //               ],
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Icon(
  //               Icons.sort_rounded,
  //               size: 28,
  //             ),
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             Icon(
  //               Icons.location_on_outlined,
  //               color: Color(0xfff65959),
  //             ),
  //             Text(
  //               "Sawat",
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ],
  //         ),
  //         InkWell(
  //           onTap: () {},
  //           child: Container(
  //             padding: EdgeInsets.all(10.w),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(color: Colors.black26, blurRadius: 6),
  //               ],
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Icon(
  //               Icons.person_outline,
  //               size: 28,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


  Widget _buildTourCard(String imageUrl,String price,String name){
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Stack(
            children: [
              // Text("this is upper text",style: TextStyle(color: Colors.white),),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                      opacity: 0.7),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 15.h, horizontal: 15.w),
                child: Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40.h,
                            // width: 20.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10.h),
                                color: Colors.grey.withOpacity(0.4)),
                            child: Container(
                              margin:
                              EdgeInsets.symmetric(horizontal: 5),
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      "\$" + price,
                                      style: TextStyle(
                                          fontSize: 25.h,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "/Person",
                                      style: TextStyle(
                                          fontSize: 20.h,
                                          color: Colors.white
                                              .withOpacity(0.8)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 35.sp,
                                  color: Colors.white.withOpacity(0.8)),
                            ),
                            // width: 150.w,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
              // Container(
              //     height: 200,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: Colors.red,
              //       borderRadius: BorderRadius.circular(100),
              //     ),
              //     child: Image(image: AssetImage('assets/images/pic1.jpg'),fit: BoxFit.fill,)),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: Column(
          children: [
            BuildAppBar(
              title: 'Profile',
              icon1: Icons.sort_rounded,
              icon2: Icons.more_vert_rounded,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(

                padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
                child: Row(
                  children: [
                    for (int i = 0; i < 6; i++)
                      Container(
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: BuildDrawer.buildDrawer(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 10.w),
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.fireStoreTourRef,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                try {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print("inside first circle");
                    return Center(child: CircularProgressIndicator());

                  }
                  if (snapshot.hasError) {
                    print("inside 2nd circle");
                    return Center(child: CircularProgressIndicator());
                  }
                  print(snapshot.data!.docs.length.toString());
                  return snapshot.data!.docs.length != 0

                      ? ListView.builder(


                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return _buildTourCard(
                                snapshot.data!.docs[index]['tourImage'].toString(),
                                snapshot.data!.docs[index]['price'].toString(),
                                snapshot.data!.docs[index]['title'].toString(),
                            )
                            //   Container(
                            //   height: 200,
                            //   width: double.infinity,
                            //   child: ListTile(
                            //     leading: Icon(Icons.person_outline),
                            //     title: Text(
                            //       snapshot.data!.docs[index]['title']
                            //           .toString(),
                            //     ),
                            //
                            //   ),
                            // )
                            ;
                          })
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
                } catch (e) {
                  return Text(
                    'data : ' + e.toString(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}



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

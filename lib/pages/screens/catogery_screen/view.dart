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

import '../../../ReUsable/Components/app_bar.dart';
import '../home_screen/details.dart';
import '../../../ReUsable/Components/drawer.dart';
import 'controller.dart';

class catogeryScreenPage extends GetView<catogeryScreenController> {
  String catogery = '';

  catogeryScreenPage({Key? key, required this.catogery}) : super(key: key);
  catogeryScreenController controller = Get.put(catogeryScreenController());

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
          padding: const EdgeInsets.only(right: 18.0),
          child: Container(
            height: 297.h,
            width: 241.w,
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
                      'Starting at Rs:' + price.toString(),
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

  @override
  Widget build(BuildContext context) {
    catogery == "2 persons"
        ? controller.setRatingTourRef(catogery)
        : controller.setTourRef(catogery);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.lightActiveIconColor,
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.lightBgColor,
          title: Text(
            catogery,
            style: TextStyle(fontSize: 20.sp, color: AppColors.lightTextColor),
          ),
          centerTitle: true,
        ),
        backgroundColor: AppColors.lightBgColor,
        drawer: BuildDrawer.buildDrawer(context),
        body: SafeArea(
            child: Padding(
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h, bottom: 10.h),
          child: StreamBuilder<QuerySnapshot>(
            stream: controller.state.fireStoreTourRef,
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
                var len = snapshot.data!.docs.length;

                print('Length is' + len.toString());
                List<Widget> cardRows = [];
                for (int i = 0; i < snapshot.data!.docs.length; i += 2) {
                  if (i + 1 < snapshot.data!.docs.length) {
                    cardRows.add(Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 270.h,
                              width: 250.w,
                              child: _buildCard(
                                context,
                                snapshot.data!.docs[i]['title'],
                                snapshot.data!.docs[i]['location'],
                                snapshot.data!.docs[i]['price'],
                                snapshot.data!.docs[i]['tourDescription'],
                                snapshot.data!.docs[i]['tourImage'],
                                snapshot.data!.docs[i]['id'],
                                snapshot.data!.docs[i]['companyPhone'],
                                snapshot.data!.docs[i]['companyName'],
                                snapshot.data!.docs[i]['companyId'],

                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 270.h,
                              width: 250.w,
                              child: _buildCard(
                                context,
                                snapshot.data!.docs[i + 1]['title'],
                                snapshot.data!.docs[i + 1]['location'],
                                snapshot.data!.docs[i + 1]['price'],
                                snapshot.data!.docs[i + 1]['tourDescription'],
                                snapshot.data!.docs[i + 1]['tourImage'],
                                snapshot.data!.docs[i + 1]['id'],
                                snapshot.data!.docs[i + 1]['companyPhone'],
                                snapshot.data!.docs[i + 1]['companyName'],
                                snapshot.data!.docs[i + 1]['companyId'],

                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
                  } else {
                    cardRows.add(Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 270.h,
                              width: 250.w,
                              child: _buildCard(
                                context,
                                snapshot.data!.docs[i]['title'],
                                snapshot.data!.docs[i]['location'],
                                snapshot.data!.docs[i]['price'],
                                snapshot.data!.docs[i]['tourDescription'],
                                snapshot.data!.docs[i]['tourImage'],
                                snapshot.data!.docs[i]['id'],
                                snapshot.data!.docs[i]['companyPhone'],
                                snapshot.data!.docs[i]['companyName'],
                                snapshot.data!.docs[i]['companyId'],

                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ));
                  }
                }
                return snapshot.data!.docs.length != 0
                    ? ListView(
                        children: cardRows,
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Currently,We have no tours in\nthis Category',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.lightTextColor,
                                    letterSpacing: 2),
                              ),
                            ),
                          ],
                        ),
                      );
                ;
              } catch (e) {
                return Text(
                  'data : ' + e.toString(),
                );
              }
            },
          ),
        )));
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

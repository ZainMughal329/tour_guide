 import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/round_button.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/companyScreen/add_tour/controller.dart';
import 'package:tours_guide/pages/companyScreen/show_tour/tourDetails.dart';
import 'package:tours_guide/pages/companyScreen/show_tour/update_tour.dart';

import '../../../ReUsable/Components/details.dart';
import 'controller.dart';

class CompanyShowTourScreen extends GetView<CompanyShowTourController> {
  CompanyShowTourScreen({Key? key}) : super(key: key);

  Widget _buildCard(BuildContext context, String title, String loc,
      String price, String des, String imageUrl) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        height: 330.h,
        width: 220.w,
        child: Container(
          height: 297,
          width: 201,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.iconsColor),
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
      // child: Container(
      //   height: 300,
      //   width: 200,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(40),
      //     color: Colors.white,
      //   ),
      //   child: Stack(
      //     children: [
      //       Container(
      //         width: 300,
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
      //             color: Color(0xFF4D4D8E),
      //             // color: Colors.black.withOpacity(0.1),
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           padding: EdgeInsets.all(8),
      //           child: Center(
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 Text(
      //                   '\$${price}',
      //                   style: TextStyle(
      //                       fontSize: 20,
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.w500),
      //                 ),
      //                 Text(
      //                   '/Person',
      //                   style: TextStyle(
      //                     fontSize: 18,
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
      //           decoration: BoxDecoration(
      //             color: Colors.black.withOpacity(0.1),
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           // width: 150.w,
      //           alignment: Alignment.topLeft,
      //           child: Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      //             child: Text(
      //               title,
      //               style: TextStyle(
      //                 fontSize: 22,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       Positioned(
      //         bottom: 10,
      //         left: 10,
      //         child: Container(
      //           decoration: BoxDecoration(
      //             color: Colors.black.withOpacity(0.1),
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           padding: EdgeInsets.symmetric(horizontal: 8.w),
      //           child: Row(
      //             children: [
      //               FaIcon(
      //                 Icons.location_on_outlined,
      //                 color: Colors.white,
      //                 size: 17.sp,
      //               ),
      //               Text(
      //                 " " + loc,
      //                 style: TextStyle(color: Colors.white, fontSize: 16.sp
      //                     // fontWeight: FontWeight.w600,
      //                     ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Positioned(
      //         bottom: 10,
      //         right: 10,
      //         child: Container(
      //           decoration: BoxDecoration(
      //             // color: Colors.black.withOpacity(0.1),
      //             borderRadius: BorderRadius.circular(10),
      //           ),
      //           padding: EdgeInsets.all(8),
      //           child: IconButton(
      //             icon: FaIcon(
      //               FontAwesomeIcons.arrowUpRightFromSquare,
      //             ),
      //             color: Colors.grey,
      //             onPressed: () {
      //               // Perform arrow button action here
      //             },
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      resizeToAvoidBottomInset: true,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('company')
            .doc(controller.auth.currentUser!.uid.toString())
            .collection('tour')
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Waiting...');
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print('Error occurs');
            return Center(
              child: Text('Something went wrong'),
            );
          }

          var len = snapshot.data!.docs.length;

          print('Length is' + len.toString());
          List<Widget> cardRows = [];
          for (int i = 0; i < snapshot.data!.docs.length; i += 2) {
            if (i + 1 < snapshot.data!.docs.length) {
              cardRows.add(Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // Get.to(
                          //       () => TourDetailScreen(
                          //     img: snapshot.data!.docs[i]
                          //     ['tourImage'],
                          //     loc: snapshot.data!.docs[i]['location'],
                          //     price: snapshot.data!.docs[i]['price'],
                          //     people: snapshot.data!.docs[i]
                          //     ['people'],
                          //     category: snapshot.data!.docs[i]
                          //     ['tourCategory'],
                          //     des: snapshot.data!.docs[i]
                          //     ['tourDescription'],
                          //   ),
                          // );
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  height: 110.h,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          // pickedImageFromGallery(context);
                                          controller.deleteTour(
                                            snapshot.data!
                                                .docs[i].id
                                                .toString(),
                                          );
                                          Navigator.pop(context);
                                        },
                                        leading: Icon(Icons.delete),
                                        title: Text('Delete'),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          // pickedImageFromCamera(context);
                                          Navigator.pop(context);
                                          Get.to( () =>
                                              UpdateTourData(
                                                id: snapshot.data!
                                                    .docs[i].id
                                                    .toString(),
                                              ),
                                          );
                                          print('heloo');
                                        },
                                        leading: Icon(Icons.edit),
                                        title: Text('Edit'),
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 330.h,
                          child: _buildCard(
                              context,
                              snapshot.data!.docs[i]['title'],
                              snapshot.data!.docs[i]['location'],
                              snapshot.data!.docs[i]['price'],
                              snapshot.data!.docs[i]['tourDescription'],
                              snapshot.data!.docs[i]['tourImage']),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // Get.to(
                          //       () => TourDetailScreen(
                          //     img: snapshot.data!.docs[i + 1]
                          //     ['tourImage'],
                          //     loc: snapshot.data!.docs[i + 1]['location'],
                          //     price: snapshot.data!.docs[i + 1]['price'],
                          //     people: snapshot.data!.docs[i + 1]
                          //     ['people'],
                          //     category: snapshot.data!.docs[i + 1]
                          //     ['tourCategory'],
                          //     des: snapshot.data!.docs[i + 1]
                          //     ['tourDescription'],
                          //   ),
                          // );
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  height: 110.h,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          // pickedImageFromGallery(context);
                                          controller.deleteTour(
                                            snapshot.data!
                                                .docs[i + 1].id
                                                .toString(),
                                          );
                                          Navigator.pop(context);
                                        },
                                        leading: Icon(Icons.delete),
                                        title: Text('Delete'),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          // pickedImageFromCamera(context);
                                          Navigator.pop(context);
                                          Get.to( () =>
                                              UpdateTourData(
                                                id: snapshot.data!
                                                    .docs[i + 1].id
                                                    .toString(),
                                              ),
                                          );
                                          print('heloo');
                                        },
                                        leading: Icon(Icons.edit),
                                        title: Text('Edit'),
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 330.h,
                          child: _buildCard(
                              context,
                              snapshot.data!.docs[i+1]['title'],
                              snapshot.data!.docs[i+1]['location'],
                              snapshot.data!.docs[i+1]['price'],
                              snapshot.data!.docs[i+1]['tourDescription'],
                              snapshot.data!.docs[i+1]['tourImage']),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // Get.to(
                          //       () => TourDetailScreen(
                          //     img: snapshot.data!.docs[i]
                          //     ['tourImage'],
                          //     loc: snapshot.data!.docs[i]['location'],
                          //     price: snapshot.data!.docs[i]['price'],
                          //     people: snapshot.data!.docs[i]
                          //     ['people'],
                          //     category: snapshot.data!.docs[i]
                          //     ['tourCategory'],
                          //     des: snapshot.data!.docs[i]
                          //     ['tourDescription'],
                          //   ),
                          // );
                          showDialog(
                              context: context,
                              builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: 110.h,
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        // pickedImageFromGallery(context);
                                        controller.deleteTour(
                                          snapshot.data!
                                              .docs[i].id
                                              .toString(),
                                        );
                                        Navigator.pop(context);
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete'),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        // pickedImageFromCamera(context);
                                        Navigator.pop(context);
                                        Get.to( () =>
                                            UpdateTourData(
                                              id: snapshot.data!
                                                  .docs[i].id
                                                  .toString(),
                                            ),
                                        );
                                        print('heloo');
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                          );
                        },
                        child: Container(
                          height: 330.h,
                          child: _buildCard(
                              context,
                              snapshot.data!.docs[i]['title'],
                              snapshot.data!.docs[i]['location'],
                              snapshot.data!.docs[i]['price'],
                              snapshot.data!.docs[i]['tourDescription'],
                              snapshot.data!.docs[i]['tourImage']),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container(),),
                ],
              ));
            }

          }
          return snapshot.data!.docs.length != 0
              ? ListView(
            children: cardRows,
          )
          // ListView.builder(
          //         physics: NeverScrollableScrollPhysics(),
          //         shrinkWrap: true,
          //         itemCount: snapshot.data!.docs.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return Padding(
          //             padding: EdgeInsets.all(15),
          //             child: Column(
          //               children: [
          //                 InkWell(
          //                   onTap: () {
          //                     Get.to(
          //                       () => TourDetailScreen(
          //                         img: snapshot.data!.docs[index]
          //                             ['tourImage'],
          //                         loc: snapshot.data!.docs[index]['location'],
          //                         price: snapshot.data!.docs[index]['price'],
          //                         people: snapshot.data!.docs[index]
          //                             ['people'],
          //                         category: snapshot.data!.docs[index]
          //                             ['tourCategory'],
          //                         des: snapshot.data!.docs[index]
          //                             ['tourDescription'],
          //                       ),
          //                     );
          //                   },
          //                   child: Container(
          //                     height: 200,
          //                     decoration: BoxDecoration(
          //                       color: Colors.black,
          //                       borderRadius: BorderRadius.circular(15),
          //                       image: DecorationImage(
          //                           image: NetworkImage(
          //                             snapshot.data!.docs[index]['tourImage']
          //                                 .toString(),
          //                           ),
          //                           fit: BoxFit.cover,
          //                           opacity: 0.7),
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: EdgeInsets.only(top: 10),
          //                   child: Row(
          //                     mainAxisAlignment:
          //                         MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Column(
          //                         mainAxisAlignment: MainAxisAlignment.start,
          //                         crossAxisAlignment:
          //                             CrossAxisAlignment.start,
          //                         children: [
          //                           Text(
          //                             snapshot.data!.docs[index]['location']
          //                                 .toString(),
          //                             style: TextStyle(
          //                               fontSize: 20,
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                           SizedBox(
          //                             height: 5,
          //                           ),
          //                           Text(
          //                             snapshot.data!.docs[index]['price']
          //                                 .toString(),
          //                             style: TextStyle(
          //                               fontSize: 12,
          //                               fontWeight: FontWeight.normal,
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                       InkWell(
          //                         onTap: () {
          //                           showDialog(
          //                             context: context,
          //                             builder: (context) {
          //                               return AlertDialog(
          //                                 content: Container(
          //                                   height: 110.h,
          //                                   child: Column(
          //                                     children: [
          //                                       ListTile(
          //                                         onTap: () {
          //                                           // pickedImageFromGallery(context);
          //                                           controller.deleteTour(
          //                                             snapshot.data!
          //                                                 .docs[index].id
          //                                                 .toString(),
          //                                           );
          //                                           Navigator.pop(context);
          //                                         },
          //                                         leading: Icon(Icons.delete),
          //                                         title: Text('Delete'),
          //                                       ),
          //                                       ListTile(
          //                                         onTap: () {
          //                                           // pickedImageFromCamera(context);
          //                                           Navigator.pop(context);
          //                                           Get.to( () =>
          //                                              UpdateTourData(
          //                                               id: snapshot.data!
          //                                                   .docs[index].id
          //                                                   .toString(),
          //                                             ),
          //                                           );
          //                                           print('heloo');
          //                                         },
          //                                         leading: Icon(Icons.edit),
          //                                         title: Text('Edit'),
          //                                       ),
          //
          //                                     ],
          //                                   ),
          //                                 ),
          //                               );
          //                             },
          //                           );
          //                         },
          //                         child: Icon(
          //                           Icons.more_vert,
          //                           size: 30,
          //                         ),
          //                       )
          //                     ],
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 5,
          //                 ),
          //               ],
          //             ),
          //           );
          //         },
          //       )
              : Container(
                  margin: EdgeInsets.only(top: 50.h),
                  child: Center(
                    child: Text(
                      'No tours added.',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                );
        },
      ),
    );
  }
}

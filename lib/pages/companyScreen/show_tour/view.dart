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

import '../../screens/home_screen/details.dart';
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
          height: 297.h,
          width: 201.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.iconsColor),
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.cover),
            color: Colors.transparent,
          ),
          child: Container(
            height: 297.h,
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

              : Container(
                  margin: EdgeInsets.only(top: 50.h),
                  child: Center(
                    child: Text(
                      'No tours added.',
                      style: TextStyle(fontSize: 20.sp , color: Colors.white),
                    ),
                  ),
                );
        },
      ),
    );
  }
}

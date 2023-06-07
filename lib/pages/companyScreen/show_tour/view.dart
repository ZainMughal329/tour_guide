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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.firestore,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Waiting...');
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              print('Error occurs');
              return Center(
                child: Text('Something went wrong'),
              );
            }
            return snapshot.data!.docs.length != 0
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => TourDetailScreen(
                                    img: snapshot.data!.docs[index]
                                        ['tourImage'],
                                    loc: snapshot.data!.docs[index]['location'],
                                    price: snapshot.data!.docs[index]['price'],
                                    people: snapshot.data!.docs[index]
                                        ['people'],
                                    category: snapshot.data!.docs[index]
                                        ['tourCategory'],
                                    des: snapshot.data!.docs[index]
                                        ['tourDescription'],
                                  ),
                                );
                              },
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        snapshot.data!.docs[index]['tourImage']
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover,
                                      opacity: 0.7),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['location']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]['price']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
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
                                                            .docs[index].id
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
                                                              .docs[index].id
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
                                    child: Icon(
                                      Icons.more_vert,
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  )
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
      ),
    );
  }
}

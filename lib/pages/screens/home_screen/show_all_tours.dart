import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/pages/screens/home_screen/controller.dart';

import '../../../ReUsable/Components/drawer.dart';
import '../../../ReUsable/Components/toast_info.dart';
import '../../../ReUsable/models/tourModel.dart';
import 'details.dart';

class ShowAllToursToUser extends GetView<HomeController> {
  ShowAllToursToUser({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
      child: GestureDetector(
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
        child: Container(
          height: 300.h,
          width: 180.w,
          child: Container(
            height: 300.h,
            width: 180.w,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: BuildDrawer.buildDrawer(context),
      backgroundColor: AppColors.lightBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: AppColors.lightTextColor,
                                        size: 35.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70.w,
                                  ),
                                  Center(
                                    child: Text(
                                      'All tours',
                                      style: TextStyle(
                                          fontSize: 23.sp,
                                          color: AppColors.lightTextColor,
                                          fontWeight: FontWeight.w600),
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
                        } else if (snapshot.hasError) {
                          toastInfo(msg: "Something went wrong");
                          print('Inside snapshot error');
                          return SizedBox();
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(bottom: 90.h),
                  child: FutureBuilder<List<TourModel>>(
                    future: controller.getAndShowALlToursData(),
                    builder: (BuildContext context, snapshot) {
                      try {
                        print('Inside try');
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          print('Connection is not ok');
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          print('Inside snapshot');
                          return Center(child: CircularProgressIndicator());
                        }
                        var len = snapshot.data!.length;

                        print('Length is' + len.toString());
                        List<Widget> cardRows = [];
                        for (int i = 0; i < snapshot.data!.length; i += 2) {
                          if (i + 1 < snapshot.data!.length) {
                            cardRows.add(Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:  EdgeInsets.only(right: 10.w),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Are you sure to delete?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // Close the dialog
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      // Action when "No" is clicked
                                                      Navigator.pop(
                                                          context); // Close the dialog
                                                      // TODO: Perform some other action
                                                    },
                                                    child: Text(
                                                      'No',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                        height: 280.h,
                                        width: 180.w,
                                        child: _buildCard(
                                          context,
                                          snapshot.data![i].title,
                                          snapshot.data![i].location,
                                          snapshot.data![i].price,
                                          snapshot.data![i].tourDescription,
                                          snapshot.data![i].tourImage,
                                          snapshot.data![i].id.toString(),
                                          snapshot.data![i].companyPhone
                                              .toString(),
                                          snapshot.data![i].companyName
                                              .toString(),
                                          snapshot.data![i].companyId
                                              .toString(),

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Are you sure to delete?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Close the dialog
                                                    // controller
                                                    //     .showFeedbackDialog(context);
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // Action when "No" is clicked
                                                    Navigator.pop(
                                                        context); // Close the dialog
                                                    // TODO: Perform some other action
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                      height: 280.h,
                                      width: 180.w,
                                      child: _buildCard(
                                        context,
                                        snapshot.data![i + 1].title,
                                        snapshot.data![i + 1].location,
                                        snapshot.data![i + 1].price,
                                        snapshot.data![i + 1].tourDescription,
                                        snapshot.data![i + 1].tourImage,
                                        snapshot.data![i].id.toString(),
                                        snapshot.data![i].companyPhone
                                            .toString(),
                                        snapshot.data![i].companyName
                                            .toString(),
                                        snapshot.data![i].companyId.toString(),

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
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Are you sure to delete?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context); // Close the dialog
                                                    // controller
                                                    //     .showFeedbackDialog(context);
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // Action when "No" is clicked
                                                    Navigator.pop(
                                                        context); // Close the dialog
                                                    // TODO: Perform some other action
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Container(
                                      height: 280.h,
                                      width: 180.w,
                                      child: _buildCard(
                                        context,
                                        snapshot.data![i].title,
                                        snapshot.data![i].location,
                                        snapshot.data![i].price,
                                        snapshot.data![i].tourDescription,
                                        snapshot.data![i].tourImage,
                                        snapshot.data![i].id.toString(),
                                        snapshot.data![i].companyPhone
                                            .toString(),
                                        snapshot.data![i].companyName
                                            .toString(),
                                        snapshot.data![i].companyId.toString(),

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
                        return snapshot.data!.length != 0
                            ? ListView(
                                children: cardRows,
                              )
                            : Center(
                                child: Text('No tours added now.'),
                              );
                      } catch (e) {
                        print('Exception is : ' + e.toString());
                        return Text('data : ' + e.toString());
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

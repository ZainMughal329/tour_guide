import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_bar.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/models/bookingMode.dart';
import 'package:tours_guide/pages/screens/home_screen/details.dart';
import 'package:tours_guide/pages/screens/user_bookings/controller.dart';

import '../../../ReUsable/Components/toast_info.dart';
import '../../../ReUsable/models/userModel.dart';

class UserBookingView extends GetView<UserBookingController> {
  const UserBookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getUid();
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("My Bookings"),
      // ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, right: 20.w, left: 20.w),
            child: Container(
              child: FutureBuilder(
                future: controller.getUsersData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // print('waiting for connection state');
                    // toastInfo(
                    //     msg: "waiting for connection ...",
                    //     length: Toast.LENGTH_SHORT);
                    return Center(
                      child: SizedBox(),
                    );
                  }
                  if (snapshot.hasError) {
                    // toastInfo(msg: "Something went wrong");
                    // print('Inside snapshot error');
                    return SizedBox();
                  }
                  UserModel userModel = snapshot.data as UserModel;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: InkWell(
                              onTap: () {
                                // _scaffoldKey.currentState!.openDrawer();
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: AppColors.lightTextColor,
                                size: 24.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'All Bookings',
                                  style: TextStyle(
                                      fontSize: 22.sp,
                                      color: AppColors.lightTextColor,
                                      fontWeight: FontWeight.w500),
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
                                ? AppColors.lightTextColor
                                : Colors.white,
                            width: 1.0.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: userModel.photoUrl.toString() == ''
                              ? Icon(
                                  Icons.person_outline,
                                  size: 30.sp,
                                  color: AppColors.lightTextColor,
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
            height: 40.h,
          ),
          Container(
            // child: FutureBuilder<List<BookingModel>>(
            //   future: controller.getAndShowALlToursData(),
            //   builder: (BuildContext context, snapshot){
            //     try{
            //       print('Inside try');
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         print('Connection is not ok');
            //         return Center(child: CircularProgressIndicator());
            //       }
            //       if (snapshot.hasError) {
            //         print('Inside snapshot');
            //         return Center(child: CircularProgressIndicator());
            //       }
            //       var len = snapshot.data!.length;
            //       print(len.toString());
            //
            //     }
            //     catch(e){
            //
            //     }
            //     return Container();
            //   },
            // ),
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.allBookings,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.docs.length != 0
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var item = snapshot.data!.docs[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 2),
                                  child: Column(
                                    children: [
                                      GestureDetector(
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
                                                        controller.deleteBookedTour(item['tourId'].toString());
                                                        controller.deleteFromAllUserBookings(item['tourId'].toString());
                                                        Navigator.pop(
                                                            context);
                                                         // Close the dialog
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
                                        onDoubleTap: (){
                                          // Get.toNamed(AppRoutes)


                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 50.h,
                                                      width: 50.w,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: AppColors
                                                              .lightActiveIconColor
                                                              .withOpacity(0.1),
                                                        ),
                                                      ),
                                                      child: item['tourImage']
                                                                  .toString() ==
                                                              ''
                                                          ? Icon(
                                                              Icons.person,
                                                              color: AppColors
                                                                  .lightTextColor,
                                                            )
                                                          : Image.network(
                                                              item['tourImage']
                                                                  .toString(),
                                                              fit: BoxFit.fill,
                                                            ),
                                                    ),
                                                    SizedBox(
                                                      width: 15.w,
                                                    ),
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.title,
                                                                color:
                                                                    Colors.blue,
                                                                size: 20.sp,
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              Text(
                                                                ((item['tourTitle']
                                                                        .toString())
                                                                    .capitalizeFirst
                                                                    .toString())
                                                                    .split('')
                                                                    .take(5)
                                                                    .join('').length >=5 ? ((item['tourTitle']
                                                                    .toString())
                                                                    .capitalizeFirst
                                                                    .toString())
                                                                    .split('')
                                                                    .take(5)
                                                                    .join('') + '...' : ((item['tourTitle']
                                                                    .toString())
                                                                    .capitalizeFirst
                                                                    .toString()),
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .lightTextColor,
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .tour_outlined,
                                                                color:
                                                                    Colors.blue,
                                                                size: 20.sp,
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              Text(
                                                                ((item['CompanyName']
                                                                        .toString())
                                                                    .capitalize
                                                                    .toString()).split('')
                                                                    .take(5)
                                                                    .join('').length >=5 ? ((item['CompanyName']
                                                                    .toString())
                                                                    .capitalizeFirst
                                                                    .toString())
                                                                    .split('')
                                                                    .take(5)
                                                                    .join('') + '...' : ((item['CompanyName']
                                                                    .toString())
                                                                    .capitalizeFirst
                                                                    .toString()),
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .lightTextColor,
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .calendar_month_outlined,
                                                                color:
                                                                Colors.blue,
                                                                size: 20.sp,
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              Text(
                                                                ((item['month']
                                                                    .toString())
                                                                    .capitalize
                                                                    .toString()),
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .lightTextColor,
                                                                    fontSize:
                                                                    15.sp,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.person,
                                                          color: Colors.blue,
                                                          size: 20.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Text(
                                                          (item['name']
                                                              .toString()).split('')
                                                              .take(5)
                                                              .join('').length >=5 ? ((item['name']
                                                              .toString())
                                                              .capitalizeFirst
                                                              .toString())
                                                              .split('')
                                                              .take(5)
                                                              .join('') + '...' : ((item['name']
                                                              .toString())
                                                              .capitalizeFirst
                                                              .toString()),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          // +
                                                          // " person\'s",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .lightTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .supervised_user_circle_sharp,
                                                          color: Colors.blue,
                                                          size: 20.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Text(
                                                          (item['persons']).split('')
                                                              .take(5)
                                                              .join('').length >=5 ? ((item['persons']
                                                              .toString())
                                                              .capitalizeFirst
                                                              .toString())
                                                              .split('')
                                                              .take(5)
                                                              .join('') + '...' : ((item['persons']
                                                              .toString())
                                                              .capitalizeFirst
                                                              .toString()),
                                                          overflow: TextOverflow
                                                              .ellipsis,

                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .lightTextColor,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .attach_money_outlined,
                                                          color: Colors.blue,
                                                          size: 20.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Text(
                                                          // item['pricePerPerson'].toString(),

                                                            ((int.parse(item['pricePerPerson'].toString()
                                                                )*(int.parse(item['persons'].toString()
                                                            ))).toString()),

                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .lightTextColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: AppColors.lightTextColor,
                                              thickness: 1,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      : Center(child: Text('No bookings yet'));
                } else if (snapshot.hasError) {
                  // return Text('Something went wrong');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/admin/controller.dart';

import '../../ReUsable/Components/details.dart';

class ShowAllTours extends GetView<AdminController> {
  const ShowAllTours({Key? key}) : super(key: key);

  Widget _buildCard(BuildContext context, String title, String loc,
      String price, String des, String imageUrl) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
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
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<TourModel>>(
        future: controller.getAndShowALlToursData(),
        builder: (BuildContext context, snapshot) {
          try {
            print('Inside try');
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('Connection is not ok');
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              print('Inside snapshot');
              return Center(child: CircularProgressIndicator());
            }
            var len = snapshot.data!.length;

            print('Length is' + len.toString());
            return snapshot.data!.length != 0
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Are you sure to delete?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Close the dialog
                                            controller
                                                .showFeedbackDialog(context);
                                          },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(color: Colors.red),
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
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: _buildCard(
                                context,
                                snapshot.data![index].title,
                                snapshot.data![index].location,
                                snapshot.data![index].price,
                                snapshot.data![index].tourDescription,
                                snapshot.data![index].tourImage),
                          ));
                    })
                : Center(
                    child: Text('No tours added now.'),
                  );

            // } else {
            //   print('Connection state');
            //   return Center(child: CircularProgressIndicator());
            // }
          } catch (e) {
            print('Exception is : ' + e.toString());
            return Text('data : ' + e.toString());
          }
        },
      ),
    );
  }
}

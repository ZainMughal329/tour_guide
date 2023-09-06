import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/admin/controller.dart';

import '../screens/home_screen/details.dart';

class ShowAllTours extends GetView<AdminController> {
  const ShowAllTours({Key? key}) : super(key: key);

  Widget _buildCard(BuildContext context, String title, String loc,
      String price, String des, String imageUrl) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        height: 300.h,
        width: 180.w,
        child: Container(
          height: 297,
          width: 201,
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
            List<Widget> cardRows = [];
            for (int i = 0; i < snapshot.data!.length; i += 2) {
              if (i + 1 < snapshot.data!.length) {
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
                                          style: TextStyle(color: Colors.black),
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
                                snapshot.data![i].tourImage),
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
                                          style: TextStyle(color: Colors.black),
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
                                snapshot.data![i + 1].tourImage),
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
                                          style: TextStyle(color: Colors.black),
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
                                snapshot.data![i].tourImage),
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
    );
  }
}

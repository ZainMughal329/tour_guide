import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/admin/controller.dart';

class ShowAllTours extends GetView<AdminController> {
  const ShowAllTours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<TourModel>>(
        future: controller.getAndShowALlToursData(),
        builder:
            (BuildContext context,snapshot) {
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
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: Text('Are you sure to delete?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                  controller.showFeedbackDialog(context);

                                },
                                child: Text('Yes',style: TextStyle(
                                  color: Colors.red
                                ),),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Action when "No" is clicked
                                  Navigator.pop(context); // Close the dialog
                                  // TODO: Perform some other action
                                },
                                child: Text('No',style: TextStyle(
                                    color: Colors.black
                                ),),
                              ),
                            ],
                          );
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          image: DecorationImage(
                              image: NetworkImage(
                                snapshot.data![index].tourImage
                                    .toString(),
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, right: 10, left: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50.h,
                                        width: 120.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          // color: Color(0xffced7d7)
                                          color: Colors.transparent
                                              .withOpacity(0.2),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '\$${snapshot.data![index].price}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                              Text(
                                                '/Person',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(50),
                                          // color: Color(0xffced7d7)
                                          color: Colors.transparent
                                              .withOpacity(0.2),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite_outline,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          snapshot.data!
                                              [index].title
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.location_pin , color: Colors.grey,size: 18.sp,),
                                              Text(
                                                snapshot
                                                    .data!
                                                    [index].location

                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13.sp
                                                  // fontWeight: FontWeight.w600,

                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            height: 50.h,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(50),
                                              // color: Color(0xffced7d7)
                                              color:
                                              Colors.lightGreenAccent,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        // child: Column(
                        //   children: [
                        //     ListTile(
                        //       leading: Icon(Icons.person_outline),
                        //       title: Text(snapshot
                        //           .data!.docs[index]['tourCityName']
                        //           .toString()),
                        //       subtitle: Text(snapshot
                        //           .data!.docs[index]['tourCategory']
                        //           .toString()),
                        //       trailing: Text(snapshot
                        //           .data!.docs[index]['tourRating']
                        //           .toString()),
                        //     ),
                        //     SizedBox(
                        //       height: 20,
                        //     ),
                        //   ],
                        // ),
                      ),
                    ),
                  );
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

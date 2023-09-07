import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/pages/companyScreen/bookings/controller.dart';

class CompanyBookingsView extends GetView<CompanyBookingController> {
String uid;
    CompanyBookingsView({required this.uid,Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

print("uid in widget is" +uid.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: controller.getNodeData(uid),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              try{
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }
                if(snapshot.hasError){
                  return CircularProgressIndicator();
                }
                print(snapshot.data!.docs.length.toString());

                return snapshot.data!.docs.length !=0 ?
                    ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          return  Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 2),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {

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
                                                child: snapshot.data!.docs[index]['tourImage'].toString() ==
                                                    ''
                                                    ? Icon(
                                                  Icons.person,
                                                  color: AppColors
                                                      .lightTextColor,
                                                )
                                                    : Image.network(
                                                  snapshot.data!.docs[index]['tourImage'].toString(),
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
                                                          (
                                                          snapshot.data!.docs[index]['tourTitle'].toString()),
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
                                                              .phone_android,
                                                          color:
                                                          Colors.blue,
                                                          size: 20.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Text(
                                                          (snapshot.data!.docs[index]['phoneNumber'].toString()),
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
                                                          (
                                                              snapshot.data!.docs[index]['month'].toString()
                                                          )
                                                              .capitalize
                                                              .toString(),
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
                                                    snapshot.data!.docs[index]['name'].toString(),
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
                                                    snapshot.data!.docs[index]['persons'].toString(),

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
                                                        .approval,
                                                    color: Colors.blue,
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  Text(
                                                    // item['pricePerPerson'].toString(),
"Status"
                                                    ,

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
                        }
                    )
                    : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Center(
              child: Text(
              'No Bookings Yet!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26.sp , color: AppColors.lightTextColor),
              ),
              ),
              ],
              );



              }catch(e){
                return Text(
                  'data : ' + e.toString(),
                );
              }
            },
          ),

        ),
      ),
    );
  }
}

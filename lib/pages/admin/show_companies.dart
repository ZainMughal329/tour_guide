import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/pages/admin/controller.dart';
class ShowCompanies extends GetView<AdminController> {
  const ShowCompanies({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: controller.firestore,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
            }
            return snapshot.data!.docs.length != 0
                ?
            ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightCardColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.lightActiveIconColor.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              height: 40.w,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: AppColors.lightActiveIconColor,
                                border: Border.all(
                                  color: AppColors.lightActiveIconColor,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: snapshot.data!.docs[index]['logo'].toString() == ''
                                    ? Icon(
                                  Icons.person_outline,
                                  size: 30.sp,
                                  color: AppColors.lightActiveIconColor,
                                )
                                    : Image(
                                  image: NetworkImage(
                                    snapshot.data!.docs[index]['logo'].toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              snapshot.data!.docs[index]['CompanyEmail']
                                  .toString(),style: TextStyle(color: AppColors.lightTextColor),
                            ),
                            subtitle: Text(
                              snapshot.data!.docs[index]['CompanyName']
                                  .toString(),style: TextStyle(color: AppColors.lightTextColor),
                            ),
                            trailing: Text(
                              snapshot.data!.docs[index]['companyPhone']
                                  .toString(),style: TextStyle(color: AppColors.lightTextColor),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          snapshot.data!.docs[index]['status']
                              .toString() ==
                              'false'
                              ? Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  controller.deleteCompanyData(
                                      snapshot.data!.docs[index].id
                                          .toString());
                                },
                                child: Text('Decline' , style: TextStyle(color: AppColors.lightTextColor),),
                              ),
                              TextButton(
                                onPressed: () async {
                                  controller.updateCompanyData(
                                      snapshot.data!.docs[index].id
                                          .toString());
                                },
                                child: Text('Approve' , style: TextStyle(color: AppColors.iconsColor),),
                              ),
                            ],
                          )
                              : Container(
                            child: TextButton(
                              onPressed: () async {},
                              child: Text('Approved'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'No new companies to approved!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26.sp , color: AppColors.lightTextColor),
                  ),
                ),
              ],
            );
          } catch (e) {
            return Text(
              'data : ' + e.toString(),
            );
          }
        },
      ),
    );
  }
}

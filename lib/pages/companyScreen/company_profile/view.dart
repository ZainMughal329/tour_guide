import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/update.dart';

import 'controller.dart';

class CompanyProfileView extends GetView<CompanyProfileController> {
  const CompanyProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Container(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.getNodeData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    // color: AppColors.bgColor,
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.cardBgColor,
                          ),
                          child: ListTile(
                            onTap: () {
                              Get.to(() => UpdateCompanyData());
                            },
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: snapshot.data!['logo'].toString() == ''
                                    ? Icon(
                                        Icons.person_outline,
                                        size: 30,
                                        color: Colors.white,
                                      )
                                    : Image(
                                        image: NetworkImage(
                                          snapshot.data!['logo'].toString(),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            title: Text(
                              snapshot.data!['CompanyEmail'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                                snapshot.data!['companyPhone'].toString(),
                                style: TextStyle(color: Colors.white)),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.iconsColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.cardBgColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                child: ListTile(
                                  onTap: () {},
                                  leading: Icon(
                                    Icons.notifications,
                                    color: Colors.blue,
                                  ),
                                  title: Text(
                                    'Notifications',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.radio_button_on,
                                      color: AppColors.iconsColor,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 5,
                              ),
                              Container(
                                height: 50,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.dark_mode_outlined,
                                    color: Colors.blue,
                                  ),
                                  title: Text(
                                    'Dark Mode',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Icon(
                                    Icons.radio_button_on_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 270,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.cardBgColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(
                                    'What\'s new',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.iconsColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.white, height: 5),
                              Container(
                                height: 50,
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(
                                    'FAQ\'s / Contact us',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.iconsColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5),
                              Container(
                                height: 50,
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(
                                    'Community Guidelines',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.iconsColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5),
                              Container(
                                height: 50,
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(
                                    'Term of use',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.iconsColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5),
                              Container(
                                height: 50,
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(
                                    'Privacy Policy',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.iconsColor,
                                  ),
                                ),
                              ),
                              // Divider(color: Colors.grey,),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(bottom: 15.h),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                final auth = FirebaseAuth.instance;
                                auth.signOut().then((value) {
                                  Get.offAndToNamed(AppRoutes.LOGIN_SIGN_UP);
                                  Get.snackbar(
                                    'Congrats',
                                    'Successfully logOut ',
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.green,
                                    backgroundColor:
                                        Colors.green.withOpacity(0.1),
                                  );
                                }).onError((error, stackTrace) {
                                  Get.snackbar(
                                    'Error',
                                    'Something went wrong + ' + error.toString(),
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.green,
                                    backgroundColor:
                                        Colors.green.withOpacity(0.1),
                                  );
                                });
                              },
                              child: Padding(
                                padding:  EdgeInsets.only(bottom: 15.h),
                                child: InkWell(
                                  child: Container(
                                    height: 50,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blue),
                                    child: Center(
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  onTap: () {

                                    final auth = FirebaseAuth.instance;
                                    auth.signOut().then(
                                      (value) {
                                        Get.snackbar('Successful', 'Log Out');
                                        Get.offAndToNamed(AppRoutes.LOGIN_SIGN_UP);
                                      },
                                    ).onError((error, stackTrace) {
                                      Get.snackbar('Error', 'Something goes wrong');
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PersonMenuWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const PersonMenuWidget(
      {Key? key, required this.icon, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: ListTile(
          leading: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.blue.withOpacity(0.1),
            ),
            child: Icon(
              icon,
              color: Colors.blueAccent,
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

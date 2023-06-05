import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import 'controller.dart';

class CompanyProfileView extends GetView<CompanyProfileController> {

  const CompanyProfileView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 10.h),
          child: Container(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: controller.getNodeData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Access the data using snapshot.data
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black,
                          ),
                          child: ListTile(
                            onTap: () {
                              // Get.to(() => UpdateScreen());
                            },
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Icons.person_outline,
                                size: 30,
                                color: Colors.white,
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
                              color: Colors.white,
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
                            color: Colors.black,
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
                                    onTap: () {
                                      print('object');
                                      // Get.isDarkMode ? themeController.changeTheme(AppThemes.lightTheme) : themeController.changeTheme(AppThemes.darkTheme);
                                      // themeController.isDarkMode.value ? AppThemes.lightTheme : AppThemes.darkTheme ;
                                      print('object2');
                                    },
                                    child: Icon(
                                      Icons.radio_button_on,
                                      color: Colors.white,
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
                            color: Colors.black,
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
                                    color: Colors.white,
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
                                    color: Colors.white,
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
                                    color: Colors.white,
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
                                    color: Colors.white,
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
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              // Divider(color: Colors.grey,),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              // LoginController.instance.register(email.text.trim(), password.text.trim());
                              final auth = FirebaseAuth.instance;
                              auth.signOut().then((value) {
                                Get.offAndToNamed(AppRoutes.SIGN_IN);
                                Get.snackbar(
                                  'Congrats',
                                  'Successfully logOut ',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.green,
                                  backgroundColor: Colors.green.withOpacity(0.1),
                                );
                              }).onError((error, stackTrace) {
                                Get.snackbar(
                                  'Error',
                                  'Aomething went wrong + ' + error.toString(),
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.green,
                                  backgroundColor: Colors.green.withOpacity(0.1),
                                );
                              });
                            },
                            child: InkWell(
                              child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blue
                                  // color: AppColors.buttonBgColor,
                                ),
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
                                auth.signOut().then((value) {
                                  Get.snackbar('Successfull', 'Log Out');
                                  Get.offAndToNamed(AppRoutes.SIGN_IN);
                                }).onError((error, stackTrace) {
                                  Get.snackbar('Error', 'Something goes wrong');
                                  print('Error is : ' + error.toString());
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                  // Build your UI using the retrieved data
                  // return Text(data.toString());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/round_button.dart';
import 'package:tours_guide/ReUsable/Components/snackBar.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/update.dart';
import 'package:tours_guide/pages/screens/PersonPage/community_guidlines.dart';
import 'package:tours_guide/pages/screens/PersonPage/contact_us.dart';
import 'package:tours_guide/pages/screens/PersonPage/faqs.dart';
import 'package:tours_guide/pages/screens/PersonPage/privacy_policy.dart';
import 'package:tours_guide/pages/screens/PersonPage/term_of_use.dart';

import 'controller.dart';

class CompanyProfileView extends GetView<CompanyProfileController> {
  const CompanyProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBgColor,
      resizeToAvoidBottomInset: true,
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
                            color: AppColors.lightCardColor.withOpacity(0.2),
                          ),
                          child: ListTile(
                            onTap: () {
                              Get.to(() => UpdateCompanyData());
                            },
                            leading: Container(
                              height: 50.w,
                              width: 50.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightActiveIconColor,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: snapshot.data!['logo'].toString() == ''
                                    ? Icon(
                                        Icons.person_outline,
                                        size: 30.sp,
                                        color: AppColors.lightActiveIconColor,
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
                              style: TextStyle(color: AppColors.lightTextColor),
                            ),
                            subtitle: Text(
                                snapshot.data!['companyPhone'].toString(),
                                style:
                                    TextStyle(color: AppColors.lightTextColor)),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.lightActiveIconColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // Container(
                        //   height: 120,
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     color: AppColors.lightCardColor.withOpacity(0.1),
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: Column(
                        //     children: [
                        //       // Container(
                        //       //   height: 40.h,
                        //       //   child: ListTile(
                        //       //     onTap: () {},
                        //       //     leading: Icon(
                        //       //       Icons.notifications,
                        //       //       color: AppColors.lightActiveIconColor,
                        //       //     ),
                        //       //     title: Text(
                        //       //       'Notifications',
                        //       //       style: TextStyle(color: AppColors.lightTextColor),
                        //       //     ),
                        //       //     trailing: InkWell(
                        //       //       onTap: () {},
                        //       //       child: Icon(
                        //       //         Icons.radio_button_on,
                        //       //         color: AppColors.lightActiveIconColor,
                        //       //       ),
                        //       //     ),
                        //       //   ),
                        //       // ),
                        //       // Divider(
                        //       //   color: Colors.grey,
                        //       //   height: 5.h,
                        //       // ),
                        //       // Container(
                        //       //   height: 40.h,
                        //       //   child: ListTile(
                        //       //     leading: Icon(
                        //       //       Icons.dark_mode_outlined,
                        //       //       color: AppColors.lightActiveIconColor,
                        //       //     ),
                        //       //     title: Text(
                        //       //       'Dark Mode',
                        //       //       style: TextStyle(color: AppColors.lightTextColor),
                        //       //     ),
                        //       //     trailing: Icon(
                        //       //       Icons.radio_button_on_outlined,
                        //       //       color: AppColors.lightActiveIconColor,
                        //       //     ),
                        //       //   ),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 225.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.lightCardColor.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => ContactUsWidget());
                                  },
                                  title: Text(
                                    'Contact us',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5.h),
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => FAQsWidget());
                                  },
                                  title: Text(
                                    'FAQ\'s',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5.h),
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => CommunityGuidelinesScreen());
                                  },
                                  title: Text(
                                    'Community Guidelines',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5.h),
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => TermsOfUseScreen());
                                  },
                                  title: Text(
                                    'Term of use',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.lightActiveIconColor,
                                  ),
                                ),
                              ),
                              Divider(color: Colors.grey, height: 5.h),
                              Container(
                                height: 40.h,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(() => PrivacyPolicyScreen());
                                  },
                                  title: Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                        color: AppColors.lightTextColor),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right_alt,
                                    color: AppColors.lightActiveIconColor,
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
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: Obx(
                            () => RoundButton(
                              title: 'LogOut',
                              onPress: () {
                                controller.setLoading(true);
                                final auth = FirebaseAuth.instance;
                                auth.signOut().then((value) {
                                  controller.setLoading(false);

                                  Get.offAndToNamed(AppRoutes.LOGIN_SIGN_UP);
                                  Snackbar.showSnackBar(
                                    'Congrats',
                                    'Successfully logOut ',
                                  );
                                }).onError((error, stackTrace) {
                                  controller.setLoading(false);

                                  Snackbar.showSnackBar(
                                    'Error',
                                    'Something went wrong + ' +
                                        error.toString(),
                                  );
                                });
                              },
                              loading: controller.state.loading.value,
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

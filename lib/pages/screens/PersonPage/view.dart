// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class PersonView extends GetView<PersonController> {
//   const PersonView({Key? key}) : super(key: key);
//
//   // Widget profilePic(VoidCallback tap) {
//   //   return InkWell(
//   //     onTap: tap,
//   //     child: Container(
//   //       // color: Colors.red,
//   //       height: 150.h,
//   //       width: 140.w,
//   //       child: Stack(
//   //         children: [
//   //           Center(
//   //             child: CircleAvatar(
//   //               backgroundColor: Colors.white,
//   //               radius: 100.h,
//   //               child:
//   //                   // CachedNetworkImage(
//   //                   //   imageUrl: '',
//   //                   //   imageBuilder: (context, imageProvider) => Container(
//   //                   //     height: 150.h,
//   //                   //     width: 140.w,
//   //                   //     margin: null,
//   //                   //     decoration: BoxDecoration(
//   //                   //         borderRadius: BorderRadius.circular(44),
//   //                   //         image: DecorationImage(
//   //                   //           image: imageProvider,
//   //                   //           fit: BoxFit.cover,
//   //                   //         )),
//   //                   //   ),
//   //                   //   errorWidget: (context, url, error) => Icon(
//   //                   //     Icons.person,
//   //                   //   ),
//   //                   // ),
//   //                   Icon(
//   //                 Icons.person,
//   //                 color: Colors.black12,
//   //                 size: 150.h,
//   //               ),
//   //             ),
//   //           ),
//   //           Positioned(
//   //             bottom: 6.h,
//   //             right: 0.01.w,
//   //             child: Padding(
//   //               padding: const EdgeInsets.only(right: 3, bottom: 3),
//   //               child: Container(
//   //                 decoration: BoxDecoration(
//   //                   // color: Colors.white,
//   //                   borderRadius: BorderRadius.circular(10),
//   //                 ),
//   //                 height: 50.h,
//   //                 width: 40.w,
//   //                 child: Icon(
//   //                   Icons.edit,
//   //                   size: 30.h,
//   //                   color: Colors.black.withOpacity(0.5),
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   //
//   // Widget profileName(String name) {
//   //   return Padding(
//   //     padding: EdgeInsets.symmetric(vertical: 20.h),
//   //     child: Container(
//   //       child: Center(
//   //         child: Text(name,
//   //             overflow: TextOverflow.clip,
//   //             maxLines: 1,
//   //             style: TextStyle(
//   //               fontSize: 19.sp,
//   //               fontWeight: FontWeight.w800,
//   //             )),
//   //       ),
//   //     ),
//   //   );
//   // }
//   //
//   // Widget userInfo(String title, String trailing) {
//   //   return Column(
//   //     children: [
//   //       ListTile(
//   //         title: Text(
//   //           title,
//   //           style: TextStyle(color: Colors.black.withOpacity(0.5)),
//   //         ),
//   //         trailing: Text(trailing,
//   //             style: TextStyle(color: Colors.black.withOpacity(0.5))),
//   //       ),
//   //     ],
//   //   );
//   // }
//   //
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     backgroundColor: Colors.white,
//   //     drawer: BuildDrawer.buildDrawer(context),
//   //     appBar: PreferredSize(
//   //       preferredSize: Size.fromHeight(100.0),
//   //       child: BuildAppBar(
//   //         title: 'Profile',
//   //         icon1: Icons.sort_rounded,
//   //         icon2: Icons.more_vert_rounded,
//   //       ),
//   //     ),
//   //     body: SafeArea(
//   //         child: SingleChildScrollView(
//   //       child: Padding(
//   //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//   //         child: Center(
//   //           child: Column(
//   //             children: [
//   //               FutureBuilder(
//   //                 future: controller.getUserData(),
//   //                 builder: (context, snapshot) {
//   //                   if (snapshot.connectionState == ConnectionState.done) {
//   //                     if (snapshot.hasData) {
//   //                       UserModel userModel = snapshot.data as UserModel;
//   //                       return Container(
//   //                         padding: const EdgeInsets.all(0),
//   //                         child: Column(
//   //                           children: [
//   //                             GetBuilder<PersonController>(
//   //                                 builder: (controller) {
//   //                               return Stack(
//   //                                 children: [
//   //                                   Container(
//   //                                     height: 120,
//   //                                     width: 120,
//   //                                     decoration: BoxDecoration(
//   //                                       borderRadius:
//   //                                           BorderRadius.circular(100),
//   //                                       border: Border.all(color: Colors.black),
//   //                                     ),
//   //                                     child: ClipRRect(
//   //                                       borderRadius:
//   //                                           BorderRadius.circular(100),
//   //                                       child: controller.image == null
//   //                                           ? userModel.photoUrl == ''
//   //                                               ? Icon(
//   //                                                   Icons.person,
//   //                                                   size: 50,
//   //                                                 )
//   //                                               : Image(
//   //                                                   image: NetworkImage(
//   //                                                       userModel.photoUrl),
//   //                                                   fit: BoxFit.cover,
//   //                                                 )
//   //                                           : Image.file(
//   //                                               File(controller.image!.path)
//   //                                                   .absolute,
//   //                                               fit: BoxFit.cover,
//   //                                             ),
//   //                                     ),
//   //                                   ),
//   //                                   // Positioned(
//   //                                   //   right: 10,
//   //                                   //   bottom: 0,
//   //                                   //   child: InkWell(
//   //                                   //     onTap: () {
//   //                                   //       controller.showImage(
//   //                                   //           context, userModel);
//   //                                   //     },
//   //                                   //     child: Container(
//   //                                   //       height: 25,
//   //                                   //       width: 25,
//   //                                   //       decoration: BoxDecoration(
//   //                                   //         color: Colors.black,
//   //                                   //         borderRadius:
//   //                                   //             BorderRadius.circular(100),
//   //                                   //         border:
//   //                                   //             Border.all(color: Colors.black),
//   //                                   //       ),
//   //                                   //       child: ClipRRect(
//   //                                   //         borderRadius:
//   //                                   //             BorderRadius.circular(100),
//   //                                   //         child: const Icon(
//   //                                   //           Icons.edit,
//   //                                   //           size: 20,
//   //                                   //           color: Colors.white,
//   //                                   //         ),
//   //                                   //       ),
//   //                                   //     ),
//   //                                   //   ),
//   //                                   // ),
//   //                                 ],
//   //                               );
//   //                             }),
//   //
//   //                             const SizedBox(
//   //                               height: 10,
//   //                             ),
//   //                             PersonMenuWidget(
//   //                                 icon: Icons.person_outline,
//   //                                 title: 'UserName',
//   //                                 value: userModel.username),
//   //                             PersonMenuWidget(
//   //                                 icon: Icons.email_outlined,
//   //                                 title: 'Email',
//   //                                 value: userModel.email),
//   //                             PersonMenuWidget(
//   //                                 icon: Icons.phone,
//   //                                 title: 'Phone',
//   //                                 value: userModel.phoneNo),
//   //                             PersonMenuWidget(
//   //                                 icon: Icons.verified_user_outlined,
//   //                                 title: 'Type',
//   //                                 value: userModel.type),
//   //
//   //                             const SizedBox(
//   //                               height: 20,
//   //                             ),
//   //                             SizedBox(
//   //                               width: double.infinity,
//   //                               height: 50,
//   //                               child: ElevatedButton(
//   //                                 onPressed: () {
//   //                                   Get.to(() => UpdateScreen());
//   //                                 },
//   //                                 style: ElevatedButton.styleFrom(
//   //                                   backgroundColor: Colors.black,
//   //                                   side: BorderSide.none,
//   //                                   shape: const StadiumBorder(),
//   //                                 ),
//   //                                 child: const Center(
//   //                                     child: Text(
//   //                                   'Edit Profile',
//   //                                   style: TextStyle(
//   //                                       color: Colors.white, fontSize: 18),
//   //                                 )),
//   //                               ),
//   //                             ),
//   //                             // const Divider(),
//   //                           ],
//   //                         ),
//   //                       );
//   //                     } else if (snapshot.hasError) {
//   //                       print('Error is : ' + snapshot.error.toString());
//   //                       return Center(child: CircularProgressIndicator());
//   //                     } else {
//   //                       print('Something went wrong');
//   //                       return Text('Something went wrong');
//   //                     }
//   //                   } else {
//   //                     return Center(child: CircularProgressIndicator());
//   //                   }
//   //                 },
//   //               ),
//   //               SizedBox(
//   //                 height: 20,
//   //               ),
//   //               SizedBox(
//   //                 width: double.infinity,
//   //                 height: 50,
//   //                 child: ElevatedButton(
//   //                   onPressed: () {
//   //                     controller.setLoading(true);
//   //
//   //                     controller.signOut();
//   //                   },
//   //                   style: ElevatedButton.styleFrom(
//   //                     backgroundColor: Colors.black,
//   //                     side: BorderSide.none,
//   //                     shape: const StadiumBorder(),
//   //                   ),
//   //                   child: const Center(
//   //                       child: Text(
//   //                     'Sign Out',
//   //                     style: TextStyle(color: Colors.white, fontSize: 18),
//   //                   )),
//   //                 ),
//   //               ),
//   //               SizedBox(
//   //                 height: 20,
//   //               ),
//   //               Align(
//   //                 alignment: Alignment.center,
//   //                 child: TextButton(
//   //                   child: Text("Login as Admin"),
//   //                   onPressed: () {
//   //                     Get.toNamed(AppRoutes.Admin_Login);
//   //                   },
//   //                 ),
//   //               ),
//   //               Align(
//   //                 alignment: Alignment.center,
//   //                 child: TextButton(
//   //                   child: Text("Login as Tourist Company"),
//   //                   onPressed: () {
//   //                     Get.toNamed(AppRoutes.Tourist_Login);
//   //                   },
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     )),
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Text('Profile'),
//         backgroundColor: Colors.black,
//         centerTitle: true,
//         actions: [
//           IconButton(
//               onPressed: () {}, icon: const Icon(Icons.dark_mode_outlined))
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             FutureBuilder(
//               future: controller.getUserData(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasData) {
//                     UserModel userModel = snapshot.data as UserModel;
//                     return Container(
//                       padding: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 70,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: Colors.black,
//                             ),
//                             child: ListTile(
//                               onTap: () {
//                                 Get.to(() => UpdateScreen());
//                               },
//                               leading: Container(
//                                 height: 50,
//                                 width: 50,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(100),
//                                   child: controller.image == null
//                                       ? userModel.photoUrl == ''
//                                       ? Icon(
//                                     Icons.person,
//                                     size: 50,
//                                   )
//                                       : Image(
//                                     image: NetworkImage(
//                                         userModel.photoUrl),
//                                     fit: BoxFit.cover,
//                                   )
//                                       : Image.file(
//                                     File(controller.image!.path).absolute,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               title: Text(
//                                 userModel.email,
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               subtitle: Text(userModel.phoneNo,
//                                   style: TextStyle(color: Colors.white)),
//                               trailing: Icon(
//                                 Icons.arrow_forward_ios,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           // Stack(
//                           //   children: [
//                           //     Container(
//                           //       height: 120,
//                           //       width: 120,
//                           //       decoration: BoxDecoration(
//                           //         borderRadius: BorderRadius.circular(100),
//                           //         border: Border.all(color: Colors.black),
//                           //       ),
//                           //       child: ClipRRect(
//                           //         borderRadius: BorderRadius.circular(100),
//                           //         child: controller.image == null
//                           //             ? userModel.photoUrl == ''
//                           //                 ? Icon(
//                           //                     Icons.person,
//                           //                     size: 50,
//                           //                   )
//                           //                 : Image(
//                           //                     image: NetworkImage(
//                           //                         userModel.photoUrl),
//                           //                     fit: BoxFit.cover,
//                           //                   )
//                           //             : Image.file(
//                           //                 File(controller.image!.path).absolute,
//                           //                 fit: BoxFit.cover,
//                           //               ),
//                           //       ),
//                           //     ),
//                           //     Positioned(
//                           //       right: 10,
//                           //       bottom: 0,
//                           //       child: InkWell(
//                           //         onTap: () {},
//                           //         child: Container(
//                           //           height: 25,
//                           //           width: 25,
//                           //           decoration: BoxDecoration(
//                           //             color: Colors.black,
//                           //             borderRadius: BorderRadius.circular(100),
//                           //             border: Border.all(color: Colors.black),
//                           //           ),
//                           //           child: ClipRRect(
//                           //             borderRadius: BorderRadius.circular(100),
//                           //             child: const Icon(
//                           //               Icons.edit,
//                           //               size: 20,
//                           //               color: Colors.white,
//                           //             ),
//                           //           ),
//                           //         ),
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             height: 120,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 50,
//                                   child: ListTile(
//                                     onTap: () {
//                                       // themeController.isDarkMode.value ? AppThemes.lightTheme : AppThemes.darkTheme ;
//                                     },
//                                     leading: Icon(
//                                       Icons.notifications,
//                                       color: Colors.blue,
//                                     ),
//                                     title: Text(
//                                       'Notifications',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     trailing: GetBuilder<ThemeController>(
//                                         builder: (context) {
//                                           return Switch(value: themeController.isDarkMode.value, onChanged: (state) {
//                                             themeController.changeTheme();
//                                           });
//                                         }
//                                     ),
//                                     // InkWell(
//                                     //   onTap: () {
//                                     //     print('object');
//                                     //     // Get.isDarkMode ? themeController.changeTheme(AppThemes.lightTheme) : themeController.changeTheme(AppThemes.darkTheme);
//                                     //     // themeController.isDarkMode.value ? AppThemes.lightTheme : AppThemes.darkTheme ;
//                                     //     print('object2');
//                                     //   },
//                                     //   child: themeController.isDarkMode
//                                     //       ? Icon(
//                                     //           Icons.radio_button_on,
//                                     //           color: Colors.white,
//                                     //         )
//                                     //       : Icon(
//                                     //           Icons.radio_button_off,
//                                     //           color: Colors.white,
//                                     //         ),
//                                     // ),
//                                   ),
//                                 ),
//                                 Divider(
//                                   color: Colors.grey,
//                                   height: 5,
//                                 ),
//                                 Container(
//                                   height: 50,
//                                   child: ListTile(
//                                     leading: Icon(
//                                       Icons.dark_mode_outlined,
//                                       color: Colors.blue,
//                                     ),
//                                     title: Text(
//                                       'Dark Mode',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     trailing: Icon(
//                                       Icons.radio_button_on_outlined,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Text(
//                           //   userModel.email,
//                           //   style: Theme.of(context)
//                           //       .textTheme
//                           //       .headlineSmall!
//                           //       .copyWith(
//                           //           color: Colors.black,
//                           //           fontWeight: FontWeight.w500),
//                           // ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             height: 270,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 50,
//                                   child: ListTile(
//                                     onTap: () {},
//                                     title: Text(
//                                       'What\'s new',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     trailing: Icon(
//                                       Icons.arrow_right_alt,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Divider(color: Colors.white, height: 5),
//                                 Container(
//                                   height: 50,
//                                   child: ListTile(
//                                     onTap: () {},
//                                     title: Text(
//                                       'FAQ\'s / Contact us',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     trailing: Icon(
//                                       Icons.arrow_right_alt,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Divider(color: Colors.grey, height: 5),
//                                 Container(
//                                   height: 50,
//                                   child: ListTile(
//                                     onTap: () {},
//                                     title: Text(
//                                       'Community Guidelines',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     trailing: Icon(
//                                       Icons.arrow_right_alt,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Divider(color: Colors.grey, height: 5),
//                                 Container(
//                                   height: 50,
//                                   child: ListTile(
//                                     onTap: () {},
//                                     title: Text(
//                                       'Term of use',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     trailing: Icon(
//                                       Icons.arrow_right_alt,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Divider(color: Colors.grey, height: 5),
//                                 Container(
//                                   height: 50,
//                                   child: ListTile(
//                                     onTap: () {},
//                                     title: Text(
//                                       'Privacy Policy',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                     trailing: Icon(
//                                       Icons.arrow_right_alt,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 // Divider(color: Colors.grey,),
//                               ],
//                             ),
//                           ),
//                           // Text(
//                           //   userModel.phoneNo,
//                           //   style: Theme.of(context)
//                           //       .textTheme
//                           //       .bodyMedium!
//                           //       .copyWith(
//                           //           color: Colors.black,
//                           //           fontWeight: FontWeight.normal),
//                           // ),
//                           // const SizedBox(
//                           //   height: 20,
//                           // ),
//                           // SizedBox(
//                           //   width: 200,
//                           //   height: 50,
//                           //   child: ElevatedButton(
//                           //     onPressed: () {
//                           //       Get.to(() => UpdateScreen());
//                           //     },
//                           //     style: ElevatedButton.styleFrom(
//                           //       backgroundColor: Colors.black,
//                           //       side: BorderSide.none,
//                           //       shape: const StadiumBorder(),
//                           //     ),
//                           //     child: const Center(
//                           //         child: Text(
//                           //       'Edit Profile',
//                           //       style: TextStyle(
//                           //           color: Colors.white, fontSize: 18),
//                           //     )),
//                           //   ),
//                           // ),
//                           // const Divider(),
//
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Center(
//                             child: InkWell(
//                               onTap: () {
//                                 // LoginController.instance.register(email.text.trim(), password.text.trim());
//                                 final auth = FirebaseAuth.instance;
//                                 auth.signOut().then((value) {
//                                   Get.to(LoginSCreen());
//                                   Get.snackbar(
//                                     'Congrats',
//                                     'Successfully logOut ',
//                                     snackPosition: SnackPosition.BOTTOM,
//                                     colorText: Colors.green,
//                                     backgroundColor:
//                                     Colors.green.withOpacity(0.1),
//                                   );
//                                 }).onError((error, stackTrace) {
//                                   Get.snackbar(
//                                     'Error',
//                                     'Aomething went wrong + ' +
//                                         error.toString(),
//                                     snackPosition: SnackPosition.BOTTOM,
//                                     colorText: Colors.green,
//                                     backgroundColor:
//                                     Colors.green.withOpacity(0.1),
//                                   );
//                                 });
//                               },
//                               child: Container(
//                                 height: 50,
//                                 width: 300,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: Colors.blue,
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     'Logout',
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 17),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.center,
//                             child: TextButton(
//                               child: Text("Login as Admin"),
//                               onPressed: () {
//                                 Get.to(() => AdminLoginScreen());
//                               },
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.center,
//                             child: TextButton(
//                               child: Text("Login as User"),
//                               onPressed: () {
//                                 Get.to(() => UserRegistrationScreen());
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else if (snapshot.hasError) {
//                     print('Error is : ' + snapshot.error.toString());
//                     return Center(child: CircularProgressIndicator());
//                   } else {
//                     print('Something went wrong');
//                     return Text('Something went wrong');
//                   }
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // class PersonMenuWidget extends StatelessWidget {
// //   final String title;
// //   final String value;
// //   final IconData icon;
// //   const PersonMenuWidget(
// //       {Key? key, required this.icon, required this.title, required this.value})
// //       : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 10),
// //       child: Card(
// //         child: ListTile(
// //           leading: Container(
// //             width: 40.w,
// //             height: 40.h,
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(100),
// //               color: Colors.blue.withOpacity(0.1),
// //             ),
// //             child: Icon(
// //               icon,
// //               color: Colors.blueAccent,
// //             ),
// //           ),
// //           title: Text(
// //             title,
// //             style: Theme.of(context).textTheme.bodyMedium,
// //           ),
// //           trailing: Text(
// //             value,
// //             style: Theme.of(context).textTheme.bodyMedium,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

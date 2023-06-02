// import 'dart:io';
//
// import 'package:air_proj_comp/common/utils/input_text_field.dart';
// import 'package:air_proj_comp/pages/screens/PersonPage/view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../models/usermodel.dart';
// import 'controller.dart';
//
// class UpdateScreen extends StatefulWidget {
//   const UpdateScreen({Key? key}) : super(key: key);
//
//   @override
//   State<UpdateScreen> createState() => _UpdateScreenState();
// }
//
// class _UpdateScreenState extends State<UpdateScreen> {
//   var controller = Get.put(PersonController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Text('Edit Profile'),
//         backgroundColor: Colors.black,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(30),
//           child: FutureBuilder(
//             future: controller.getUserData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasData) {
//                   UserModel userModel = snapshot.data as UserModel;
//                   final email = TextEditingController(text: userModel.email);
//                   final phone = TextEditingController(text: userModel.phoneNo);
//                   final pass = TextEditingController(text: userModel.password);
//                   final name = TextEditingController(text: userModel.username);
//                   final user = TextEditingController(text: 'user');
//                   final id = TextEditingController(text: userModel.id);
//
//                   return Column(
//                     children: [
//                       GetBuilder<PersonController>(builder: (controller){
//                         return Stack(
//                           children: [
//                             Container(
//                               height: 120,
//                               width: 120,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(100),
//                                 border: Border.all(color: Colors.black),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(100),
//                                 child:
//                                 controller.image == null ?
//                                 userModel.photoUrl == ''  ?   Icon(Icons.person , size: 50,) :
//                                 Image(image: NetworkImage(userModel.photoUrl),fit: BoxFit.cover,) : Image.file(
//                                   File(controller.image!.path)
//                                       .absolute,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               right: 10,
//                               bottom: 0,
//                               child: InkWell(
//                                 onTap: () {
//                                   controller.showImage(context , userModel);
//                                 },
//                                 child: Container(
//                                   height: 25,
//                                   width: 25,
//                                   decoration: BoxDecoration(
//                                     color: Colors.black,
//                                     borderRadius: BorderRadius.circular(100),
//                                     border: Border.all(color: Colors.black),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(100),
//                                     child: const Icon(
//                                       Icons.edit,
//                                       size: 20,
//                                       color: Colors.white,
//                                     ),
//
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Form(
//                         child: Column(
//                           children: [
//                             InputText(
//                                 textController: name,
//                                 icon: Icons.person_outline,
//                                 focusNode: controller.userFocus,
//                                 hint: 'UserName',
//                                 obscureText: false),
//
//                             InputText(
//                                 textController: email,
//                                 icon: Icons.email_outlined,
//                                 focusNode: controller.emailFocus,
//                                 hint: 'Email',
//                                 obscureText: false),
//
//                             InputText(
//                                 textController: phone,
//                                 icon: Icons.phone,
//                                 focusNode: controller.phoneFocus,
//                                 hint: 'Phone',
//                                 obscureText: false),
//
//                             InputText(
//                                 textController: pass,
//                                 icon: Icons.fingerprint_outlined,
//                                 focusNode: controller.passwordFocus,
//                                 hint: 'Password',
//                                 obscureText: true),
//
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
//                               child: TextFormField(
//                                 controller: user,
//                                 enabled: false,
//
//                                 // keyboardType: TextInputType.emailAddress,
//                                 decoration: InputDecoration(
//                                     hintText: "User",
//                                     prefixIcon: Icon(Icons.verified_user_outlined),
//                                     labelText: 'User',
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//
//                                     )
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             var userData = UserModel(
//                                 id: id.text,
//                                 email: email.text.trim(),
//                                 phoneNo: phone.text.trim(),
//                                 password: pass.text.trim(),
//                                 username: name.text.trim(),
//                                 photoUrl: userModel.photoUrl,
//                                 type: user.text.trim());
//                             await controller.updateUser(userData);
//                             Get.to(() => PersonView());
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.black,
//                             side: BorderSide.none,
//                             shape: const StadiumBorder(),
//                           ),
//                           child: const Center(
//                               child: Text(
//                             'Save Profile',
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                           )),
//                         ),
//                       ),
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   print('Error is : ' + snapshot.error.toString());
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   return Text('Error occurs');
//                 }
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/models/companyModel.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/pages/companyScreen/company_profile/index.dart';

import 'controller.dart';

class UpdateTourData extends GetView<CompanyShowTourController> {
  final String id;

  UpdateTourData({Key? key, required this.id}) : super(key: key);

  final auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  Widget _textField(TextEditingController contr, FocusNode focNode,
      String labelText, String descrip) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: TextFormField(
        controller: contr,
        focusNode: focNode,
        validator: (value) {},
        onFieldSubmitted: (value) {},
        decoration: InputDecoration(
          hintText: descrip,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(40.r),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCatList(String cat) {
    return Obx(
      () => Expanded(
        flex: 0,
        child: DropdownButton(
          iconEnabledColor: AppColors.SuccessColor,
          iconSize: 40.0.h,
          hint: controller.state.catValue.value == ""
              ? Text(cat)
              : Text(controller.state.catValue.value),
          items: [
            DropdownMenuItem(
              child: Text("Adventure"),
              value: "Adventure",
            ),
            DropdownMenuItem(
              child: Text("Cultural"),
              value: "Cultural",
            ),
            DropdownMenuItem(
              child: Text("Hiking"),
              value: "Hiking",
            ),
            DropdownMenuItem(
              child: Text("Mountains"),
              value: "Mountains",
            ),
          ],
          onChanged: (String? value) {
            controller.state.catValue.value = value!;
          },
        ),
      ),
    );
  }

  Widget _buildPeopleList(String people) {
    return Obx(
      () => Expanded(
        flex: 0,
        child: DropdownButton(
          iconEnabledColor: AppColors.SuccessColor,
          iconSize: 40.0.h,
          hint: controller.state.tourPeople.value == ""
              ? Text(people)
              : Text(controller.state.tourPeople.value),
          items: [
            DropdownMenuItem(
              child: Text("1"),
              value: "1",
            ),
            DropdownMenuItem(
              child: Text("2"),
              value: "2",
            ),
            DropdownMenuItem(
              child: Text("3"),
              value: "3",
            ),
            DropdownMenuItem(
              child: Text("4"),
              value: "4",
            ),
            DropdownMenuItem(
              child: Text("5"),
              value: "5",
            ),
            DropdownMenuItem(
              child: Text("6"),
              value: "6",
            ),
            DropdownMenuItem(
              child: Text("7"),
              value: "7",
            ),
            DropdownMenuItem(
              child: Text("8"),
              value: "8",
            ),
            DropdownMenuItem(
              child: Text("9"),
              value: "9",
            ),
            DropdownMenuItem(
              child: Text("10"),
              value: "10",
            ),
          ],
          onChanged: (String? value) {
            controller.state.tourPeople.value = value!;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Company Info'),
        backgroundColor: AppColors.activeIconColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(16.0.h),
              child: FutureBuilder(
                  future: controller.getUsersData(id),
                  builder: (context, snapshot) {
                    print('id is : ' + id.toString());
                    print('inside builder');
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print('inside if');

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      print('inside snapshot');
                      TourModel tourModel = snapshot.data as TourModel;
                      final location =
                          TextEditingController(text: tourModel.location);
                      final price =
                          TextEditingController(text: tourModel.price);
                      final people =
                          TextEditingController(text: tourModel.people);
                      final title =
                          TextEditingController(text: tourModel.title);
                      final des = TextEditingController(
                          text: tourModel.tourDescription);
                      final category =
                          TextEditingController(text: tourModel.tourCategory);

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            GetBuilder<CompanyShowTourController>(
                                builder: (controller) {
                              return Column(
                                children: [
                                  Container(
                                    height: 200.h,
                                    width: double.infinity,
                                    child: InkWell(
                                      onTap: () {
                                        controller.showImage(context, id);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: controller.image == null
                                            ? tourModel.tourImage.toString() == ''
                                                ? Icon(
                                                    Icons.person,
                                                    size: 50,
                                                  )
                                                : Image(
                                                    image: NetworkImage(tourModel
                                                        .tourImage
                                                        .toString()),
                                                    fit: BoxFit.cover,
                                                  )
                                            : Image.file(
                                                File(controller.image!.path)
                                                    .absolute,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  controller.image == null
                                      ? Text("Tap to Update Image")
                                      : Text(''),
                                ],
                              );
                              //   Stack(
                              //   children: [
                              //     Container(
                              //       height: 120,
                              //       width: 120,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(100),
                              //         border: Border.all(color: Colors.black),
                              //       ),
                              //       child: ClipRRect(
                              //         borderRadius: BorderRadius.circular(100),
                              //         child: controller.image == null
                              //             ? tourModel.tourImage.toString() == ''
                              //             ? Icon(
                              //           Icons.person,
                              //           size: 50,
                              //         )
                              //             : Image(
                              //           image: NetworkImage(tourModel
                              //               .tourImage
                              //               .toString()),
                              //           fit: BoxFit.cover,
                              //         )
                              //             : Image.file(
                              //           File(controller.image!.path).absolute,
                              //           fit: BoxFit.cover,
                              //         ),
                              //       ),
                              //     ),
                              //     Positioned(
                              //       right: 10,
                              //       bottom: 0,
                              //       child: InkWell(
                              //         onTap: () {
                              //           controller.showImage(context,id);
                              //         },
                              //         child: Container(
                              //           height: 25,
                              //           width: 25,
                              //           decoration: BoxDecoration(
                              //             color: Colors.black,
                              //             borderRadius: BorderRadius.circular(100),
                              //             border: Border.all(color: Colors.black),
                              //           ),
                              //           child: ClipRRect(
                              //             borderRadius: BorderRadius.circular(100),
                              //             child: const Icon(
                              //               Icons.edit,
                              //               size: 20,
                              //               color: Colors.white,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // );
                            }),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      _textField(
                                          title,
                                          controller.state.titleNode,
                                          "Title",
                                          "Enter name for your tour"),
                                      _textField(
                                          location,
                                          controller.state.locationNode,
                                          "Location",
                                          "Enter Location of your tour"),
                                      _textField(
                                          price,
                                          controller.state.priceNode,
                                          "Price",
                                          "Enter Price for your tour in Rs"),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: TextField(
                                    controller: des,
                                    focusNode: controller.state.descrepNode,
                                    onEditingComplete: () {},
                                    onSubmitted: (value) {},
                                    decoration: InputDecoration(
                                      labelText: "Tour Description",
                                      hintText:
                                          "Enter long description about you tour",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                    ),
                                    maxLines: 5,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Center(
                                        child: Text("Choose Category",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(fontSize: 20.sp)),
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                      ),
                                      _buildCatList(category.text.toString()),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Center(
                                        child: Text("No of People",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(fontSize: 20.sp)),
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                      ),
                                      _buildPeopleList(people.text.toString()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32.0.h),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  var tourData = TourModel(
                                    id: id,
                                    title: title.text.toString(),
                                    tourCategory:
                                        controller.state.catValue.value,
                                    tourDescription: des.text.toString(),
                                    tourImage: tourModel.tourImage.toString(),
                                    location: location.text.toString(),
                                    people: controller.state.tourPeople.value,
                                    price: price.text.toString(),
                                  );

                                  await controller.updateTour(tourData, id);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  side: BorderSide.none,
                                  shape: const StadiumBorder(),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Save Profile',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Text('Error occurs');
                    }
                  })),
        ),
      ),
    );
  }
}

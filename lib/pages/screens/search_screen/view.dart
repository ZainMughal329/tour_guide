import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/input_fields.dart';
import 'package:tours_guide/pages/screens/home_screen/details.dart';

import '../../../ReUsable/Components/app_bar.dart';
import '../../../ReUsable/Components/drawer.dart';
import '../../../ReUsable/Components/toast_info.dart';
import '../../../ReUsable/models/userModel.dart';
import 'controller.dart';

// import '../../../pages/screens/search_screen/controller.dart';
// import 'controller.dart';

class SearchView extends GetView<SearchBarController> {
  SearchView({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _searchBarView() {
    return TextFieldContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: GetBuilder<SearchBarController>(
          builder: (con) {
            return TextField(
              onChanged: (value) {
                controller.searchTours(value);
              },
              controller: controller.state.searchController,
              textInputAction: TextInputAction.search,

              keyboardType: TextInputType.text,
              // focusNode: focNode,
              decoration: InputDecoration(

                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.lightTextColor,
                ),
                border: InputBorder.none,
                hintText: 'Search tours here...',
              ),
            );
          },
        ),
      ),
    );
  }

  final List<String> dropdownItems = ['Apple', 'Grapes'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: BuildDrawer.buildDrawer(context),
      backgroundColor: AppColors.lightBgColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, right: 20.w, left: 20.w),
            child: Container(
              child: FutureBuilder(
                future: controller.getUsersData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // print('waiting for connection state');
                    // toastInfo(
                    //     msg: "waiting for connection ...",
                    //     length: Toast.LENGTH_SHORT);
                    return Center(
                      child: SizedBox(),
                    );
                  }
                  if (snapshot.hasError) {
                    // toastInfo(msg: "Something went wrong");
                    // print('Inside snapshot error');
                    return SizedBox();
                  }
                  UserModel userModel = snapshot.data as UserModel;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: InkWell(
                              onTap: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: AppColors.lightTextColor,
                                size: 35.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60.w,
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Search tours',
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      color: AppColors.lightTextColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: userModel.photoUrl.toString() == ''
                                ? AppColors.lightTextColor
                                : Colors.white,
                            width: 1.0.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: userModel.photoUrl.toString() == ''
                              ? Icon(
                                  Icons.person_outline,
                                  size: 30.sp,
                                  color: AppColors.lightTextColor,
                                )
                              : Image(
                                  image: NetworkImage(
                                    userModel.photoUrl.toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          _searchBarView(),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Obx(
              () =>
                  // var tours = controller.filteredTourList;
                  controller.filteredTourList.length !=0
                      ? ListView.builder(
                          itemCount: controller.filteredTourList.length,
                          itemBuilder: (context, index) {
                            print('Length iss :' +
                                controller.filteredTourList.length.toString());
                            // Customize this part based on your data structure.
                            var item = controller.filteredTourList[index];
                            print('Item is : ' + item.toString());
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 2),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => DetailScreen(
                                          title: item['title'].toString(),
                                          price: item['price'].toString(),
                                          location: item['location'].toString(),
                                          des: item['tourDescription']
                                              .toString(),
                                          img: item['tourImage'].toString(),
                                          id: item['id'].toString(),
                                          phone:
                                              item['companyPhone'].toString(),
                                        comapnyName: item['companyName'].toString(),
                                        companyId: item['companyId'].toString(),

                                      ));
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 50.h,
                                                  width: 50.w,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppColors.lightActiveIconColor.withOpacity(0.1),
                                                    ),
                                                  ),
                                                  child: item['tourImage']
                                                              .toString() ==
                                                          ''
                                                      ? Icon(
                                                          Icons.person,
                                                          color: AppColors.lightTextColor,
                                                        )
                                                      : Image.network(
                                                          item['tourImage']
                                                              .toString(),
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
                                                      Text(
                                                        (item['title']
                                                                .toString())
                                                            .capitalizeFirst
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: AppColors.lightTextColor,
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        (item['tourCategory']
                                                                .toString())
                                                            .capitalizeFirst
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: AppColors.lightTextColor,
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                      Icons.people,
                                                      color: AppColors.lightTextColor,
                                                      size: 20.sp,
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      item['people']
                                                              .toString() +
                                                          " person\'s",
                                                      style: TextStyle(
                                                          color: AppColors.lightTextColor,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                                          .location_on_outlined,
                                                      color: AppColors.lightTextColor,
                                                      size: 20.sp,
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      item['location']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: AppColors.lightTextColor,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                          },
                        )
                      : Center(
                          child: Text(
                            'No searches yet',
                            style: TextStyle(color: AppColors.lightTextColor, fontSize: 25),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size * 0.8;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width,
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.circular(29),
        border: Border.all(
          color: AppColors.lightTextColor
        )
      ),
      child: child,
    );
  }
}

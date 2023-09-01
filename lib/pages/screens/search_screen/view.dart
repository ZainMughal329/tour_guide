import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/input_fields.dart';

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
        child: TextField(
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
              color: AppColors.kPrimaryColor,
            ),
            border: InputBorder.none,
            hintText: 'Search tours here...',
          ),
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
      backgroundColor: AppColors.bgColor,
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
                    toastInfo(
                        msg: "waiting for connection ...",
                        length: Toast.LENGTH_SHORT);
                    return Center(
                      child: SizedBox(),
                    );
                  }
                  if (snapshot.hasError) {
                    toastInfo(msg: "Something went wrong");
                    print('Inside snapshot error');
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
                                color: Colors.blue,
                                size: 30,
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: userModel.photoUrl.toString() == ''
                                ? Colors.blue
                                : Colors.white,
                            width: 1.0.w,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: userModel.photoUrl.toString() == ''
                              ? Icon(
                                  Icons.person_outline,
                                  size: 30,
                                  color: Colors.blue,
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
                  controller.filteredTourList.isEmpty
                      ? Center(
                          child: Text(
                            'No searches yet',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        )
                      : ListView.builder(
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
                                      // print('object');
                                      // print('id is: ' + item['id'].toString());
                                      // Get.to(() => UpdateScreen(
                                      //   id: item['id'].toString(),
                                      // ));
                                    },
                                    child: ListTile(
                                      tileColor: AppColors.iconsColor,
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.yellow,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          Text(
                                            item['location'].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      title: Text(
                                        (item['title'].toString())
                                            .capitalizeFirst
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        (item['tourCategory'].toString())
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
      ),
      child: child,
    );
  }
}

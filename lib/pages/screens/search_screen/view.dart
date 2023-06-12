import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../ReUsable/Components/app_bar.dart';
import '../../../ReUsable/Components/drawer.dart';
import 'controller.dart';

// import '../../../pages/screens/search_screen/controller.dart';
// import 'controller.dart';

class SearchView extends GetView<SearchBarController> {
  SearchView({Key? key}) : super(key: key);

  Widget _searchBarView() {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 280.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.h),
            border: Border.all(
              color: Colors.grey.withOpacity(0.7),
            ),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 17.w),
                height: 16.h,
                width: 16.w,
                child: Icon(
                  Icons.search,
                  color: Colors.grey.withOpacity(0.7),
                  size: 18,
                ),
              ),
              Container(
                height: 40.h,
                width: 240.w,
                child: TextField(
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                  autocorrect: false,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        GestureDetector(
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(13.w),
            ),
            child: Icon(
              Icons.keyboard_option_key,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
  final List<String> dropdownItems = [
    'Apple',
    'Grapes'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildDrawer.buildDrawer(context),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Search',
          icon1: Icons.sort_rounded,
          icon2: Icons.person_outline,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            _searchBarView(),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => IconButton(
                          icon: controller.state.isDropdownOpen.value
                              ? Icon(Icons.arrow_right ,size: 28.sp,)
                              : Icon(Icons.arrow_drop_down,size: 28.sp),
                          onPressed: () => controller.toggleDropdown(),
                        )),
                    Text('Tour' , style: TextStyle(fontSize: 18.sp),),
                  ],
                ),
                // Obx(
                //   () => controller.state.isDropdownOpen.value
                //       ? DropdownButton<String>(
                //           value: controller.state.selectedItem.value,
                //           items: dropdownItems.map((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //           onChanged: (val) {
                //             controller.selectItem(
                //               val.toString(),
                //             );
                //           })
                //       : SizedBox(),
                // ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => IconButton(
                      icon: controller.state.isDropdownOpen.value
                          ? Icon(Icons.arrow_right ,size: 28.sp,)
                          : Icon(Icons.arrow_drop_down,size: 28.sp),
                      onPressed: () => controller.toggleDropdown(),
                    )),
                    Text('Company' , style: TextStyle(fontSize: 18.sp),),
                  ],
                ),
                // Obx(
                //   () => controller.state.isDropdownOpen.value
                //       ? DropdownButton<String>(
                //           value: controller.state.selectedItem.value,
                //           items: dropdownItems.map((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //           onChanged: (val) {
                //             controller.selectItem(
                //               val.toString(),
                //             );
                //           })
                //       : SizedBox(),
                // ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => IconButton(
                      icon: controller.state.isDropdownOpen.value
                          ? Icon(Icons.arrow_right ,size: 28.sp,)
                          : Icon(Icons.arrow_drop_down,size: 28.sp),
                      onPressed: () => controller.toggleDropdown(),
                    )),
                    Text('Category' , style: TextStyle(fontSize: 18.sp),),
                  ],
                ),
                Obx(
                  () => controller.state.isDropdownOpen.value
                      ?
                        Text('data')
    // DropdownButton<String>(
                      //     value: controller.state.selectedItem.value,
                      //     items: dropdownItems.map((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(value),
                      //       );
                      //     }).toList(),
                      //     onChanged: (val) {
                      //       controller.selectItem(
                      //         val.toString(),
                      //       );
                      //     })
                      : SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

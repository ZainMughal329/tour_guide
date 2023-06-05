
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../ReUsable/Components/app_bar.dart';
import 'controller.dart';
// import 'controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  // AppBar _buildAppBar() {
  //   return AppBar(
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //     title: Container(
  //       margin: EdgeInsets.only(left: 7.w, right: 7.w),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           SizedBox(
  //             width: 15.w,
  //             height: 12.h,
  //             child: Icon(
  //               Icons.sort_rounded,
  //               color: Colors.black,
  //               size: 28,
  //             ),
  //           ),
  //           Container(
  //             padding: EdgeInsets.only(top: 10.h),
  //             child: Text(
  //               'Search',
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ),
  //           GestureDetector(
  //             child: Container(
  //               padding: EdgeInsets.only(top: 10.h),
  //               height: 40.h,
  //               width: 40.w,
  //               child: Icon(
  //                 Icons.person_outline,
  //                 color: Colors.black,
  //                 size: 28,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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

                  // onChanged: (){},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: BuildAppBar(
          title: 'Search',
          icon1: Icons.sort_rounded,
          icon2: Icons.person_outline,
        ),
      ),
      // drawer: BuildDrawer.buildDrawer(context),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            _searchBarView(),
          ],
        ),
      ),
    );
  }
}

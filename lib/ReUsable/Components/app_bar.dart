
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

class BuildAppBar extends StatelessWidget {
  String title ;
  IconData icon1;
  IconData icon2;
  BuildAppBar({Key? key , required this.title , required this.icon1 , required this.icon2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: ()async{
              // Scaffold.of(context).openDrawer();
              await FirebaseAuth.instance.signOut();
              Get.offAllNamed(AppRoutes.SIGN_IN);
            },
            child: Tooltip(
              message: 'Drawer',
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 6),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon1,
                  size: 28,
                ),
              ),
            ),
          ),
          Text(
            title,

            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: () {

              // await ConfigStore.to.setFirstOpen(false);



            },
            child: Tooltip(
              message: 'LogOut',
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 6),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon2,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

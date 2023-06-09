import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/Components/app_colors.dart';
import 'package:tours_guide/ReUsable/Components/toast_info.dart';
import 'package:tours_guide/ReUsable/models/tourModel.dart';
import 'package:tours_guide/ReUsable/models/userModel.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import '../../../ReUsable/Components/app_bar.dart';
import '../../../ReUsable/Components/details.dart';
import '../../../ReUsable/Components/drawer.dart';
import 'controller.dart';

class catogeryScreenPage extends GetView<catogeryScreenController> {
  String catogery='';
  catogeryScreenPage({Key? key,required this.catogery}) : super(key: key);
   catogeryScreenController controller = Get.put(catogeryScreenController());




  Widget _buildCard(BuildContext context, String title, String loc,
      String price, String des, String imageUrl) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: InkWell(
        onTap: () {
          Get.to(
                () =>
                DetailScreen(
                    title: title,
                    price: price,
                    location: loc,
                    des: des,
                    img: imageUrl),
          );
        },
        child: Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                      ),
                    ],
                    border: Border.all(width: 0.9, color: Colors.black)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                    height: 300.h,
                    width: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${price}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '/Person',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 45,
                left: 10,
                child: Container(
                  width: 100,
                  alignment: Alignment.topRight,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      FaIcon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 17.sp,
                      ),
                      Text(
                        " " + loc,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.arrowUpRightFromSquare,
                    ),
                    color: Colors.grey,
                    onPressed: () {
                      // Perform arrow button action here
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
      controller.setTourRef(catogery);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(catogery,style: TextStyle(fontSize: 30.sp),),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.withOpacity(0.9),

      drawer: BuildDrawer.buildDrawer(context),
      body: SafeArea(
        child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.state.fireStoreTourRef,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("inside first circle");
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                print("inside 2nd circle");
                return Center(child: CircularProgressIndicator());
              }
              print(snapshot.data!.docs.length.toString());
              return snapshot.data!.docs.length != 0
                  ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.all(10.h),
                      child: Column(
                        children: [


                          _buildCard(
                            context,
                            snapshot.data!.docs[index]['title']
                                .toString(),
                            snapshot.data!.docs[index]['location']
                                .toString(),
                            snapshot.data!.docs[index]['price']
                                .toString(),
                            snapshot.data!.docs[index]['tourDescription']
                                .toString(),
                            snapshot.data!.docs[index]['tourImage']
                                .toString(),
                          ),
                        ],
                      ),
                    );
                  })
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Center(
                      child: Text(
                        'Currently,We have no tours in\nthis Catogery',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ],
              );
              ;
            } catch (e) {
              return Text(
                'data : ' + e.toString(),
              );
            }
          },
        ),)));

  }


}
// _buildCard("Naran Kaghan","Peshawar","200",'assets/images/pic1.jpg')

//

// -----------------------

// ListView.builder(
//   physics: NeverScrollableScrollPhysics(),
//   shrinkWrap: true,
//   itemCount: 6,
//   itemBuilder: (BuildContext context, int index) {
//     return Padding(
//       padding: EdgeInsets.all(15),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailScreen(),
//                 ),
//               );
//             },
//             child: Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(15),
//                 image: DecorationImage(
//                     image: AssetImage(
//                         'assets/images/pic${index + 1}.jpg'),
//                     fit: BoxFit.cover,
//                     opacity: 0.7),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'City Name',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Icon(
//                   Icons.more_vert,
//                   size: 30,
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Row(
//             children: [
//               Icon(
//                 Icons.star,
//                 color: Colors.amber,
//                 size: 20,
//               ),
//               Text(
//                 '4.5',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   },
// ),

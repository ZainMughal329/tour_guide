import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../ReUsable/Components/app_bar.dart';

class TourDetailScreen extends StatelessWidget {
  final String loc;
  final String img;
  final String price;
  final String people;
  final String category;
  final String des;

  const TourDetailScreen(
      {Key? key,
      required this.img,
      required this.loc,
      required this.price,
      required this.people,
      required this.category,
      required this.des})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
            ),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back,
                        size: 30, color: Colors.black54)),
                Expanded(
                  child: Container(),
                ),
                Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[500],
                    border: Border.all(color: Colors.black, width: 2.0.w),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Icon(
                        Icons.person_outline,
                        size: 30,
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  width: 20.w,
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            height: 270.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
          PostBottomBar(
              loc: loc,
              price: price,
              people: people,
              category: category,
              des: des),
        ],
      ),
    ));
  }
}

class PostBottomBar extends StatelessWidget {
  final String loc;
  final String price;
  final String people;
  final String category;
  final String des;

  const PostBottomBar(
      {Key? key,
      required this.loc,
      required this.price,
      required this.people,
      required this.category,
      required this.des})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
      height: 340.h,
      decoration: BoxDecoration(
        color: Color(0xFFEDE2E6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' Location:${loc}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 25,
                        ),
                        Text(
                          '4.5',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category : ${category}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'TourPrice : ${price}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Tour Description : ${des}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Container(
                  height: 80.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black54, blurRadius: 4),
                          ],
                        ),
                        child: Icon(
                          Icons.bookmark_border_outlined,
                          size: 30,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 25.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          'Book Now',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   // splashWQu (1:2)
    //   padding:  EdgeInsets.fromLTRB(76.74.w, 333.58.h, 47.26.w, 44.42.h),
    //   // padding: ,
    //   width:  double.infinity,
    //   decoration:  BoxDecoration (
    //     color:  Color(0xffffffff),
    //     image:  DecorationImage (
    //       fit:  BoxFit.cover,
    //       image:  AssetImage('assets/images/welcome.jpg'),
    //     ),
    //   ),
    //   child:
    //   Material(
    //     color: Colors.transparent,
    //     child: Column(
    //       crossAxisAlignment:  CrossAxisAlignment.center,
    //       children:  [
    //         Container(
    //           // exploreyourfavouritejourneyMwK (1:7)
    //           margin:  EdgeInsets.fromLTRB(0, 0, 0, 18),
    //           constraints:  BoxConstraints (
    //             maxWidth:  800,
    //           ),
    //           child:
    //           Text(
    //             'Explore Your\nFavourite Journey',
    //             textAlign:  TextAlign.center,
    //             style:  TextStyle (
    //               // 'Jaldi',
    //               fontSize:  28,
    //               fontWeight:  FontWeight.bold,
    //               // height:  1.06497831,
    //               color:  Color(0xfff5f5f5),
    //             ),
    //           ),
    //         ),
    //         Container(
    //           // letsmakeourlifesolifep4D (1:8)
    //           margin:  EdgeInsets.fromLTRB(0, 0, 8, 114),
    //           child:
    //           Text(
    //             'Let’s make our life so life',
    //             textAlign:  TextAlign.center,
    //             style:  TextStyle (
    //               // 'Jaldi',
    //               fontSize:  18,
    //               fontWeight:  FontWeight.w400,
    //               // height:  1.0649414062,
    //               color:  Color(0xfff5f5f5),
    //             ),
    //           ),
    //         ),
    //         Container(
    //           // autogroupypjzv7F (GE8DgMpaHGxS2nb15nypJZ)
    //           margin:  EdgeInsets.fromLTRB(98, 0, 98, 0),
    //           padding:  EdgeInsets.fromLTRB(6, 35, 7, 6),
    //           width:  double.infinity,
    //           decoration:  BoxDecoration (
    //             borderRadius:  BorderRadius.circular(39),
    //             gradient:  LinearGradient (
    //               begin:  Alignment(0, -1),
    //               end:  Alignment(0, 1),
    //               colors:  <Color>[Color(0x001ea39b), Color(0xff1ea39b)],
    //               stops:  <double>[0.078, 1],
    //             ),
    //           ),
    //           child:
    //           Column(
    //             crossAxisAlignment:  CrossAxisAlignment.center,
    //             children:  [
    //               Container(
    //                 // vector1x3w (1:12)
    //                 // margin:  EdgeInsets.fromLTRB(1, 0, 0, 15),
    //                 // padding: EdgeInsets.only(bottom: 25),
    //                 width:  18,
    //                 height:  9,
    //                 child:
    //                 Icon(Icons.keyboard_double_arrow_up,color: Colors.white, size: 20,)
    //               ),
    //               // Container(
    //               //   // vector2sRo (5:2)
    //               //   margin:  EdgeInsets.fromLTRB(1, 0, 0, 15),
    //               //   width:  18,
    //               //   height:  9,
    //               //   child:
    //               //   Image.network(
    //               //     [Image url]
    //               //     width:  18*fem,
    //               //     height:  9*fem,
    //               //   ),
    //               // ),
    //               Container(
    //                 // autogroupgue112D (GE8DuSH7qKYcBbzj2DgUe1)
    //                 width:  double.infinity,
    //                 height:  65,
    //                 decoration:  BoxDecoration (
    //                   color:  Color(0x7f000000),
    //                   borderRadius:  BorderRadius.circular(32.5),
    //                 ),
    //                 child:
    //                 Center(
    //                   child:
    //                   Text(
    //                     'Go',
    //                     textAlign:  TextAlign.center,
    //                     style:  TextStyle (
    //                       // 'Jaldi',
    //                       fontSize:  25,
    //                       fontWeight:  FontWeight.w400,
    //                       height:  1.0649414062,
    //                       color:  Color(0xffffffff),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/welcome.jpg',
            ),
            fit: BoxFit.cover,
            opacity: 0.7),
      ),
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 65.h, horizontal: 15.w),
            // child: Column(
            //   children: [
            //     Expanded(child: Container()),
            //     Expanded(
            //       child: Column(
            //         // crossAxisAlignment: CrossAxisAlignment.center,
            //         // mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             'Explore Your\nFavorite Journey',
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 30),
            //           ),
            //           SizedBox(
            //             height: 15.h,
            //           ),
            //           Text(
            //             'Let\'s make our life so a life',
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w300,
            //                 fontSize: 17),
            //           ),
            //           SizedBox(height: 10.h,),
            //           Positioned(
            //             // bottom: 0,
            //             // top:0,
            //             child: Container(
            //               height: 120.h,
            //               width: 73.w,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.all(Radius.circular(50),),
            //                 color: Color(0xff3eaab7),
            //               ),
            //             ),
            //           ),
            //           Positioned(
            //             child: Container(
            //               height: 50.h,
            //               width: 50.w,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(50),
            //                 color: Colors.black.withOpacity(0.2),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            child: Padding(
              padding: EdgeInsets.only(top: 280.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Explore Your\nFavourite Journey',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 2,
                  // ),
                  // Text(
                  //   'the world!',
                  //   style: TextStyle(
                  //       color: Colors.white.withOpacity(0.9),
                  //       fontSize: 35,
                  //       fontWeight: FontWeight.w400,
                  //       letterSpacing: 1.5),
                  // ),
                  SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Text(
                      'Life is all about enjoyment.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        // controller.handleSignIn();
                      },
                      child: Container(
                        height: 127.h,
                        width: 66.w,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff1EA49C).withOpacity(0),
                                Color(0xff1EA49C).withOpacity(1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              // stops: [
                              //   10.0,
                              //   100.0,
                              // ]
                            ),
                            borderRadius: BorderRadius.circular(40)),
                        child: Stack(
                          children: [

                            Column(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 40,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                        color: Color(0xff000000).withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(50)),
                                    child: Center(
                                        child: Text(
                                          'Go',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            RotatedBox(
                              quarterTurns: 3,
                              child: Obx((){
                                return Slider(
                                  value: controller.state.value.value,
                                  onChanged: (val){
                                    controller.state.value.value= val;
                                  },
                                  thumbColor: Colors.black.withOpacity(0.0),
                                  activeColor: Colors.black.withOpacity(0.0),
                                  inactiveColor: Colors.black.withOpacity(0.0),
                                  secondaryActiveColor: Colors.black.withOpacity(0.0),
                                  onChangeEnd: (newvalue){
                                    print("End edge value" + newvalue.toString());
                                    if(newvalue==1.0){
                                      controller.handleSignIn();
                                    }
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

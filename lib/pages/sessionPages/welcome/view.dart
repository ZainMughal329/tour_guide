import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                              return Padding(
                                padding:  EdgeInsets.only(left: 10.h),
                                child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20), // Adjust the value as needed
                                ),
                                child: Slider(
                                  value: controller.state.value.value,
                                  onChanged: (val){
                                    controller.state.value.value= val;
                                  },
                                  thumbColor: Colors.black.withOpacity(0.0),
                                  activeColor: Colors.white.withOpacity(0.0),
                                  inactiveColor: Colors.white.withOpacity(0.0),
                                  secondaryActiveColor: Colors.white.withOpacity(1),
                                  onChangeEnd: (newValue){
                                    print("End edge value" + newValue.toString());
                                    if(newValue==1.0){
                                      controller.handleSignIn();
                                    }
                                  },
                                )),
                              );
                            }),
                          ),
                        ],
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

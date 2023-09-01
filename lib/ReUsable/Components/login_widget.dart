import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';


Widget LoginWidget(CountryCode code, Function changeCountry,TextEditingController phone) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.kPrimaryLightColor,
            borderRadius: BorderRadius.circular(29),

          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: GestureDetector(
                    onTap: () => changeCountry(),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            child: code.flagImage(),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        TextWidget(
                          text: code.dialCode.toString(),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black.withOpacity(0.4),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                width: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    decoration: InputDecoration(
                      // hintStyle: TextStyle(
                      //     fontWeight: FontWeight.normal, fontSize: 12),
                      border: InputBorder.none,
                      hintText: 'Enter number',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget TextWidget({
  required String text,
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
  );
}
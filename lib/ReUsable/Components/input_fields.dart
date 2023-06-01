import 'package:flutter/material.dart';

class TextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  IconData icon;

   TextField({Key? key,required this.controller,required this.hintText,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 50),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon),
          labelText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white12,

            )
          )
        ),

      ),
    );
  }
}

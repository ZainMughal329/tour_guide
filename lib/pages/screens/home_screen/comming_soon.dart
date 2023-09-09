import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommingSoon extends StatelessWidget {
  Color color;
  String title;
  CommingSoon({this.color = Colors.orange , this.title = 'Tour App'});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to our Tour App!',
              style: TextStyle(fontSize: 24),
            ),
            // "Coming Soon" Banner
            ComingSoonBanner(color: color,),
            // Your other app content goes here
          ],
        ),
      ),
    );
  }
}

class ComingSoonBanner extends StatelessWidget {
  Color color;
  ComingSoonBanner({this.color = Colors.orange});
  @override
  Widget build(BuildContext context ) {
    return Container(
      padding: EdgeInsets.all(16),
      color: color, // Customize the banner color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.alarm,
            color: Colors.white, // Customize the icon color
          ),
          SizedBox(width: 8),
          Text(
            'Coming Soon!',
            style: TextStyle(
              color: Colors.white, // Customize the text color
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

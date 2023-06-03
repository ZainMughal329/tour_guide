import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class CallFunction extends StatefulWidget {
  const CallFunction({Key? key}) : super(key: key);

  @override
  State<CallFunction> createState() => _CallFunctionState();
}

class _CallFunctionState extends State<CallFunction> {
  String x = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(child: Text(x)),
          TextButton(
              onPressed: () async {
                final functions = FirebaseFunctions.instance;
                final result = await FirebaseFunctions.instance
                    .httpsCallable('helloWorld')
                    .call({
                  'name': 'zain',
                }).then((value) {
                  x = value.data.toString();
                  print(x);
                  setState(() {});
                  print("called");
                }).onError((error, stackTrace) {
                  print(error.toString());
                });
              },
              child: Text("Click to call me"))
        ],
      ))),
    );
  }
}

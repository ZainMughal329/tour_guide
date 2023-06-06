import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_guide/ReUsable/routes/names.dart';

import 'controller.dart';

class AdminHomePage extends GetView<AdminController> {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              final auth = FirebaseAuth.instance;
              auth.signOut().then((value) {
                Get.offAndToNamed(AppRoutes.SIGN_IN);
                Get.snackbar('Success', 'Logout success');
              }).onError((error, stackTrace) {
                Get.snackbar('Error', 'Something went wrong');
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.firestore,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              }
              return snapshot.data!.docs.length != 0
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0xffB0C3D9FF),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.person_outline),
                                  title: Text(
                                    snapshot.data!.docs[index]['CompanyEmail']
                                        .toString(),
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.docs[index]['CompanyName']
                                        .toString(),
                                  ),
                                  trailing: Text(
                                    snapshot.data!.docs[index]['companyPhone']
                                        .toString(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                snapshot.data!.docs[index]['status']
                                            .toString() ==
                                        'false'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller.deleteCompanyData(
                                                  snapshot.data!.docs[index].id
                                                      .toString());
                                            },
                                            child: Text('Decline'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              controller.updateCompanyData(
                                                  snapshot.data!.docs[index].id
                                                      .toString());
                                            },
                                            child: Text('Approve'),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        child: TextButton(
                                          onPressed: () async {},
                                          child: Text('Approved'),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      })
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'No new companies to approved',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    );
            } catch (e) {
              return Text(
                'data : ' + e.toString(),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
   String? id;
  final String companyName;

  final String companyEmail;

  final String companyPhone;

  final String companyDescription;

  final String status;

  final String pass;

  // final String status;

  CompanyModel({
    this.id='',
    required this.companyEmail,
    required this.companyName,
    required this.companyPhone,
    required this.companyDescription,
    required this.pass,
    this.status = 'notApproved'
  });

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "CompanyName": companyName,
      "CompanyEmail": companyEmail,
      "companyPhone": companyPhone,
      "companyDescription": companyDescription,
      "password" : pass,
      "status" : "notApproved"
    };
  }

  factory CompanyModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return CompanyModel(
      id: data["id"],
      companyEmail: data["companyEmail"],
      companyName: data["companyName"],
      companyPhone: data["companyPhone"],
      companyDescription: data["companyDescription"],
      status: data["status"],
      pass: data["password"],
    );
  }
}

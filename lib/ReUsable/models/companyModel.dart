import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  String id;
  final String companyName;

  final String companyEmail;

  final String companyPhone;

  final String companyDescription;

  final String? status;

  final String logo;

  final String pass;

  final String location;
  final String fcmToken;
  final Timestamp addTime;

  // final String status;

  CompanyModel({
    this.id = '',
    required this.companyEmail,
    required this.companyName,
    required this.companyPhone,
    required this.companyDescription,
    required this.logo,
    required this.pass,
    this.status,
    required this.location,
    required this.addTime,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "CompanyName": companyName,
      "CompanyEmail": companyEmail,
      "companyPhone": companyPhone,
      "logo": logo,
      "companyDescription": companyDescription,
      "password": pass,
      "id": id,
      "status": "false",
      "location": location,
      "fcmToken": fcmToken,
      "addTime": addTime,
    };
  }

  factory CompanyModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return CompanyModel(
      id: data["id"],
      companyEmail: data["CompanyEmail"],
      companyName: data["CompanyName"],
      logo: data["logo"],
      companyPhone: data["companyPhone"],
      companyDescription: data["companyDescription"],
      status: data["status"],
      pass: data["password"],
      location: data["location"],
      fcmToken: data["fcmToken"],
      addTime: data["addTime"],
    );
  }
}

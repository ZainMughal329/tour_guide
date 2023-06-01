import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  final String? id;
  final String companyName;

  final String companyEmail;

  final String companyPhone;

  final String companyDescription;

  CompanyModel({
    this.id,
    required this.companyEmail,
    required this.companyName,
    required this.companyPhone,
    required this.companyDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      "CompanyName": companyName,
      "CompanyEmail": companyEmail,
      "companyPhone": companyPhone,
      "companyDescription": companyDescription,
    };
  }

  factory CompanyModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return CompanyModel(
      id: snapshot.id,
      companyEmail: data["companyEmail"],
      companyName: data["companyName"],
      companyPhone: data["companyPhone"],
      companyDescription: data["companyDescription"],
    );
  }
}

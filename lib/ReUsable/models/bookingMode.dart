import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BookingModel {
  String? uid;
  String? name;
  String? phoneNumber;
  String? CompanyName;
  String? CompanyId;
  String? tourTitle;
  String? tourId;
  String? pricePerPerson;
  String? tourImage;

  BookingModel({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.CompanyName,
    required this.CompanyId,
    required this.tourTitle,
    required this.tourId,
    required this.pricePerPerson,
    required this.tourImage,
  });

  Map<String , dynamic> toJson(){
    return {
      "uid" : uid,
      "name" : name,
      "phoneNumber" : phoneNumber,
      "CompanyName" : CompanyName,
      "CompanyId" : CompanyId,
      "tourId" : tourId,
      "tourTitle" : tourTitle,
      "pricePerPerson" : pricePerPerson,
      "tourImage" : tourImage,
    };
  }

  factory BookingModel.fromJson(
      DocumentSnapshot<Map<String,dynamic>> snapshot
      ){
    final data=snapshot.data()!;
    return BookingModel(
        uid: data['uid'],
        name: data['name'],
        phoneNumber: data['phoneNumber'],
        CompanyName: data['CompanyName'],
        CompanyId: data['CompanyId'],
        tourTitle: data['tourTitle'],
        tourId: data['tourId'],
        pricePerPerson: data['pricePerPerson'],
        tourImage: data['tourImage'],
    );
  }

}

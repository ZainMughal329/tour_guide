import 'package:cloud_firestore/cloud_firestore.dart';

class TourModel {
  final String? id;
  final String title;
  final String location;

  final String tourDescription;

  final String tourCategory;

  final String people;

  final String price;

  // final String tourRating;

  final String tourImage;

  final String? companyPhone;
  final String? companyId;
  final String? companyName;
  bool isFavourite;

  TourModel({
    required this.id,
    required this.title,
    required this.tourCategory,
    required this.tourDescription,
    required this.tourImage,
    required this.location,
    this.isFavourite = false,
    required this.people,
    required this.price,
    this.companyPhone,
    required this.companyId,
    required this.companyName,
  });

  Map<String, dynamic> toJson() {
    return {
      "tourCategory": tourCategory,
      "tourDescription": tourDescription,
      "title": title,
      "location": location,
      // "tourRating": tourRating,
      'id': id,
      "tourImage": tourImage,
      "price": price,
      "people": people,
      "companyPhone": companyPhone,
      "companyId" : companyId,
      "companyName" : companyName,
      "isFavourite" : false,
    };
  }

  factory TourModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return TourModel(
      id: data["id"],
      tourCategory: data["tourCategory"],
      tourDescription: data["tourDescription"],
      tourImage: data["tourImage"],
      title: data["title"],
      isFavourite: data["isFavourite"],
      location: data["location"],
      people: data["people"],
      price: data["price"],
      companyPhone: data["companyPhone"],
      companyId: data["companyId"],
      companyName: data["companyName"],
    );
  }
}

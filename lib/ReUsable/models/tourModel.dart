import 'package:cloud_firestore/cloud_firestore.dart';

class TourModel {
  final String? id;
  final String tourCityName;
  final String tourCountryName;

  final String tourDescription;

  final String tourCategory;

  final String people;

  final String price;

  final String tourRating;

  final String tourImages;

  TourModel({
    this.id,
    required this.tourCountryName,
    required this.tourCategory,
    required this.tourDescription,
    required this.tourImages,
    required this.tourCityName,
    required this.tourRating,
    required this.people,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "tourCategory": tourCategory,
      "tourDescription": tourDescription,
      "tourCityName": tourCityName,
      "tourCountryName": tourCountryName,
      "tourRating": tourRating,
      "tourImages": tourImages,
      "price": price,
      "people": people,
    };
  }

  factory TourModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return TourModel(
      id: snapshot.id,
      tourCategory: data["tourCategory"],
      tourDescription: data["tourDescription"],
      tourImages: data["tourImages"],
      tourCityName: data["tourCityName"],
      tourRating: data["tourRating"],
      tourCountryName: data["tourCountryName"],
      people: data["people"],
      price: data["price"],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class TourModel {
  final String? id;
  final String tourName;

  final String tourDescription;

  final String tourCategory;

  final String tourRating;

  final String tourImages;

  TourModel(
      {this.id,
      required this.tourCategory,
      required this.tourDescription,
      required this.tourImages,
      required this.tourName,
      required this.tourRating});

  Map<String, dynamic> toJson() {
    return {
      "tourCategory": tourCategory,
      "tourDescription": tourDescription,
      "tourName": tourName,
      "tourRating": tourRating,
      "tourImages": tourImages,
    };
  }

  factory TourModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return TourModel(
      id: snapshot.id,
      tourCategory: data["tourCategory"],
      tourDescription: data["tourDescription"],
      tourImages: data["tourImages"],
      tourName: data["tourName"],
      tourRating: data["tourRating"],
    );
  }
}

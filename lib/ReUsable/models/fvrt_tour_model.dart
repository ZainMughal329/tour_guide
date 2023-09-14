// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class FvrtTourModel {
//   final String? id;
//   final String title;
//   final String location;
//
//   final String tourDescription;
//
//
//
//   final String price;
//
//   // final String tourRating;
//
//   final String tourImage;
//
//   final String? companyPhone;
//   final String? companyId;
//   final String? companyName;
//   bool isFavourite;
//
//   FvrtTourModel({
//     required this.id,
//     required this.title,
//     required this.tourDescription,
//     required this.tourImage,
//     required this.location,
//     this.isFavourite = true,
//     required this.price,
//     this.companyPhone,
//     required this.companyId,
//     required this.companyName,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       "tourDescription": tourDescription,
//       "title": title,
//       "location": location,
//       // "tourRating": tourRating,
//       'id': id,
//       "tourImage": tourImage,
//       "price": price,
//       "companyPhone": companyPhone,
//       "companyId" : companyId,
//       "companyName" : companyName,
//       "isFavourite" : true,
//     };
//   }
//
//   factory FvrtTourModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot) {
//     final data = snapshot.data()!;
//     return FvrtTourModel(
//       id: data["id"],
//       tourDescription: data["tourDescription"],
//       tourImage: data["tourImage"],
//       title: data["title"],
//       isFavourite: data["isFavourite"],
//       location: data["location"],
//       price: data["price"],
//       companyPhone: data["companyPhone"],
//       companyId: data["companyId"],
//       companyName: data["companyName"],
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
   String? id;
  final String userName;
  final String phone;
  final String email;
  final String? password;
  final String photoUrl;

   final String location;
   final String fcmToken;
   final Timestamp addTime;

  UserModel(
      {this.id='',
      required this.userName,
      required this.phone,
      required this.email,
      this.password,
        required this.location,
      required this.photoUrl,
      required this.fcmToken,
        required this.addTime,
      });

  toJson() {
    return {
      'id': id,
      'userName': userName,
      'phone': phone,
      'email': email,
      'password': password,
      'photoUrl': photoUrl,
      'location' : location,
      'fcmToken' : fcmToken,
      'addTime' : addTime,
    };
  }

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final json = snapshot.data()!;
    return UserModel(
      id: json["id"],
      userName: json["userName"],
      phone: json["phone"],
      password: json["password"],
      email: json["email"],
      photoUrl: json["photoUrl"],
      location: json["location"],
      fcmToken: json["fcmToken"],
      addTime: json["addTime"],
    );
  }
}

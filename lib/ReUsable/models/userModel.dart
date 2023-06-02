
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String userName;
  final String phone;
  final String email;
  final String? password;
  final String photoUrl;

  UserModel(
      {this.id,
      required this.userName,
      required this.phone,
      required this.email,
      this.password,
      required this.photoUrl});

  toJson() {
    return {
      'userName': userName,
      'phone': phone,
      'email': email,
      'password': password,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final json = snapshot.data()!;
    return UserModel(
      id: snapshot.id,
      userName: json["userName"],
      phone: json["phone"],
      password: json["password"],
      email: json["email"],
      photoUrl: json["photoUrl"],
    );
  }
}

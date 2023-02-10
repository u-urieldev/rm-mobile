import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  AppUser({
    required this.name,
    required this.uid,
    required this.email,
    required this.cards,
    required this.friends,
    required this.requests,
    required this.gifts,
    required this.profile_image,
  });

  String uid;
  String name;
  String email;
  List<String> cards;
  List<String> friends;
  List<String> requests;
  List<Map<String, dynamic>> gifts;
  String profile_image;

  Map<String, dynamic> toMap() => {
        "name": name,
        "uid": uid,
        "email": email,
        "cards": cards,
        "friends": friends,
        "requests": requests,
        "gifts": gifts,
        "profile_image": profile_image
      };

  factory AppUser.fromDocSnapshot(DocumentSnapshot snapshot) {
    final json = snapshot as Map<String, dynamic>;
    return AppUser.fromMap(json);
  }

  factory AppUser.fromMap(Map<String, dynamic> json) => AppUser(
      name: json['name'],
      uid: json["uid"],
      email: json['email'],
      cards: List<String>.from(json['cards'].map((x) => x)),
      friends: List<String>.from(json['friends'].map((x) => x)),
      requests: List<String>.from(json['requests'].map((x) => x)),
      gifts: List<Map<String, dynamic>>.from(json['gifts']),
      profile_image: json['profile_image']);
}

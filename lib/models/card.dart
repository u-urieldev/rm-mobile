import 'package:insults_album/models/app_user.dart';

class AppCard {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? gender;
  final String? origin;
  final String? location;
  final String? image;
  final List<dynamic>? episodes;
  final bool isGift;
  final AppUser? sender;

  AppCard({
    this.id,
    this.name,
    this.status,
    this.species,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episodes,
    required this.isGift,
    this.sender,
  });

  factory AppCard.fromJson(Map<String, dynamic> json) {
    return AppCard(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      origin: json['origin'],
      location: json['location'],
      image: json['image'],
      isGift: json['isGift'],
      sender: json['sender'],
      episodes: json['episode'],
    );
  }
}

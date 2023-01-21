import 'package:cloud_firestore/cloud_firestore.dart';

class Episode {
  final int id;
  final String? name;
  final String? air_date;
  final List<String>? episode;
  final String? characters;
  final String? url;
  final String? created;

  Episode({
    required this.id,
    this.name,
    this.air_date,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  factory Episode.fromDocSnapshot(DocumentSnapshot snapshot) {
    final json = snapshot as Map<String, dynamic>;
    return Episode.fromMap(json);
  }

  factory Episode.fromMap(Map<String, dynamic> json) {
    return Episode(
        id: json['id'],
        name: json['name'],
        air_date: json['air_date'],
        episode: json['episode'],
        characters: json['characters'],
        url: json['url'],
        created: json['created']);
  }
}

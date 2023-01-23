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
      episodes: json['episode'],
    );
  }
}

class Insult {
  final String number;
  final String? language;
  final String insult;
  final String? created;
  final String? shown;
  final String? active;
  final String? comment;

  const Insult(
      {required this.number,
      this.language,
      required this.insult,
      this.created,
      this.shown,
      this.active,
      this.comment});

  factory Insult.fromJson(Map<String, dynamic> json) {
    return Insult(
      number: json['number'] ?? "",
      language: json['language'],
      insult: json['insult'] ?? "",
      created: json['created'],
      shown: json['shown'],
      active: json['active'],
      comment: json['comment'],
    );
  }
}

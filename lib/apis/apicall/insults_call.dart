import '../models/insults_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Insult> fetchInsult() async {
  final response = await http.get(Uri.parse(
      'https://evilinsult.com/generate_insult.php?lang=en&type=json'));

  if (response.statusCode == 200) {
    return Insult.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load insult');
  }
}

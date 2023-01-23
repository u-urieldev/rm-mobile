import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/card.dart';

class CardsService {
  static Future fetchCard(String cardId) async {
    try {
      final headers = {"Content-Type": "application/json"};
      final url = Uri.parse('http://localhost:3000/api/cards/get_card/$cardId');
      final response = await http.get(url, headers: headers);
      AppCard card;

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        card = AppCard.fromJson(responseBody['card']);

        return card;
      }
      return "error";
    } catch (e) {
      print(e);
    }
  }

  static Future addCard(String uid, String cardId) async {
    try {
      final headers = {"Content-Type": "application/json"};
      final url = Uri.parse(
          'http://localhost:3000/api/cards/add_card/${uid}?card_id=$cardId');
      final response = await http.put(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        print(responseBody['status']);

        return responseBody['status'];
      }

      return "error";
    } catch (e) {
      print(e);
    }
  }
}

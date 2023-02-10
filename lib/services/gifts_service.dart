import 'dart:convert';
import 'package:http/http.dart' as http;

class GiftService {
  static Future acceptGift(
      String meUid, String friend_uid, String cardId) async {
    try {
      final headers = {"Content-Type": "application/json"};
      final body = json.encode({"friendUid": friend_uid, "card": cardId});
      final url =
          Uri.parse('http://localhost:3000/api/gifts/accept_gift/$meUid');
      final response = await http.put(url, headers: headers, body: body);

      final Map<String, dynamic> responseBody = json.decode(response.body);

      //Parsear respuesta
      if (response.statusCode == 200) {
        return 'exito'; //["msg"];
      }

      //Si se llega a este punto hubo un error en el request, mostrar errores en terminal
      return 'error';
      //print(responseBody);
    } catch (e) {
      print("Error: $e");
    }
  }
}

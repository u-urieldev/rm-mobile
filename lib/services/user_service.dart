import '../models/app_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static Future changeName(AppUser user, String newName) async {
    try {
      final headers = {"Content-Type": "application/json"};
      final url = Uri.parse(
          'http://localhost:3000/api/users/change_name/${user.uid}/$newName');
      final response = await http.put(url, headers: headers);

      print(response.statusCode);

      final Map<String, dynamic> responseBody = json.decode(response.body);
      //Parsear respuesta
      if (response.statusCode == 200) {
        return responseBody['status']; //["msg"];
      }

      //Si se llega a este punto hubo un error en el request, mostrar errores en terminal
      print(responseBody);
    } catch (e) {
      print("Error: $e");
    }
  }
}

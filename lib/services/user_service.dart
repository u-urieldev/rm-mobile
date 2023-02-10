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

  static Future changePhoto(AppUser user, String newPhoto) async {
    try {
      final headers = {"Content-Type": "application/json"};
      final body = json.encode({"photo_url": newPhoto});
      final url =
          Uri.parse('http://localhost:3000/api/users/change_photo/${user.uid}');
      final response = await http.put(url, headers: headers, body: body);

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

  static Future getUser(String uid) async {
    try {
      final headers = {"Content-Type": "application/json"};
      final url = Uri.parse('http://localhost:3000/api/users/get_user/$uid');
      final response = await http.get(url, headers: headers);

      final Map<String, dynamic> responseBody = json.decode(response.body);

      //Parsear respuesta
      if (response.statusCode == 200) {
        return AppUser.fromMap(responseBody['user']); //["msg"];
      }

      //Si se llega a este punto hubo un error en el request, mostrar errores en terminal
      //print(responseBody);
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future getUserByName(String name) async {
    try {
      print(name);
      final headers = {"Content-Type": "application/json"};
      final url =
          Uri.parse('http://localhost:3000/api/users/get_user_name/$name');
      final response = await http.get(url, headers: headers);

      // Usuario no encontrado
      if (response.statusCode == 204) {
        return 'error'; //["msg"];
      }

      final Map<String, dynamic> responseBody = json.decode(response.body);

      //Parsear respuesta
      if (response.statusCode == 200) {
        return AppUser.fromMap(responseBody['user']); //["msg"];
      }

      return 'error';
      //Si se llega a este punto hubo un error en el request, mostrar errores en terminal
      //print(responseBody);
    } catch (e) {
      print("Error: $e");
    }
  }
}

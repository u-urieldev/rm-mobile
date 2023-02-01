import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:insults_album/models/app_user.dart';

class FriendsService {
  static Future sendRequest(String meUid, String friend_uid) async {
    try {
      final headers = {"Content-Type": "application/json"};
      final body = json.encode({"friend_uid": friend_uid});
      final url =
          Uri.parse('http://localhost:3000/api/friends/add_request/$meUid');
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

  static Future aceptRequest(String meUid, String friend_uid) async {
    try {
      final headers = {"Content-Type": "application/json"};
      final body = json.encode({"friendUid": friend_uid});
      final url =
          Uri.parse('http://localhost:3000/api/friends/acept_request/$meUid');
      final response = await http.put(url, headers: headers, body: body);

      final Map<String, dynamic> responseBody = json.decode(response.body);

      print(responseBody['msg']);
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

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import '../models/card.dart';
import 'dart:convert';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  String emailText = "";
  String passwordText = "";
  String nameText = "";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    //fetchCharacter();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                emailText = value;
              },
            ),
            TextField(onChanged: (value) {
              passwordText = value;
            }),
            TextField(onChanged: (value) {
              nameText = value;
            }),
            ElevatedButton(
              onPressed: () async {
                final response =
                    await authProvider.login(emailText, passwordText);

                if (response != "exito") {
                  print("Error: $response");
                  return;
                }

                print("Login hecho");

                // Move to the next screen
                Navigator.pushNamed(context, '/cards');
              },
              child: const Text("Login"),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await authProvider.createUser(
                    emailText, passwordText, nameText);

                if (response != "exito") {
                  print("Error: $response");
                  return;
                }

                print("Usuario creado correctamente");

                // Move to the next screen
                Navigator.pushNamed(context, '/cards');
              },
              child: const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}

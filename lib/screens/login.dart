import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  String emailText = "";
  String passText = "";

  @override
  Widget build(BuildContext context) {
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
              passText = value;
            }),
            ElevatedButton(
              onPressed: () {
                print(emailText);
                print(passText);
              },
              child: const Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                print(emailText);
                print(passText);
              },
              child: const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}

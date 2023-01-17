import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String emailText = "";
  String passwordText = "";
  String nameText = "";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'rm-img',
              transitionOnUserGestures: true,
              child: Image.network(
                'https://1000marcas.net/wp-content/uploads/2022/04/Rick-and-Morty.png',
              ),
            ),
            const SizedBox(height: 10),
            // ---     E-mail    ---
            CustomTextField(
              icon: Icons.email_outlined,
              label: 'E-mail',
              controller: (value) => emailText = value,
            ),
            const SizedBox(height: 10),
            // ---    Password    ---
            CustomTextField(
              icon: Icons.password_outlined,
              label: 'Password',
              controller: (value) => passwordText = value,
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 90),
            Hero(
              tag: 'log-in-b',
              transitionOnUserGestures: true,
              child: CustomButton(
                label: const Text('Log In'),
                action: () async {
                  final response =
                      await authProvider.login(emailText, passwordText);

                  if (response != "exito") {
                    print("Error: $response");
                    return;
                  }

                  print("Login hecho correctamente");

                  // Move to the next screen
                  Navigator.pushNamed(context, '/cards');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

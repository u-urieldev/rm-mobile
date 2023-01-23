import 'package:flutter/material.dart';
import '../../widgets/custom/custom_button.dart';
import '../../widgets/custom/custom_text_field.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/loading_providers.dart';
import '../../widgets/custom/waiting_indicator.dart';
import '../../constans/helpers.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  String emailText = "";
  String passwordText = "";
  String nameText = "";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: loadingProvider.isWaiting
          ? const WaitingIndicator()
          : Padding(
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
                  // ---    Username    ---
                  CustomTextField(
                    icon: Icons.account_circle_outlined,
                    label: 'Username',
                    controller: (value) => nameText = value,
                  ),
                  const SizedBox(height: 90),
                  Hero(
                    tag: 'log-in-b',
                    transitionOnUserGestures: true,
                    child: CustomButton(
                      label: const Text('Sing Up'),
                      action: () async {
                        loadingProvider.isWaiting = true;
                        final response = await authProvider.createUser(
                            emailText, passwordText, nameText);

                        if (response != "exito") {
                          print("Error: $response");
                          loadingProvider.isWaiting = false;

                          CustomHelpers.showCustomSnackBar(context,
                              "Error al registrarse", response, Colors.red);
                          return;
                        }

                        // Move to the next screen
                        Navigator.pushNamed(context, '/cards');
                        loadingProvider.isWaiting = false;
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

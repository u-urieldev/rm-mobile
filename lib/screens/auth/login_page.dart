import 'package:flutter/material.dart';
import 'package:insults_album/providers/loading_providers.dart';
import '../../widgets/custom/custom_button.dart';
import '../../widgets/custom/custom_text_field.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom/waiting_indicator.dart';
import '../../constans/helpers.dart';
import '../../providers/profile_images_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String emailText = "";
  String passwordText = "";
  String nameText = "";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final profileImageProvider = Provider.of<ProfileImagesProvider>(context);

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
                  const SizedBox(height: 100),
                  Hero(
                    tag: 'log-in-b',
                    transitionOnUserGestures: true,
                    child: CustomButton(
                      label: const Text('Log In'),
                      action: () async {
                        loadingProvider.isWaiting = true;
                        final response =
                            await authProvider.login(emailText, passwordText);

                        if (response != "exito") {
                          print("Error: $response");
                          loadingProvider.isWaiting = false;
                          CustomHelpers.showCustomSnackBar(context,
                              "Erro al hacer login", response, Colors.red);

                          await profileImageProvider
                              .fetchImages(authProvider.currentUser!.cards);
                          return;
                        }
                        await profileImageProvider
                            .fetchImages(authProvider.currentUser!.cards);
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

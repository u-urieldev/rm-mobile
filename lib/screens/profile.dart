import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/user_service.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  String nameValue = "";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => nameValue = value,
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await UserService.changeName(
                    authProvider.currentUser!, nameValue);

                //TODO: Modiicar el provider de user
                if (response != null) {
                  print("no null: $response");
                }
              },
              child: const Text("Change Name"),
            ),
          ],
        ));
  }
}

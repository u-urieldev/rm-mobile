import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../constans/custom_colors.dart';
import '../profile_image/profile_image.dart';
import 'custom_menu_list_title.dart';
import '../../providers/loading_providers.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);

    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
                width: double.infinity,
                height: double.infinity,
                color: CustomColors.kBlue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    const ProfileImage(),
                    const SizedBox(height: 17),
                    Text(
                      authProvider.currentUser!.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                )),
          ),
          // ---    Parte de abajo    ---
          Expanded(
            flex: 7,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: CustomColors.kBlue,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    CustomMenuListTitle(
                      icon: Icons.account_circle_outlined,
                      text: "Profile",
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                    ),
                    CustomMenuListTitle(
                      icon: Icons.people_outline,
                      text: "Friends",
                      onTap: () => print('Friends'),
                    ),
                    CustomMenuListTitle(
                      icon: Icons.mail_outline,
                      text: "Requests",
                      onTap: () => print('Requests'),
                    ),
                    const SizedBox(height: 300),
                    ListTile(
                        leading: const Icon(
                          Icons.logout_outlined,
                          color: Colors.red,
                        ),
                        title: const Text(
                          'Log Out',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          loadingProvider.isSingOut = true;
                          Navigator.pushNamed(context, '/');
                        })
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

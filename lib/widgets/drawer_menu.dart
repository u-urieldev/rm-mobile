import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../constans/custom_colors.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(
                            authProvider.currentUser!.profile_image),
                      ),
                    ),
                    const SizedBox(height: 17),
                    Text(
                      authProvider.currentUser!.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                )),
          ),
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
                  children: const [
                    SizedBox(height: 15),
                    CustomMenuListTitle(
                      icon: Icons.account_circle_outlined,
                      text: "Profile",
                    ),
                    CustomMenuListTitle(
                      icon: Icons.people_outline,
                      text: "Friends",
                    ),
                    CustomMenuListTitle(
                      icon: Icons.mail_outline,
                      text: "Requests",
                    ),
                    SizedBox(
                      height: 280,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Log Out',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
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

class CustomMenuListTitle extends StatelessWidget {
  const CustomMenuListTitle({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: CustomColors.kGreen,
      ),
      title: Text(
        text,
        style: const TextStyle(
            color: CustomColors.kBlue, fontWeight: FontWeight.bold),
      ),
    );
  }
}

//Text(authProvider.currentUser!.name),
// BorderRadius.vertical(bottom: Radius.circular(20))
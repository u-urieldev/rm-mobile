import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../constans/custom_colors.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return GestureDetector(
      onTap: () => print('picado pa'),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 52,
              backgroundColor: Colors.black,
              backgroundImage:
                  NetworkImage(authProvider.currentUser!.profile_image),
            ),
          ),
          const Positioned(
            top: 78,
            left: 76,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 16,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: CustomColors.kGreen,
                child: Icon(
                  Icons.add_photo_alternate,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:insults_album/constans/helpers.dart';
import 'package:insults_album/providers/auth_provider.dart';
import 'package:insults_album/providers/profile_images_provider.dart';
import 'package:insults_album/services/user_service.dart';
import 'package:insults_album/widgets/custom/custom_button.dart';
import 'package:insults_album/widgets/custom/dialog_layout.dart';
import 'package:provider/provider.dart';

class ChooseCardContent extends StatelessWidget {
  ChooseCardContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileImageProvider = Provider.of<ProfileImagesProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return DialogLayout(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: profileImageProvider.imageList,
              ),
            ),
            CustomButton(
                label: Text('Change'),
                action: () async {
                  final response = await UserService.changePhoto(
                      authProvider.currentUser!,
                      profileImageProvider.selectedUrl!);

                  if (response == 'succes') {
                    profileImageProvider.selectedUrl = null;
                    authProvider.refreshSession();
                    Navigator.pop(context);

                    CustomHelpers.showCustomSnackBar(
                        context,
                        'Foto actualizada',
                        'La foto de perfil se actualizo correctamente',
                        Colors.green);
                  }
                })
          ],
        ),
      ),
    );
  }
}

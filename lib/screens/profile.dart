import 'package:flutter/material.dart';
import 'package:insults_album/constans/custom_colors.dart';
import 'package:insults_album/constans/helpers.dart';
import 'package:insults_album/widgets/custom/custom_button.dart';
import 'package:insults_album/widgets/profile_image/profile_image.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/user_service.dart';
import '../widgets/custom/title_font.dart';
import '../constans/custom_fonts.dart';
import '../widgets/custom/custom_text_field.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  String nameValue = "";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.grey),
        title: TitleFont(
          text: "Your profile",
          size: 25,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ----------- Image ------------
          const Center(child: ProfileImage()),
          const SizedBox(height: 25),
          // ----------- Name ------------
          const Text(
            'Name',
            style: CustomFonts.profileTitleStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                authProvider.currentUser!.name,
                style: CustomFonts.profileDatatyle,
                textAlign: TextAlign.end,
              ),
              const SizedBox(width: 15),
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 270, horizontal: 60),
                            child: Material(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              color: Colors.black,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Enter your new name',
                                    style: TextStyle(
                                        color: CustomColors.kBlue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  CustomTextField(
                                    label: 'Name',
                                    icon: Icons.account_circle_outlined,
                                    controller: (value) => nameValue = value,
                                  ),
                                  CustomButton(
                                      label: const Text('Change'),
                                      action: () async {
                                        final response =
                                            await UserService.changeName(
                                                authProvider.currentUser!,
                                                nameValue);
                                        nameValue = "";
                                        Navigator.pop(context);

                                        if (response == 'succes') {
                                          authProvider.refreshSession();
                                          CustomHelpers.showCustomSnackBar(
                                              context,
                                              'Exito',
                                              'Nombre cambiado correctamente',
                                              Colors.green);
                                          return;
                                        }

                                        CustomHelpers.showCustomSnackBar(
                                            context,
                                            'Error',
                                            'Ocurrio un error al cambiar el nombre',
                                            Colors.red);
                                      })
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: const Icon(Icons.edit)),
            ],
          ),
          const SizedBox(height: 15),
          // ----------- Mail ------------
          const Text(
            'Email',
            style: CustomFonts.profileTitleStyle,
          ),
          Text(
            authProvider.currentUser!.email,
            style: CustomFonts.profileDatatyle,
          ),
          const SizedBox(height: 15),
          // ----------- Uid ------------
          const Text(
            'Uid',
            style: CustomFonts.profileTitleStyle,
          ),
          Text(
            authProvider.currentUser!.uid,
            style: CustomFonts.profileDatatyle,
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}

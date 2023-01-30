import 'package:flutter/material.dart';
import 'package:insults_album/constans/custom_colors.dart';
import 'package:insults_album/providers/new_friend_provider.dart';
import 'package:insults_album/services/user_service.dart';
import 'package:insults_album/widgets/custom/custom_button.dart';
import 'package:insults_album/widgets/custom/custom_text_field.dart';
import 'package:insults_album/widgets/custom/waiting_indicator.dart';
import 'package:insults_album/widgets/layout/dialog_layout.dart';
import 'package:insults_album/widgets/layout/small_dialog_layout.dart';
import 'package:provider/provider.dart';

class NewFriendDialog extends StatelessWidget {
  const NewFriendDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final newFriendProvider = Provider.of<NewFriendProvider>(context);
    String nameText = "";

    return WillPopScope(
      onWillPop: () {
        nameText = "";
        newFriendProvider.setStateDelayed();
        Navigator.pop(context);
        return Future.value(false);
      },
      child: SmallDialogLayout(
        // ------------------ Search ----------------
        child: newFriendProvider.state == 'search'
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter your friends nickname',
                    style: TextStyle(
                        color: CustomColors.kBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  CustomTextField(
                    label: 'Name',
                    icon: Icons.account_circle_outlined,
                    controller: (value) => nameText = value,
                  ),
                  CustomButton(
                      label: const Text('Search'),
                      action: () async {
                        newFriendProvider.state = "waiting";

                        final friendUser =
                            await UserService.getUserByName(nameText);

                        if (friendUser != 'error') {
                          newFriendProvider.friend = friendUser;
                          newFriendProvider.state = "exist";

                          return;
                        }

                        newFriendProvider.state = "error";
                      })
                ],
              )

            // ------------------ Waiting ----------------
            : newFriendProvider.state == 'waiting'
                ? const Center(
                    child: WaitingIndicator(),
                  )

                // ------------------ Show friend ----------------
                : newFriendProvider.state == 'exist'
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      newFriendProvider.friend!.profile_image,
                                    )),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      newFriendProvider.friend!.name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      newFriendProvider.friend!.email,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                              label: Text('Send request'), action: () {})
                        ],
                      )

                    // ------------------ Error ----------------
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'User not found',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          CustomButton(
                              label: Text('Search again'),
                              action: () {
                                newFriendProvider.state = 'search';
                                nameText = "";
                              })
                        ],
                      ),
      ),
    );
  }
}

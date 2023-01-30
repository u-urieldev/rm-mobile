import 'package:flutter/material.dart';
import 'package:insults_album/models/app_user.dart';
import 'package:insults_album/providers/auth_provider.dart';
import 'package:insults_album/services/user_service.dart';
import 'package:insults_album/widgets/custom/custom_fab.dart';
import 'package:insults_album/widgets/custom/title_font.dart';
import 'package:insults_album/widgets/custom/waiting_indicator.dart';
import 'package:insults_album/widgets/friends/new_friend_dialog.dart';
import 'package:insults_album/widgets/friends/new_friend_dialog.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatelessWidget {
  FriendsPage({super.key});

  Future<List<AppUser>> fetchFriends(List<String> friends) async {
    List<AppUser> friendsObjects = [];

    for (var friendUid in friends) {
      AppUser friendUser = await UserService.getUser(friendUid);
      friendsObjects.add(friendUser);
    }

    return friendsObjects;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.grey),
          title: TitleFont(
            text: 'Your Friends',
            size: 25,
          ),
        ),
        floatingActionButton: CustomFAB(
          text: "+",
          action: () => showDialog(
              context: context,
              builder: ((context) {
                return NewFriendDialog();
              })),
        ),
        body: FutureBuilder(
          future: fetchFriends(authProvider.currentUser!.friends),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int index) {
                    // Todo: Widget de amigo aqui
                    return Text(snapshot.data[index].name);
                  });
            }

            return const WaitingIndicator();
          },
        ));
  }
}




//  fetchFriend(authProvider.currentUser!.friends);

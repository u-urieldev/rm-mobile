import 'package:flutter/material.dart';
import 'package:insults_album/constans/custom_colors.dart';
import 'package:insults_album/constans/helpers.dart';
import 'package:insults_album/models/app_user.dart';
import 'package:insults_album/providers/auth_provider.dart';
import 'package:insults_album/services/friends_service.dart';
import 'package:insults_album/services/user_service.dart';
import 'package:insults_album/widgets/custom/custom_button.dart';
import 'package:insults_album/widgets/custom/title_font.dart';
import 'package:insults_album/widgets/custom/waiting_indicator.dart';
import 'package:provider/provider.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

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
          text: "Your requests",
          size: 25,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: fetchFriends(authProvider.currentUser!.requests),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  // Todo: Widget de amigo aqui
                  return Card(
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  snapshot.data[index].profile_image)),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  snapshot.data[index].email,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: IconButton(
                                icon: const Icon(Icons.check),
                                onPressed: () async {
                                  await FriendsService.aceptRequest(
                                      authProvider.currentUser!.uid,
                                      snapshot.data[index].uid);

                                  authProvider.refreshSession();

                                  CustomHelpers.showCustomSnackBar(
                                      context,
                                      'Requests acepted',
                                      '${snapshot.data[index].name} and you, now are friends',
                                      Colors.green);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const WaitingIndicator();
          },
        ),
      ),
    );
  }
}

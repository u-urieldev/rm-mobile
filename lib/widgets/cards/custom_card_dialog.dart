import 'package:flutter/material.dart';
import 'package:insults_album/models/app_user.dart';
import 'package:insults_album/providers/auth_provider.dart';
import 'package:insults_album/services/gifts_service.dart';
import 'package:insults_album/services/user_service.dart';
import 'package:insults_album/widgets/custom/waiting_indicator.dart';
import 'package:insults_album/widgets/layout/dialog_layout.dart';
import '../../providers/loading_providers.dart';
import 'package:provider/provider.dart';
import '../custom/custom_button.dart';
import '../../constans/helpers.dart';
import '../../constans/custom_fonts.dart';

class CustomCardDialog extends StatelessWidget {
  CustomCardDialog({
    this.imageUri,
    this.gender,
    this.id,
    this.origin,
    this.name,
    this.status,
    this.species,
    this.location,
    this.episodes,
    Key? key,
  }) : super(key: key);

  final int? id;
  final String? imageUri;
  final String? name;
  final String? status;
  final String? species;
  final String? location;
  final String? gender;
  final String? origin;
  final List<dynamic>? episodes;

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
    final loadingProvider = Provider.of<LoadingProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return ListView(
      children: [
        // ---       Image      ---
        Stack(fit: StackFit.passthrough, children: [
          Image.network(
            imageUri!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: WaitingIndicator(),
              );
            },
          ),
          Positioned(
            left: 240,
            top: 20,
            child: Container(
              width: 72,
              height: 50,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(23)),
                  color: Color.fromARGB(138, 77, 77, 77)),
              child: Center(
                  child: Text(
                '$id / 826',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),
          )
        ]),
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name!,
                  overflow: TextOverflow.clip, style: CustomFonts.nameStyle),
              const SizedBox(height: 10),
              // -------------- Gender/ species ------------------
              // ---- Titles  ---
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text('Gender ', style: CustomFonts.titleStyle)),
                  Expanded(
                    child: Text('Species', style: CustomFonts.titleStyle),
                  )
                ],
              ),
              // --- Data ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(gender!, style: CustomFonts.dataStyle)),
                  Expanded(
                    child: Text(species!, style: CustomFonts.dataStyle),
                  )
                ],
              ),
              const SizedBox(height: 16),
              // -------------- status ------------------
              Text('Status', style: CustomFonts.titleStyle),
              Row(
                children: [
                  Icon(
                    Icons.fiber_manual_record,
                    size: 13,
                    color: CustomHelpers.getStatusColor(status!),
                  ),
                  const SizedBox(width: 4),
                  Text(status!, style: CustomFonts.dataStyle),
                ],
              ),
              const SizedBox(height: 16),
              // -------------- Locations ------------------
              Text('Origin', style: CustomFonts.titleStyle),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 4),
                  Flexible(
                      child: Text(
                    origin!,
                    style: CustomFonts.dataStyle,
                    overflow: TextOverflow.clip,
                  )),
                ],
              ),
              const SizedBox(height: 16),
              Text('Last Known Location', style: CustomFonts.titleStyle),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(location!,
                        overflow: TextOverflow.clip,
                        style: CustomFonts.dataStyle),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // ---------     Episodes       ----------
              GestureDetector(
                onTap: () {
                  loadingProvider.isEpisode = !loadingProvider.isEpisode;
                },
                child: Row(
                  children: const [
                    Text('Episodes', style: CustomFonts.titleStyle),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 25,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              // ----       Episodes list --------
              loadingProvider.isEpisode
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: episodes!.map((e) => Text(e)).toList())
                  : const SizedBox(height: 4),
              loadingProvider.isEpisode
                  ? const SizedBox(height: 10)
                  : const SizedBox(height: 0),
              // ----  Button    -------
              Center(
                child: CustomButton(
                  label: const Text('Send'),
                  action: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogLayout(
                          child: Scaffold(
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              title: const Text(
                                'Send to a friend',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 194, 191, 191),
                            ),
                            body: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: FutureBuilder(
                                future: fetchFriends(
                                    authProvider.currentUser!.friends),
                                builder: ((context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, int index) {
                                          // Todo: Widget de amigo aqui
                                          return GestureDetector(
                                            onTap: () {
                                              GiftService.sendGift(
                                                      authProvider
                                                          .currentUser!.uid,
                                                      snapshot.data[index].uid,
                                                      id.toString())
                                                  // Refresh session
                                                  .then((value) => authProvider
                                                      .refreshSession()
                                                      // Close both dialogs
                                                      .then((value) =>
                                                          Navigator.pop(
                                                              context))
                                                      .then((value) =>
                                                          Navigator.pop(
                                                              context)))
                                                  // Show snackbar
                                                  .then((value) => CustomHelpers
                                                      .showCustomSnackBar(
                                                          context,
                                                          "Gift sended",
                                                          "Card sended to ${snapshot.data[index].name} correctly",
                                                          Colors.green));
                                            },
                                            child: Card(
                                              elevation: 2,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 40,
                                                        backgroundImage:
                                                            NetworkImage(snapshot
                                                                .data[index]
                                                                .profile_image)),
                                                    const SizedBox(width: 20),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snapshot
                                                              .data[index].name,
                                                          style: const TextStyle(
                                                              fontSize: 21,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          snapshot.data[index]
                                                              .email,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  }

                                  return const WaitingIndicator();
                                }),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:insults_album/constans/helpers.dart';
import 'package:insults_album/models/app_user.dart';
import 'package:insults_album/models/card.dart';
import 'package:insults_album/providers/auth_provider.dart';
import 'package:insults_album/services/cards_service.dart';
import 'package:insults_album/services/friends_service.dart';
import 'package:insults_album/services/gifts_service.dart';
import 'package:insults_album/services/user_service.dart';
import 'package:insults_album/widgets/cards/custom_card_dialog.dart';
import 'package:insults_album/widgets/layout/dialog_layout.dart';
import 'package:provider/provider.dart';

class GiftCard extends StatelessWidget {
  GiftCard({
    required this.sender,
    required this.appCard,
    Key? key,
  }) : super(key: key);

  AppUser sender;
  AppCard appCard;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            GiftService.acceptGift(authProvider.currentUser!.uid, sender.uid,
                    appCard.id.toString())
                .then((value) => authProvider.refreshSession());

            return DialogLayout(
              child: CustomCardDialog(
                imageUri: appCard.image,
                gender: appCard.gender,
                id: appCard.id,
                origin: appCard.origin,
                name: appCard.name,
                status: appCard.status,
                species: appCard.species,
                location: appCard.location,
                episodes: appCard.episodes,
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Color.fromARGB(255, 194, 191, 191),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.card_giftcard,
              size: 50,
            ),
            const SizedBox(height: 20),
            Text(
              'Card sended from ${sender.name}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text('Open',
                style: TextStyle(
                    color: Color.fromARGB(255, 98, 97, 97),
                    fontSize: 18,
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}

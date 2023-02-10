import 'package:flutter/material.dart';
import 'package:insults_album/constans/custom_colors.dart';
import 'package:insults_album/constans/helpers.dart';
import 'package:insults_album/models/app_user.dart';
import 'package:insults_album/services/cards_service.dart';
import 'package:insults_album/services/user_service.dart';
import 'package:insults_album/widgets/cards/gift_card.dart';
import 'package:insults_album/widgets/custom/custom_fab.dart';
import 'package:insults_album/widgets/custom/waiting_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/card.dart';
import '../widgets/custom/title_font.dart';
import '../widgets/drawer/drawer_menu.dart';
import '../widgets/cards/custom_card.dart';
import '../widgets/cards/new_card_dialog.dart';

class CardsPage extends StatelessWidget {
  CardsPage({super.key});

  Future fetchCards(
      List<String> cardsIds, List<Map<String, dynamic>> gifts) async {
    List<AppCard> cards = [];

    // cards = cardsIds
    //     .map((elem) async => await CardsService.fetchCard(elem))
    //     .toList();

    // Cards alrready in the collection
    for (var cardId in cardsIds) {
      AppCard card = await CardsService.fetchCard(cardId, isGift: false);
      cards.add(card);
    }

    // search for gifts
    if (gifts.length > 0) {
      for (var gift in gifts) {
        AppUser senderUser = await UserService.getUser(gift.keys.first);
        AppCard card = await CardsService.fetchCard(gift.values.first,
            isGift: true, sender: senderUser);

        cards.add(card);
      }
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   CustomHelpers.showCustomSnackBar(context, "Login hecho correctamente",
    //       "Bienvenido ${authProvider.currentUser!.name}", Colors.green);
    // });

    //fetchCards(authProvider.currentUser!.cards, authProvider.currentUser!.gifts);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Menu(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.grey),
          title: TitleFont(
            text: "Your cards",
            size: 25,
          ),
        ),
        floatingActionButton: CustomFAB(
          text: "+",
          action: () => showDialog(
              context: context,
              builder: ((context) {
                return NewCardDialog();
              })),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: fetchCards(authProvider.currentUser!.cards,
                authProvider.currentUser!.gifts),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: (.55),
                  // Creat un objeto custom card para cada objeto appcard que regresa fetchCards del snapshot
                  children: snapshot.data
                      .map<Widget>((card) => card.isGift
                          ? GiftCard(
                              sender: card.sender,
                              appCard: card,
                            )
                          : CustomCard(
                              imageUri: card.image,
                              name: card.name,
                              status: card.status,
                              species: card.species,
                              location: card.location,
                              id: card.id,
                              origin: card.origin,
                              gender: card.gender,
                              episodes: card.episodes))
                      .toList(),
                );
              }
              return const WaitingIndicator();
            },
          ),
        ),
      ),
    );
  }
}


//  showDialog(
//             context: context,
//             builder: ((context) {
//               return NewCardDialog();
//             }));



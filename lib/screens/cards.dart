import 'package:flutter/material.dart';
import 'package:insults_album/constans/custom_colors.dart';
import 'package:insults_album/services/cards_service.dart';
import 'package:insults_album/widgets/waiting_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/card.dart';
import 'package:http/http.dart' as http;
import '../models/card.dart';
import 'dart:convert';
import '../widgets/title_font.dart';
import '../widgets/drawer/drawer_menu.dart';
import '../widgets/custom_card.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  Future fetchCards(cardsIds) async {
    List<AppCard> cards = [];

    // cards = cardsIds
    //     .map((elem) async => await CardsService.fetchCard(elem))
    //     .toList();

    for (var cardId in cardsIds) {
      AppCard card = await CardsService.fetchCard(cardId);
      cards.add(card);
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    fetchCards(authProvider.currentUser!.cards);

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: TitleFont(
              text: "+",
              size: 32,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: fetchCards(authProvider.currentUser!.cards),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  childAspectRatio: (.55),
                  // Creat un objeto custom card para cada objeto appcard que regresa fetchCards del snapshot
                  children: snapshot.data
                      .map<Widget>((card) => CustomCard(
                            imageUri: card.image,
                            name: card.name,
                            status: card.status,
                            species: card.species,
                            location: card.location,
                            id: card.id,
                            origin: card.origin,
                            gender: card.gender,
                          ))
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

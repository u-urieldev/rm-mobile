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
          onPressed: (() => true),
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
                          location: card.location))
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

class CustomCard extends StatelessWidget {
  CustomCard({
    required this.imageUri,
    required this.name,
    required this.status,
    required this.species,
    required this.location,
    Key? key,
  }) : super(key: key);

  final String imageUri;
  final String name;
  final String status;
  final String species;
  final String location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('picado'),
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Color.fromARGB(255, 182, 180, 180),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUri,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    flexText(
                        name,
                        const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(
                          Icons.fiber_manual_record,
                          size: 13,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 4),
                        flexText('$status - $species',
                            const TextStyle(fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        flexText(location, const TextStyle()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible flexText(String text, TextStyle style) {
    return Flexible(
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}

// child: GridView.count(
//             crossAxisCount: 2,
//             mainAxisSpacing: 6,
//             crossAxisSpacing: 6,
//             childAspectRatio: (.55),
//             children: List.generate(5, (index) {
//               return const CustomCard();
//             }),
//           ),


// List.(snapshot.data.length, (card) {
//                     return CustomCard(imageUri: card.image, );
//                   }),
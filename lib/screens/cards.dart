import 'package:flutter/material.dart';
import 'package:insults_album/constans/custom_colors.dart';
import 'package:insults_album/services/cards_service.dart';
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

  // void fetchCard() async {
  //   AppCard card = await CardsService.fetchCard();
  //   print(card.image);
  // }

  @override
  Widget build(BuildContext context) {
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
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: (.55),
            children: List.generate(5, (index) {
              return const CustomCard();
            }),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
  }) : super(key: key);

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
                  'https://rickandmortyapi.com/api/character/avatar/452.jpeg',
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
                        'Simon',
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
                        flexText(
                            'Alive - Human', const TextStyle(fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        flexText(
                            "Earth (replacement dimension", const TextStyle()),
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

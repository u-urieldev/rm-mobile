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
        drawer: Menu(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.grey),
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
        body: Center(),
      ),
    );
  }
}

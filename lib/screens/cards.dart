import 'package:flutter/material.dart';
import 'package:insults_album/services/cards_service.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/card.dart';
import 'package:http/http.dart' as http;
import '../models/card.dart';
import 'dart:convert';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  void fetchCard() async {
    AppCard card = await CardsService.fetchCard();
    print(card.image);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final FirebaseFirestore _instance = FirebaseFirestore.instance;

    fetchCard();

    return Scaffold(
      appBar: AppBar(
        title: Text("Your cards ${authProvider.currentUser!.name}"),
      ),
      body: Container(),
    );
  }
}

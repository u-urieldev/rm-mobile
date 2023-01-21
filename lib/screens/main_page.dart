import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../models/episode.dart';
import 'dart:convert';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'rm-img',
                transitionOnUserGestures: true,
                child: Image.network(
                  'https://1000marcas.net/wp-content/uploads/2022/04/Rick-and-Morty.png',
                ),
              ),
              const Center(
                  child: Text(
                "Characters Album",
                style: TextStyle(color: Colors.grey),
              )),
              const SizedBox(height: 190),
              Hero(
                tag: 'log-in-b',
                transitionOnUserGestures: true,
                child: CustomButton(
                  label: const Text('Log In'),
                  action: () async => Navigator.pushNamed(context, '/login'),
                ),
              ),
              const SizedBox(height: 18),
              CustomButton(
                label: const Text('Sing Up'),
                action: () => Navigator.pushNamed(context, '/register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

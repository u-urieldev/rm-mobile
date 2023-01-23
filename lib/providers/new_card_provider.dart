import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/card.dart';

class NewCardProvider extends ChangeNotifier {
  String _state = 'get';
  AppCard? _card;

  String get state => _state;
  AppCard? get card => _card;

  set state(String value) {
    _state = value;
    notifyListeners();
  }

  set card(AppCard? value) {
    _card = value;
    notifyListeners();
  }
}

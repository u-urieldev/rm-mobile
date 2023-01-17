import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isWaiting = false;

  bool get isWaiting => _isWaiting;

  set isWaiting(bool value) {
    _isWaiting = value;
    notifyListeners();
  }
}

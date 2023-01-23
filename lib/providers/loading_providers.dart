import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isWaiting = false;
  bool _isEpisode = false;
  bool _isSingOut = false;

  bool get isWaiting => _isWaiting;
  bool get isEpisode => _isEpisode;
  bool get isSingOut => _isSingOut;

  set isWaiting(bool value) {
    _isWaiting = value;
    notifyListeners();
  }

  set isEpisode(bool value) {
    _isEpisode = value;
    notifyListeners();
  }

  set isSingOut(bool value) {
    _isSingOut = value;
    notifyListeners();
  }
}

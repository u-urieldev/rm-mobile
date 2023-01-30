import 'package:flutter/material.dart';
import 'package:insults_album/models/app_user.dart';
import 'package:provider/provider.dart';

class NewFriendProvider extends ChangeNotifier {
  AppUser? _friend;
  String _state = "search";

  AppUser? get friend => _friend;
  String get state => _state;

  set friend(AppUser? value) {
    _friend = value;
    notifyListeners();
  }

  set state(String value) {
    _state = value;
    notifyListeners();
  }

  void setStateDelayed() async {
    // Este future hace que la transicion de estados
    // show -> get no se vea en la pantalla
    await Future.delayed(const Duration(milliseconds: 800));
    state = 'search';
  }
}

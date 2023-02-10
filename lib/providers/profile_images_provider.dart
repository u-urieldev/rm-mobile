import 'package:flutter/material.dart';
import '../services/cards_service.dart';
import '../models/card.dart';
import '../widgets/profile_image/profile_image_selector.dart';

class ProfileImagesProvider extends ChangeNotifier {
  List<ProfileImageSelector> _imageList = [];
  String? _selectedUrl;

  List<ProfileImageSelector> get imageList => _imageList;
  String? get selectedUrl => _selectedUrl;

  set imageList(List<ProfileImageSelector> value) {
    _imageList = value;
    notifyListeners();
  }

  set selectedUrl(String? value) {
    _selectedUrl = value;
    notifyListeners();
  }

  Future fetchImages(cardsIds) async {
    _imageList = [];
    int id = 0;
    for (var cardId in cardsIds) {
      AppCard card = await CardsService.fetchCard(cardId, isGift: false);
      _imageList.add(ProfileImageSelector(
        image: Image.network(card.image!),
        url: card.image!,
      ));
      id++;
    }
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/services/api_service.dart';
import 'package:rick_and_morty/services/preferences_service.dart';

class FavouritesViewmodel extends ChangeNotifier {
  final _preferencesService = locator<PreferencesService>();
  final _apiService = locator<ApiService>();

  List<int> _favourites = [];
  List<CharacterModel> _characters = [];

  List<CharacterModel> get characters => _characters;

  void getFavourites() {
    _favourites = _preferencesService.getSavedCharacters();
    _getCharacters();
  }

  void _getCharacters() async {
    if (_favourites.isEmpty) return; // Boş favoriler listesi için kontrol
    _characters = await _apiService.getMultipleCharacters(_favourites);
    notifyListeners();
  }
}

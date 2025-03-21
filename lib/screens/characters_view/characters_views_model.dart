import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/services/api_service.dart';

class CharactersViewsModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<CharacterModel>? _characterModel;
  List<CharacterModel>? get characterModel => _characterModel;

  get getCharactersMore => null;

  void getCharacters() async {
    final charactersModel = await _apiService.getCharacters(url: null);
    _characterModel = charactersModel.characters;
    notifyListeners();
  }
}

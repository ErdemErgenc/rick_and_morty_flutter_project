import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/services/api_service.dart';

class CharactersViewsModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  CharactersModel? _characterModel;
  CharactersModel? get characterModel => _characterModel;

  void clearCharacters() {

    _characterModel = null;
    
    notifyListeners();
  }

  void getCharacters() async {
    _characterModel = await _apiService.getCharacters();
    notifyListeners();
  }

  bool loadMore = false;

  void getCharactersMore() async {
    if (loadMore) return;

    loadMore = true;
    final data = await _apiService.getCharacters(
      url: _characterModel?.info.next,
    );
    loadMore = false;
    _characterModel!.info = data.info;
    _characterModel!.characters.addAll(data.characters);

    notifyListeners();
  }

  void getCharactersByName(String name) async {
    clearCharacters();
    _characterModel = await _apiService.getCharacters(args: {'name': name});
    notifyListeners();
  }
}

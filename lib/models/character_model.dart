// TODO Implement this library.
import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/services/api_service.dart';

class CharactersViewsModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<CharacterModel>? _characterModel;
  List<CharacterModel>? get characterModel => _characterModel;

  void getCharacters() async {
    final charactersModel = await _apiService.getCharacters(url: null);
    _characterModel = charactersModel.characters;
    notifyListeners();
  }

  bool loadMore = false;

  void getCharactersMore() async {
    if (loadMore) return;

    // Check if _characterModel or its 'info' is null
    if (_characterModel == null ||
        _characterModel!.isEmpty ||
        _characterModel!.first.info == null ||
        _characterModel!.first.info.next == null) {
      return; // Don't load more if there's no next page
    }

    loadMore = true;
    final data = await _apiService.getCharacters(
      url: _characterModel?.first.info?.next, // Safely access the next URL
    );
    loadMore = false;

    // Merge the new data with the existing data
    _characterModel = [...?_characterModel, ...data.characters];
    notifyListeners();
  }
  
  void notifyListeners() {}
}

class CharactersModel {
   CharacterInfo info;
  final List<CharacterModel> characters;

  CharactersModel({required this.info, required this.characters});

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    final info = CharacterInfo.fromJson(
      json['info'] ?? {},
    ); // Null kontrolü ekledik.
    final characters =
        (json['results'] as List?)?.map((charJson) {
          return CharacterModel.fromJson(charJson);
        }).toList() ??
        []; // Eğer 'results' null ise boş bir liste atanır.
    return CharactersModel(info: info, characters: characters);
  }
}
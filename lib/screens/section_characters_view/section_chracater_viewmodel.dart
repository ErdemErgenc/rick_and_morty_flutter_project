 import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/models/episode_model.dart';
import 'package:rick_and_morty/services/api_service.dart';



class SectionCharactersViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<CharacterModel> _characters = [];
  List<CharacterModel> get characters => _characters;

  void getCharacters(EpisodeModel episodeModel) async {
    _characters = await _apiService.getCharactersFromUrlList(
      episodeModel.characters,
    );
    notifyListeners();
  }
}

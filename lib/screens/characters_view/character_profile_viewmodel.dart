import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/episode_model.dart';
import 'package:rick_and_morty/services/api_service.dart';


class CharacterProfileViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<EpisodeModel> _episodes = [];
  List<EpisodeModel> get episodes => _episodes;

  void getEpisodes(List<String> urlList) async {
    _episodes = await _apiService.getMultipleEpisodes(urlList);
    notifyListeners();
  }
}

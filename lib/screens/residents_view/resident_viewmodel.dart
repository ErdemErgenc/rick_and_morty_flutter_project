import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/services/api_service.dart';

class ResidentViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<CharacterModel> _residents = [];
  List<CharacterModel> get residents => _residents;

  void getResidents(List residentsUrlList) async {
    _residents = await _apiService.getCharactersFromUrlList(
      residentsUrlList.map((e) => e.toString()).toList(),
    );
    notifyListeners();
  }
}

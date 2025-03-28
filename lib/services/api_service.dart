import 'package:dio/dio.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/models/episode_model.dart';
import 'package:rick_and_morty/models/location_model.dart';

class ApiService {
  final _dio = Dio(BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'));

  Future<CharactersModel> getCharacters({
    String? url,
    Map<String, dynamic>? args,
  }) async {
    try {
      final response = await _dio.get(
        url ?? '/character',
        queryParameters: args,
      );
      return CharactersModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CharacterModel>> getMultipleCharacters(List<int> idList) async {
    try {
      if (idList.isEmpty) return []; // Boş liste kontrolü eklenmiştir.
      final response = await _dio.get('/character/${idList.join(',')}');

      if (response.data is List) {
        return (response.data as List)
            .map((e) => CharacterModel.fromJson(e))
            .toList();
      } else if (response.data is Map<String, dynamic>) {
        return [CharacterModel.fromJson(response.data)];
      } else {
        throw Exception('Unexpected response format: ${response.data}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<EpisodesModel> getAllEpisodes({String? url}) async {
    try {
      final response = await _dio.get(url ?? '/episode');
      if (response.data is Map<String, dynamic>) {
        final results = response.data['results'] as List;
        return EpisodesModel.fromList(results);
      } else {
        throw Exception('Unexpected data format!');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EpisodeModel>> getMultipleEpisodes(List<String> list) async {
    try {
      final List<String> episodeNumbers =
          list.map((e) => e.split('/').last).toList();
      String episodes = episodeNumbers.join(',');

      if (list.length == 1) episodes = '$episodes,'; // Tek eleman için kontrol

      final response = await _dio.get('/episode/$episodes');
      if (response.data is List) {
        return (response.data as List)
            .map((e) => EpisodeModel.fromMap(e))
            .toList();
      } else {
        return [EpisodeModel.fromMap(response.data)];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LocationModel> getAllLocations({String? url}) async {
    try {
      final response = await _dio.get(url ?? '/location');
      return LocationModel.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CharacterModel>> getCharactersFromUrlList(
    List<String> residentsUrl,
  ) async {
    final List<int> idList =
        residentsUrl.map((e) => int.parse(e.split('/').last)).toList();
    try {
      return await getMultipleCharacters(idList);
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/services/api_service.dart';
import 'package:rick_and_morty/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<PreferencesService>(
    () => PreferencesService(prefs: prefs),
  );

  locator.registerLazySingleton<ApiService>(() => ApiService());
}

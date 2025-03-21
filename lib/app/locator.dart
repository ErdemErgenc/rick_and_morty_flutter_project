import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/services/api_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiService());
}

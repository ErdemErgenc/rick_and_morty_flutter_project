import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/models/episode_model.dart';
import 'package:rick_and_morty/models/location_model.dart';
import 'package:rick_and_morty/screens/characters_view/character_profile_view.dart';
import 'package:rick_and_morty/screens/characters_view/character_profile_viewmodel.dart';
import 'package:rick_and_morty/screens/characters_view/characters_view.dart';
import 'package:rick_and_morty/screens/characters_view/favourites_viewsmodel.dart';
import 'package:rick_and_morty/screens/favourites_views.dart';
import 'package:rick_and_morty/screens/location_viewmodel.dart';
import 'package:rick_and_morty/screens/location_views.dart';
import 'package:rick_and_morty/screens/residents_view/resident_viewmodel.dart';
import 'package:rick_and_morty/screens/residents_view/residents_view.dart';
import 'package:rick_and_morty/screens/section_characters_view/section_character_view.dart';
import 'package:rick_and_morty/screens/section_characters_view/section_chracater_viewmodel.dart';
import 'package:rick_and_morty/screens/sections_viewmodel.dart';
import 'package:rick_and_morty/screens/sections_views.dart';
import 'package:rick_and_morty/screens/settings_view/settings_view.dart';
import 'package:rick_and_morty/screens/settings_view/settings_viewmodel.dart';
import 'package:rick_and_morty/views/app_view.dart';


final _routerKey = GlobalKey<NavigatorState>();
final _shellNavigatorCharactersKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellCharacters',
);
final _shellNavigatorFavouritesKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellFavourites',
);
final _shellNavigatorLocationsKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellLocations',
);
final _shellNavigatorSectionsKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellSections',
);

class AppRoutes {
  AppRoutes._();

  static const String characters = '/';
  static const String favourites = '/favourites';
  static const String locations = '/locations';
  static const String sections = '/sections';
  static const String settings = '/settings';

  static const String profileRoute = 'characterProfile';
  static const String characterProfile = '/characterProfile';

  static const String residentsRoute = 'residents';
  static const String residents = '/locations/residents';

  static const String sectionCharactersRoute = 'characters';
  static const String sectionCharacters = '/sections/characters';
}

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.characters,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppView(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCharactersKey,
          routes: [
            GoRoute(
              path: AppRoutes.characters,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => CharactersViewmodel(),
                    child: const CharactersView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.profileRoute,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => CharacterProfileViewmodel(),
                        child: CharacterProfileView(
                          characterModel: state.extra as CharacterModel,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFavouritesKey,
          routes: [
            GoRoute(
              path: AppRoutes.favourites,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => FavouritesViewmodel(),
                    child: const FavouritesView(),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLocationsKey,
          routes: [
            GoRoute(
              path: AppRoutes.locations,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => LocationViewmodel(),
                    child: const LocationsView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.residentsRoute,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => ResidentViewmodel(),
                        child: ResidentsView(
                          locationItem: state.extra as LocationItem,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSectionsKey,
          routes: [
            GoRoute(
              path: AppRoutes.sections,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => SectionsViewmodel(),
                    child: const SectionsView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.sectionCharactersRoute,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => SectionCharactersViewmodel(),
                        child: SectionCharactersView(
                          episodeModel: state.extra as EpisodeModel,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder:
          (context, state) => ChangeNotifierProvider(
            create: (context) => SettingsViewmodel(),
            child: const SettingsView(),
          ),
    ),
  ],
);

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/screens/characters_view/character_profile_view.dart';
import 'package:rick_and_morty/screens/characters_view/character_profile_viewmodel.dart';
import 'package:rick_and_morty/screens/characters_view/characters_view.dart';
import 'package:rick_and_morty/screens/characters_view/characters_views_model.dart';
import 'package:rick_and_morty/screens/characters_view/favourites_viewsmodel.dart';
import 'package:rick_and_morty/screens/favourites_views.dart';
import 'package:rick_and_morty/screens/location_viewmodel.dart';
import 'package:rick_and_morty/screens/location_views.dart';
import 'package:rick_and_morty/screens/sections_views.dart';
import 'package:rick_and_morty/views/app_view.dart';

// Doğru import yapıldı


final _routerKey = GlobalKey<NavigatorState>();

class AppRoutes {
  AppRoutes._();

  static const String characters = '/';
  static const String favourites = '/favourites';
  static const String locations = '/locations';
  static const String sections = '/sections';

  static const String profileRoute = 'characterProfile';
  static const String characterProfile = '/characterProfile';
}

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.characters,
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              AppView(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
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
          routes: [
            GoRoute(
              path: AppRoutes.locations,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => LocationViewmodel(),
                    child: const LocationsView(),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.sections,
              builder:
                  (context, state) =>
                      const SectionsView(), // Buradaki yönlendirme doğru sınıf ismiyle
            ),
          ],
        ),
      ],
    ),
  ],
);

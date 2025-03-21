import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/screens/characters_view/characters_view.dart';
import 'package:rick_and_morty/screens/characters_view/characters_views_model.dart';
import 'package:rick_and_morty/views/app_view.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:rick_and_morty/views/screens/characters_views.dart';
import 'package:rick_and_morty/screens/favourites_views.dart';
import 'package:rick_and_morty/screens/locations_views.dart';
import 'package:rick_and_morty/screens/sections_views.dart';

final routerKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static String characters = '/';
  static String favorites = '/favorites';
  static String locations = '/locations';
  static String sections = '/sections';
}

final router = GoRouter(
  initialLocation: AppRoutes.characters,
  navigatorKey: routerKey,
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
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => CharactersViewsModel(),
                child: CharactersViews(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.favorites,
              builder: (context, state) => FavouritesViews(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.locations,
              builder: (context, state) => LocationsViews(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.sections,
              builder: (context, state) => SectionsViews(),
            ),
          ],
        ),
      ],
    ),
  ],
);

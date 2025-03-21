import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar_widget(),
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(color: Theme.of(context).colorScheme.primary);
            }
            return TextStyle(color: Theme.of(context).colorScheme.tertiary);
          }),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,
          indicatorColor: Colors.transparent,
          destinations: [
            menuItem(
              context,
              0,
              navigationShell.currentIndex,
              Icons.face,
              'Karakterler',
            ),
            menuItem(
              context,
              1,
              navigationShell.currentIndex,
              Icons.bookmark,
              'Favorilerim',
            ),
            menuItem(
              context,
              2,
              navigationShell.currentIndex,
              Icons.location_on,
              'Konumlar',
            ),
            menuItem(
              context,
              3,
              navigationShell.currentIndex,
              Icons.menu,
              'Menü',
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(
    BuildContext context,
    int index,
    int currentIndex,
    IconData icon,
    String label,
  ) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color:
            currentIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.tertiary,
      ),
      label: label,
    );
  }

  AppBar app_bar_widget() {
    return AppBar(
      title: Text(
        "Rick and Morty",
        style: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Color(0xFF414A4C),
        ),
      ),
      actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
    );
  }
}

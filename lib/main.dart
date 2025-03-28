import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/app/router.dart';
import 'package:rick_and_morty/app/theme.dart';
import 'package:rick_and_morty/screens/characters_view/characters_views_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppTheme()),
        ChangeNotifierProvider(
          create: (context) => CharactersViewmodel(),
        ), // CharactersViewmodel Sağlayıcı
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder:
          (context, viewModel, child) => MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: viewModel.theme,
          ),
    );
  }
}

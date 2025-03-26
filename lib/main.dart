import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/app/router.dart';
import 'package:rick_and_morty/app/theme.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}

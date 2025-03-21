import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/app/router.dart';
import 'package:rick_and_morty/app/theme.dart';
// ignore: unused_import
import 'package:rick_and_morty/views/app_view.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router, theme: AppTheme.lightTheme);
  }
}

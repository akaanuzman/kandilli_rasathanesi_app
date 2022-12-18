import 'package:flutter/material.dart';
import 'package:kandilli_rasathanesi_app/core/base/base_singleton.dart';
import 'package:kandilli_rasathanesi_app/products/views/home_view.dart';

// TODO: Learn dart export

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget with BaseSingleton {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: constants.appTitle,
      theme: theme.themeData,
      debugShowCheckedModeBanner: constants.debugShowCheckedModeBanner,
      localizationsDelegates: constants.localizationsDelegates,
      supportedLocales: constants.supportedLocales,
      navigatorKey: constants.navigatorKey,
      home: const HomeView(),
    );
  }
}

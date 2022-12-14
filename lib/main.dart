import 'package:flutter/material.dart';
import 'core/base/base_singleton.dart';
import 'products/views/splash_view.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';

// TODO: Learn dart export

void main() {
  AppConstants constants = AppConstants.instance;

  runApp(
    MultiProvider(
      providers: constants.providers,
      child: const MyApp(),
    ),
  );
}

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
      home: const SplashView(),
    );
  }
}

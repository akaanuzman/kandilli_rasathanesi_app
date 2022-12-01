import 'package:provider/single_child_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/navigation_service.dart';

class AppConstants {
  static AppConstants? _instance;
  static AppConstants get instance {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = AppConstants.init();
      return _instance!;
    }
  }

  AppConstants.init();

  String get appTitle => "Stack Overflow Clone";
  bool get debugShowCheckedModeBanner => false;
  get localizationsDelegates => AppLocalizations.localizationsDelegates;
  get supportedLocales => AppLocalizations.supportedLocales;
  get navigatorKey => NavigationService.navigatorKey;

  final List<SingleChildWidget> _providers = [
  ];

  List<SingleChildWidget> get providers => _providers;
}

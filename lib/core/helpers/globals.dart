import 'package:intl/intl.dart';

import '../base/base_singleton.dart';

class Globals with BaseSingleton {
  static Globals? _instance;
  static Globals get instance {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = Globals.init();
      return _instance!;
    }
  }

  Globals.init();

  formatDate(String? s) {
    if (s == null) return "Tarih yok";
    var now = DateFormat('yyyy-MM-dd HH:mm:ss').parse(s.replaceAll('T', ' '));

    var day = now.day.toString().length == 1 ? "0${now.day}" : now.day;
    String convertedDateTime =
        "$day.${now.month.toString().padLeft(2, '0')}.${now.year.toString()}";
    return convertedDateTime;
  }

  formatDateWithHour(String? s) {
    if (s == null) return "Tarih yok";
    var now = DateFormat('yyyy-MM-dd HH:mm:ss').parse(s.replaceAll('T', ' '));

    var day = now.day.toString().length == 1 ? "0${now.day}" : now.day;
    String convertedDateTime =
        "$day.${now.month.toString().padLeft(2, '0')}.${now.year.toString()}";
    return convertedDateTime;
  }
}

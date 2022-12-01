
import 'package:flutter/material.dart';
class UIGlobals {
  static UIGlobals? _instance;
  static UIGlobals get instance {
    if (_instance != null) {
      return _instance!;
    } else {
      _instance = UIGlobals.init();
      return _instance!;
    }
  }

  UIGlobals.init();

  Divider get divider => const Divider(
        thickness: 1.5,
      );
}

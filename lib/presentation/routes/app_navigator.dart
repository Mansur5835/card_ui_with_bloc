import 'package:flutter/material.dart';

import '../../core/utils/navigator_arguments.dart';
import '../../main.dart';

Args args = Args(null);

class AppNavigator {
  static Future<dynamic> toNamed(String routeName, {Object? arguments}) async {
    dynamic value = await Navigator.pushNamed(
        navigatorKey.currentContext!, routeName,
        arguments: arguments);

    return value;
  }

  static Future<dynamic> to(Widget page, {Object? arguments}) async {
    dynamic value = await Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: ((context) {
        return page;
      })),
    );

    return value;
  }

  static Future<dynamic> toNamedAndOff(String routeName,
      {Object? arguments}) async {
    dynamic value = await Navigator.pushReplacementNamed(
        navigatorKey.currentContext!, routeName,
        arguments: arguments);

    return value;
  }

  static Future<dynamic> toNamedAndOffAll(String routeName,
      {Object? arguments}) async {
    dynamic value = await Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        routeName,
        (Route<dynamic> route) => false,
        arguments: arguments);

    return value;
  }

  static Future<void> back({result}) async {
    Navigator.pop(navigatorKey.currentContext!, result);
  }
}

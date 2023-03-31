import 'package:flutter/material.dart';

import '../../main.dart';

class AppDialog {
  final Widget? child;
  const AppDialog({this.child});

  Future<dynamic> show() async {
    var value = await showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => Scaffold(
            backgroundColor: Colors.transparent, body: child ?? Container()));

    return value;
  }
}

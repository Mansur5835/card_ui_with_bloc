import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppSetting {
  Future<void> appOnReady() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  String initial(BuildContext context) {
    {
      appOnReady();

      return "Cradit Card View";
    }
  }

  String call(BuildContext context) {
    return initial(context);
  }
}

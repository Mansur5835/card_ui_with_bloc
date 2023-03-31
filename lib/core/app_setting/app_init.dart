import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../data/local_sourses/local_storage.dart';

class AppInit {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Hive.openBox(LocalStorage.BOX_NAME);
  }
}

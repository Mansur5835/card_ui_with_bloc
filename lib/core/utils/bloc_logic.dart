import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class BlocLogic<T extends StateStreamableSource> {
  T call([BuildContext? context]) {
    return BlocProvider.of<T>(context ?? navigatorKey.currentContext!);
  }
}

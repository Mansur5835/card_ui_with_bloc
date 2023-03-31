import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppCubit<S> extends Cubit<S> {
  void init();

  AppCubit(S initState) : super(initState);

  void dispose();
}

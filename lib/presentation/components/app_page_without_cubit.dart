import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/bloc_logic.dart';
import 'app_cubit.dart';

abstract class AppPageWithoutCubit<C extends StateStreamableSource<S>, S>
    extends StatefulWidget {
  AppPageWithoutCubit({super.key});
  final cubit = BlocLogic<C>()();

  Widget build(BuildContext context, S state);

  @override
  State<StatefulWidget> createState() => _AppPageWithoutCubitState<C, S>();
}

class _AppPageWithoutCubitState<C extends StateStreamableSource<S>, S>
    extends State<AppPageWithoutCubit> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      (widget.cubit as AppCubit).init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      builder: (context, state) {
        return widget.build(context, state);
      },
    );
  }

  @override
  void dispose() {
    if (mounted) {
      (widget.cubit as AppCubit).dispose();
    }
    super.dispose();
  }
}

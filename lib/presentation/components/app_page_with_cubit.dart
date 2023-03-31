import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_cubit.dart';

abstract class AppPageWithCubit<C extends AppCubit<S>, S>
    extends StatefulWidget {
  final C bloc;
  late C cubit;

  AppPageWithCubit({super.key, required this.bloc});

  Widget build(BuildContext context, S state);

  @override
  State<StatefulWidget> createState() => _AppPageWithCubitState<C, S>();
}

class _AppPageWithCubitState<C extends AppCubit<S>, S>
    extends State<AppPageWithCubit> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<C>(
      create: (context) => (widget.bloc as C)..init(),
      child: BlocBuilder<C, S>(
        builder: (context, state) {
          widget.cubit = BlocProvider.of<C>(context);

          return widget.build(context, state);
        },
      ),
    );
  }

  @override
  void dispose() {
    if (mounted) {
      widget.cubit.dispose();
    }
    super.dispose();
  }
}

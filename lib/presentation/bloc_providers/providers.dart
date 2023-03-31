import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/add_card/cubit/add_card_cubit.dart';
import '../pages/dashboard/cubit/dashboard_cubit.dart';

providers(BuildContext context) {
  return [
    BlocProvider<DashboardCubit>(
      create: (BuildContext context) => DashboardCubit(),
    ),
    BlocProvider<AddCardCubit>(
      create: (BuildContext context) => AddCardCubit(),
    ),
  ];
}

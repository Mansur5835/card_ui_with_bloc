import 'package:flutter/material.dart';

import '../../../components/app_cubit.dart';
part 'dashboard_state.dart';

class DashboardCubit extends AppCubit<DashboardState> {
  DashboardCubit() : super(DashboardState());
  PageController pageController = PageController();

  void jumpToPage(int index) {
    emit(state.copyWith(state..currentPageIndex = index));
    pageController.jumpToPage(index);
  }

  keyBoardListener(bool keyboardIsOpened) {
    emit(state.copyWith(state..keyboardIsOpened = keyboardIsOpened));
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void init() {
    // TODO: implement init
  }
}

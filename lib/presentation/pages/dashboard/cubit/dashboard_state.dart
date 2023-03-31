part of 'dashboard_cubit.dart';

class DashboardState {
  int currentPageIndex;
  bool keyboardIsOpened;

  DashboardState([this.currentPageIndex = 0, this.keyboardIsOpened = false]);

  DashboardState copyWith(DashboardState state) {
    return DashboardState(state.currentPageIndex, state.keyboardIsOpened);
  }
}

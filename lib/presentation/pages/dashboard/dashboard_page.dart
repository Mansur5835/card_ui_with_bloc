import 'package:credit_card_ui/presentation/components/app_page_without_cubit.dart';
import 'package:credit_card_ui/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:credit_card_ui/presentation/pages/main/main_page.dart';
import 'package:credit_card_ui/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import '../../components/view/navigation_item_view.dart';
import '../add_card/add_card_page.dart';
import '../profile/profile_page.dart';

class DashboardPage
    extends AppPageWithoutCubit<DashboardCubit, DashboardState> {
  static const String route = "/";
  DashboardPage({super.key});

  @override
  Widget build(BuildContext context, state) {
    cubit.keyBoardListener(MediaQuery.of(context).viewInsets.bottom != 0.0);
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          _pages(),
          if (!state.keyboardIsOpened) _bottomNavBar(state, context)
        ],
      ),
    );
  }

  Widget _pages() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: cubit.pageController,
      children: [
        MainPage(),
        AddCardPage(),
        ProfilePage(),
      ],
    );
  }

  Widget _bottomNavBar(DashboardState state, BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.2,
                  blurRadius: 3,
                  color: AppColors.black04,
                  offset: const Offset(0, -0.1))
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: AppColors.blackGrey2),
        child: Row(
          children: [
            NavigationItemView(
              icon: "home",
              selected: state.currentPageIndex == 0,
              onTab: () {
                cubit.jumpToPage(0);
              },
            ),
            NavigationItemView(
              icon: "add",
              selected: state.currentPageIndex == 1,
              onTab: () {
                cubit.jumpToPage(1);
              },
            ),
            NavigationItemView(
              icon: "user",
              selected: state.currentPageIndex == 2,
              onTab: () {
                cubit.jumpToPage(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}

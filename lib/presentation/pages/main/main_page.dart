import 'package:credit_card_ui/core/utils/assets_meneger.dart';
import 'package:credit_card_ui/data/constants/enums.dart';
import 'package:credit_card_ui/presentation/components/app_page_with_cubit.dart';
import 'package:credit_card_ui/presentation/components/app_text.dart';
import 'package:credit_card_ui/presentation/components/view/card_view.dart';
import 'package:credit_card_ui/presentation/pages/edit_card/edit_card_page.dart';
import 'package:credit_card_ui/presentation/pages/main/cubit/main_cubit.dart';
import 'package:credit_card_ui/presentation/routes/app_navigator.dart';
import 'package:credit_card_ui/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../components/animations/slide_and_opasity_animation.dart';

class MainPage extends AppPageWithCubit<MainCubit, MainState> {
  MainPage({super.key}) : super(bloc: MainCubit());

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: AppColors.black,
                centerTitle: true,
                title: const AppText(
                  "My Cards",
                  fontWeight: FontWeight.w500,
                ),
              )
            ];
          },
          body: _myCases(state)),
    );
  }

  Widget _myCases(MainState state) {
    switch (state.myCases) {
      case MyCases.loading:
        return Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        );

      case MyCases.empty:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(AssetsManager.lottie(name: "card"),
                  width: 200, height: 150),
              AppText(
                "Add your first card",
                size: 22,
                color: AppColors.white,
              )
            ],
          ),
        );

      case MyCases.hasData:
        return SingleChildScrollView(
          child: Column(children: [
            ...List.generate(state.listOfCards?.length ?? 0, (index) {
              return SlideAndOpasityAnimation(
                opasityDuration: 0,
                slideDuration: ((index + 1) % 10) * 250,
                child: GestureDetector(
                    onTap: () async {
                      await AppNavigator.toNamed(EditCardPage.route,
                          arguments: {
                            "card": state.listOfCards![index],
                            "index": index
                          });
                      cubit.fetchAgain();
                    },
                    child: CardView(cardModel: state.listOfCards![index])),
              );
            }),
            const SizedBox(
              height: 70,
            ),
          ]),
        );
    }
  }
}

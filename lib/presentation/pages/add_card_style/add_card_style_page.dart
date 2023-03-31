import 'package:credit_card_ui/core/utils/assets_meneger.dart';
import 'package:credit_card_ui/presentation/components/app_buttons.dart';
import 'package:credit_card_ui/presentation/components/app_dialog.dart';
import 'package:credit_card_ui/presentation/components/app_page_with_cubit.dart';
import 'package:credit_card_ui/presentation/components/app_tab.dart';
import 'package:credit_card_ui/presentation/components/app_text.dart';
import 'package:credit_card_ui/presentation/components/view/color_pick_view.dart';
import 'package:credit_card_ui/presentation/pages/add_card_style/cubit/add_card_style_cubit.dart';
import 'package:credit_card_ui/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/enums.dart';

// ignore: must_be_immutable
class AddCardStylePage
    extends AppPageWithCubit<AddCardStyleCubit, AddCardStyleState> {
  static const String route = "/add_card_style_page";
  AddCardStylePage({super.key}) : super(bloc: AddCardStyleCubit());

  @override
  Widget build(BuildContext context, state) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        centerTitle: true,
        title: const AppText(
          "Gradient Style",
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            _gradient(state),
            _gradientDiraction(state),
            _gradientRatio(state),
            _chooseGradientType(state),
            const Spacer(),
            _button(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _button() {
    return PrimaryButton(
      onTap: () {
        cubit.saveData();
      },
      title: "Save",
      backGroundColor: AppColors.primaryColor,
    );
  }

  Widget _chooseGradientType(AddCardStyleState state) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "Choose Your Gradient Type",
            color: AppColors.white,
            size: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppTab(
                    isSelecded: state.gradientType == GradientType.linear,
                    onTap: () {
                      cubit.setType(GradientType.linear);
                    },
                    title: "Linaer"),
                AppTab(
                    isSelecded: state.gradientType == GradientType.radial,
                    onTap: () {
                      cubit.setType(GradientType.radial);
                    },
                    title: "Radial"),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _gradientRatio(AddCardStyleState state) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "Choose Your Gradient Ratio",
            color: AppColors.white,
            size: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Slider(
            activeColor: AppColors.primaryColor,
            value: state.ratioSliderValue,
            onChanged: (v) {
              cubit.ratSliderOnChange(v);
            })
      ],
    );
  }

  Widget _gradientDiraction(AddCardStyleState state) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: AppText(
            "Choose Your Gradient ${state.gradientType == GradientType.radial ? "Radius" : "Direction"}",
            color: AppColors.white,
            size: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Slider(
            activeColor: AppColors.primaryColor,
            value: state.diractionSliderValue,
            onChanged: (v) {
              cubit.dirSliderOnChange(v);
            })
      ],
    );
  }

  Widget _gradient(AddCardStyleState state) {
    return Stack(
      children: [
        Hero(
          tag: "gradient_style",
          child: Container(
              height: 220,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.white),
                gradient: state.gradientType == GradientType.linear
                    ? LinearGradient(
                        begin: state.start ?? const Alignment(0, 1),
                        end: state.end ?? const Alignment(0, -1),
                        stops: [
                            state.ratioSliderValue,
                            1,
                          ],
                        colors: [
                            state.startColor ?? AppColors.primaryColor,
                            state.endColor ?? Colors.purple,
                          ])
                    : RadialGradient(
                        radius: state.diractionSliderValue,
                        colors: [
                          state.startColor ?? AppColors.primaryColor,
                          state.endColor ?? Colors.purple,
                        ],
                        center: Alignment(state.ratioSliderValueForR, 0)),
              )),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          height: 220,
          alignment: state.start ?? const Alignment(0, 1),
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () async {
              Color? color = await AppDialog(
                  child: ColorPickView(
                currentColor: state.startColor ?? AppColors.primaryColor,
              )).show();

              cubit.setColor(color, "START");
            },
            child: Image.asset(
              AssetsManager.icon(name: "color-picker"),
              width: 35,
              height: 35,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          height: 220,
          alignment: state.end ?? const Alignment(0, -1),
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () async {
              Color? color = await AppDialog(
                  child: ColorPickView(
                currentColor: state.endColor ?? Colors.purple,
              )).show();

              cubit.setColor(color, "END");
            },
            child: Image.asset(
              AssetsManager.icon(name: "color-picker"),
              width: 35,
              height: 35,
            ),
          ),
        )
      ],
    );
  }
}

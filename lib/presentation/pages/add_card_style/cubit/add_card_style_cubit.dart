import 'package:credit_card_ui/core/utils/bloc_logic.dart';
import 'package:credit_card_ui/core/utils/client_mixin.dart';
import 'package:credit_card_ui/data/constants/enums.dart';
import 'package:credit_card_ui/data/models/aligment_model.dart';
import 'package:credit_card_ui/presentation/pages/add_card/cubit/add_card_cubit.dart';
import 'package:credit_card_ui/presentation/routes/app_navigator.dart';
import 'package:credit_card_ui/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/gradient_model.dart';
import '../../../components/app_cubit.dart';
part 'add_card_style_state.dart';

class AddCardStyleCubit extends AppCubit<AddCardStyleState> with ClientMixin {
  AddCardStyleCubit() : super(AddCardStyleState());

  dirSliderOnChange(double value) {
    if (state.gradientType == GradientType.linear) {
      double pickAligmentX = value;
      double pickAligmentY = 1 - value;

      emit(state.copyWith(
        state
          ..diractionSliderValue = value
          ..start = Alignment(pickAligmentX, pickAligmentY)
          ..end = Alignment(-pickAligmentX, -pickAligmentY),
      ));
    } else {
      emit(state.copyWith(
        state..diractionSliderValue = value,
      ));
    }
  }

  ratSliderOnChange(double value) {
    if (state.gradientType == GradientType.radial) {
      double ratio = (value) > 0.5 ? 2 * (value - 0.5) : 2 * value - 1;

      double rEndY =
          ((state.start?.x ?? 0).abs() - ratio).abs() < 0.3 ? -0.8 : 0.8;

      emit(state.copyWith(
        state
          ..ratioSliderValue = value
          ..ratioSliderValueForR = ratio
          ..start = Alignment(ratio, 0)
          ..end = Alignment(rEndY, 0),
      ));
    } else {
      double ratio = (value) > 0.5 ? 2 * (value - 0.5) : 2 * value - 1;

      double rEndY =
          ((state.start?.x ?? 0).abs() - ratio).abs() < 0.3 ? -0.8 : 0.8;

      emit(state.copyWith(
        state
          ..ratioSliderValue = value
          ..ratioSliderValueForR = ratio,
      ));
    }
  }

  setType(GradientType gradientType) {
    emit(state.copyWith(state..gradientType = gradientType));
    ratSliderOnChange(state.ratioSliderValue);
    dirSliderOnChange(state.diractionSliderValue);
  }

  setColor(Color? color, String type) {
    if (color == null) return;
    if (type == "START") {
      emit(state.copyWith(state..startColor = color));
    } else {
      emit(state.copyWith(state..endColor = color));
    }
  }

  saveData() async {
    GradientModel gradientModel = GradientModel(
        gradientType:
            state.gradientType == GradientType.linear ? "LINEAR" : "RADIAL",
        startAligmentModel: AligmentModel.fromAligment(
          state.start ?? const Alignment(0, 1),
        ),
        endAligmentModel:
            AligmentModel.fromAligment(state.end ?? const Alignment(0, -1)),
        startColor: state.startColor?.value ?? AppColors.primaryColor.value,
        endColor: state.endColor?.value ?? Colors.purple.value,
        stopValue: state.gradientType == GradientType.linear
            ? state.ratioSliderValue
            : state.diractionSliderValue,
        radialValue: state.ratioSliderValueForR);

    await client.setGradient(gradientModel);
    final addCardCubit = BlocLogic<AddCardCubit>()();
    await addCardCubit.fetchAgain();

    Future.delayed(Duration.zero, () {
      AppNavigator.back(result: true);
    });
  }

  @override
  void dispose() {}

  @override
  void init() {}
}

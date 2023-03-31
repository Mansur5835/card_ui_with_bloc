part of 'add_card_style_cubit.dart';

class AddCardStyleState {
  double diractionSliderValue;
  double ratioSliderValue;
  double ratioSliderValueForR;
  Alignment? start;
  Alignment? end;
  GradientType gradientType;
  Color? startColor;
  Color? endColor;
  AddCardStyleState([
    this.diractionSliderValue = 0,
    this.ratioSliderValue = 0,
    this.start,
    this.end,
    this.gradientType = GradientType.linear,
    this.ratioSliderValueForR = 0,
    this.startColor,
    this.endColor,
  ]);

  AddCardStyleState copyWith(AddCardStyleState state) {
    return AddCardStyleState(
        state.diractionSliderValue,
        state.ratioSliderValue,
        state.start,
        state.end,
        state.gradientType,
        state.ratioSliderValueForR,
        state.startColor,
        state.endColor);
  }
}

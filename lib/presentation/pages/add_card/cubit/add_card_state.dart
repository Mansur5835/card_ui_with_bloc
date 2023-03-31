part of 'add_card_cubit.dart';

class AddCardState {
  List<GradientModel>? listOfGradients;
  List<String>? listOfBackImages;
  CardModel? cardModel;
  bool notEmpty;

  AddCardState(
      [this.listOfGradients,
      this.listOfBackImages,
      this.cardModel,
      this.notEmpty = true]);

  AddCardState copyWith(AddCardState state) {
    return AddCardState(state.listOfGradients, state.listOfBackImages,
        state.cardModel, state.notEmpty);
  }
}

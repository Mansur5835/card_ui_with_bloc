part of 'edit_card_cubit.dart';

class EditCardState {
  CardModel? cardModel;
  bool notEmpty;

  EditCardState([this.cardModel, this.notEmpty = true]);

  EditCardState copyWith(EditCardState state) {
    return EditCardState(state.cardModel, state.notEmpty);
  }
}

part of 'main_cubit.dart';

class MainState {
  List<CardModel>? listOfCards;
  MyCases myCases;

  MainState([this.listOfCards, this.myCases = MyCases.hasData]);

  MainState copyWith(MainState state) {
    return MainState(state.listOfCards, state.myCases);
  }
}

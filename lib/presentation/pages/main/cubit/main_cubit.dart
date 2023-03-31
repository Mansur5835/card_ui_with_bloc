import 'package:credit_card_ui/core/utils/client_mixin.dart';
import 'package:credit_card_ui/data/models/card_model.dart';

import '../../../../data/constants/enums.dart';
import '../../../components/app_cubit.dart';

part 'main_state.dart';

class MainCubit extends AppCubit<MainState> with ClientMixin {
  MainCubit() : super(MainState());

  @override
  void init() {
    _loadData();
  }

  _loadData() async {
    emit(state.copyWith(state..myCases = MyCases.loading));

    List<CardModel>? list = await client.getCard();

    bool isEmpty = list.isEmpty;

    emit(state.copyWith(state
      ..listOfCards = list
      ..myCases = isEmpty ? MyCases.empty : MyCases.hasData));
  }

  fetchAgain() {
    _loadData();
  }

  @override
  void dispose() {}
}

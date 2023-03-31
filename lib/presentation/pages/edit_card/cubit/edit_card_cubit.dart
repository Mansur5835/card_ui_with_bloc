import 'package:credit_card_ui/core/utils/bloc_logic.dart';
import 'package:credit_card_ui/core/utils/client_mixin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/input_formater.dart';
import '../../../../data/constants/enums.dart';
import '../../../../data/models/card_model.dart';
import '../../../../data/models/gradient_model.dart';
import '../../../components/app_cubit.dart';
import '../../../routes/app_navigator.dart';
import '../../add_card/cubit/add_card_cubit.dart';

part 'edit_card_state.dart';

class EditCardCubit extends AppCubit<EditCardState> with ClientMixin {
  EditCardCubit() : super(EditCardState());
  int index = 0;
  int indexOfCard = 0;

  final AddCardCubit cubitAddCard = BlocLogic<AddCardCubit>()();

  PageController pageController = PageController();

  ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController date = TextEditingController();

  @override
  void init() {
    CardModel cardModel = args.get["card"];
    indexOfCard = args.get["index"];

    name.text = cardModel.name ?? "";
    number.text = cardModel.number ?? "";
    date.text = cardModel.date ?? "";

    emit(state.copyWith(state..cardModel = cardModel));
    fetchAgain();
  }



  deleteStyleAction(int index, {String action = "GRADIENT"}) {
    if (action == "GRADIENT") {
      client.deleteGradient(index);
    } else {
      client.deleteBackImage(index);
    }
    fetchAgain();
  }

  pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    AppNavigator.back();

    if (image == null) return;

    client.setBackImage(image.path);

    fetchAgain();

    jumpToPage(false);
  }

  fetchAgain() {
    cubitAddCard.fetchAgain();
  }

  jumpToPage(bool? isAdded) async {
    if (isAdded == null) return;
    int index = 0;
    if (!isAdded) {
      index = (cubitAddCard.state.listOfGradients?.length ?? 0) +
          (cubitAddCard.state.listOfBackImages?.length ?? 0) +
          10;
    } else {
      index = (cubitAddCard.state.listOfGradients?.length ?? 0) + 9;
    }

    pageController.animateToPage(index - 2,
        duration: const Duration(seconds: 1), curve: Curves.ease);
  }

  jumpToPageDur100() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      pageController.animateToPage(index,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    });
  }

  setBackAndType({required dynamic back, required EntityType entityType}) {
    state.cardModel?.background = back;
    state.cardModel?.entityType = entityType;
  }

  onName(String value) {
    emit(state.copyWith(state..cardModel?.name = value));
  }

  onCardNumber(String value) {
    CardType type = InputFormoter.cardChecker(value);
    state.cardModel?.icon = cards[type];
    emit(state.copyWith(state..cardModel?.number = value));
  }

  onCardDate(String value) {
    emit(state.copyWith(state..cardModel?.date = value));
  }

  onPage(int page) {
    index = page;

    int totelPageCount = 9 +
        (cubitAddCard.state.listOfBackImages?.length ?? 0) +
        (cubitAddCard.state.listOfGradients?.length ?? 0);

    if (totelPageCount == (index + 1)) {
      emit(state.copyWith(state.copyWith(state..notEmpty = false)));
    } else {
      emit(state.copyWith(state.copyWith(state..notEmpty = true)));
    }
  }

  edit() {
    if (!state.notEmpty) return;

    bool isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    client.editeCard(index: indexOfCard, cardModel: state.cardModel);
    AppNavigator.back();
  }

  delete() {
    client.deleteCard(indexOfCard);
    AppNavigator.back();
  }

  clear() {
    name.clear();
    number.clear();
    date.clear();
  }

  @override
  void dispose() {
    clear();
  }
}

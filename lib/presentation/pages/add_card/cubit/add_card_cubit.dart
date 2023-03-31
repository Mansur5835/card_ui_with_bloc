import 'package:credit_card_ui/core/utils/assets_meneger.dart';
import 'package:credit_card_ui/core/utils/bloc_logic.dart';
import 'package:credit_card_ui/core/utils/client_mixin.dart';
import 'package:credit_card_ui/core/utils/input_formater.dart';
import 'package:credit_card_ui/data/models/gradient_model.dart';
import 'package:credit_card_ui/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:credit_card_ui/presentation/routes/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/constants/enums.dart';
import '../../../../data/models/card_model.dart';
import '../../../components/app_cubit.dart';
part 'add_card_state.dart';

final defaultmodel = CardModel(
  date: "05/27",
  name: "ANDREA RICHARDS",
  number: "0000 0000 0000 0000",
);

final MASTER_CARD = AssetsManager.images(name: "mastercard");
final UZCARD = AssetsManager.images(name: "uzcard");
final XUMO = AssetsManager.images(name: "xumo");

Map<CardType, String?> cards = {
  CardType.mastercard: MASTER_CARD,
  CardType.uzcard: UZCARD,
  CardType.xumo: XUMO,
  CardType.none: null,
};

class AddCardCubit extends AppCubit<AddCardState> with ClientMixin {
  AddCardCubit() : super(AddCardState());
  int index = 0;

  PageController pageController = PageController();

  ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController date = TextEditingController();

  @override
  void init() {
    emit(state.copyWith(state
      ..cardModel = CardModel(
        date: "05/27",
        name: "ANDREA RICHARDS",
        number: "0000 0000 0000 0000",
      )));
    _loadData();
  }

  _loadData() async {
    List<GradientModel>? listG = await client.getGradient();
    List<String>? listI = await client.getBackImage();
    emit(state.copyWith(state
      ..listOfGradients = listG
      ..listOfBackImages = listI));
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

    if (image == null) return;

    client.setBackImage(image.path);

    fetchAgain();

    jumpToPage(false);
  }

  fetchAgain() {
    _loadData();
  }

  jumpToPage(bool? isAdded) async {
    if (isAdded == null) return;
    int index = 0;
    if (!isAdded) {
      index = (state.listOfGradients?.length ?? 0) +
          (state.listOfBackImages?.length ?? 0) +
          10;
    } else {
      index = (state.listOfGradients?.length ?? 0) + 9;
    }

    pageController.animateToPage(index - 2,
        duration: const Duration(seconds: 1), curve: Curves.ease);

    emit(state.copyWith(state..notEmpty = true));
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
        (state.listOfBackImages?.length ?? 0) +
        (state.listOfGradients?.length ?? 0);

    if (totelPageCount == (index + 1)) {
      emit(state.copyWith(state.copyWith(state..notEmpty = false)));
    } else {
      emit(state.copyWith(state.copyWith(state..notEmpty = true)));
    }
  }

  save() {
    if (!state.notEmpty) return;

    bool isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    client.setCard(state.cardModel);

    final dashCubit = BlocLogic<DashboardCubit>()();
    dashCubit.jumpToPage(0);
    clear();
  }

  clear() {
    name.clear();
    number.clear();
    date.clear();
    emit(state.copyWith(state
      ..cardModel = CardModel(
        date: "05/27",
        name: "ANDREA RICHARDS",
        number: "0000 0000 0000 0000",
      )));
  }

  @override
  void dispose() {
    clear();
  }
}

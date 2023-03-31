part of "local_client.dart";

class _LocalClient implements LocalClient {
  final LocalStorage _localStorage = LocalStorage();

  @override
  Future<void> setGradient(GradientModel cardModel) async {
    List listGradients =
        _localStorage.readData(BoxKeys.listOfGradientModels) ?? [];

    listGradients.add(cardModel.toJson());

    _localStorage.writeData(BoxKeys.listOfGradientModels, listGradients);
  }

  @override
  Future<List<GradientModel>> getGradient() async {
    List listGradients =
        _localStorage.readData(BoxKeys.listOfGradientModels) ?? [];

    List<GradientModel> listGradientModels = listGradients.map((e) {
      return GradientModel.fromJson(e);
    }).toList();

    return listGradientModels;
  }

  @override
  Future<void> deleteGradient(int index) async {
    List listGradients =
        _localStorage.readData(BoxKeys.listOfGradientModels) ?? [];

    listGradients.removeAt(index);

    _localStorage.writeData(BoxKeys.listOfGradientModels, listGradients);
  }

  @override
  Future<void> setBackImage(String imagePath) async {
    List listBackImages =
        _localStorage.readData(BoxKeys.listOfBackImages) ?? [];

    listBackImages.add(imagePath);

    _localStorage.writeData(BoxKeys.listOfBackImages, listBackImages);
  }

  @override
  Future<void> deleteBackImage(int index) async {
    List listBackImages =
        _localStorage.readData(BoxKeys.listOfBackImages) ?? [];

    listBackImages.removeAt(index);

    _localStorage.writeData(BoxKeys.listOfBackImages, listBackImages);
  }

  @override
  Future<List<String>> getBackImage() async {
    List listBackImages =
        _localStorage.readData(BoxKeys.listOfBackImages) ?? [];

    return listBackImages.map((e) => e.toString()).toList();
  }

  @override
  Future<void> setCard(CardModel? cardModel) async {
    List list = _localStorage.readData(BoxKeys.listOfCards) ?? [];

    list.add(cardModel?.toJson());

    _localStorage.writeData(BoxKeys.listOfCards, list);
  }

  @override
  Future<List<CardModel>> getCard() async {
    List list = _localStorage.readData(BoxKeys.listOfCards) ?? [];

    List<CardModel> listCard = list.map((e) => CardModel.fromJson(e)).toList();

    return listCard;
  }

  @override
  Future<void> editeCard({required int index, CardModel? cardModel}) async {
    List list = _localStorage.readData(BoxKeys.listOfCards) ?? [];

    list[index] = cardModel?.toJson();

    _localStorage.writeData(BoxKeys.listOfCards, list);
  }

  @override
  Future<void> deleteCard(int index) async {
    List list = _localStorage.readData(BoxKeys.listOfCards) ?? [];

    list.removeAt(index);

    _localStorage.writeData(BoxKeys.listOfCards, list);
  }
}

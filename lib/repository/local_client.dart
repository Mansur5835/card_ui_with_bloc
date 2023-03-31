import 'package:credit_card_ui/data/local_sourses/local_storage.dart';
import 'package:credit_card_ui/data/models/card_model.dart';
import 'package:credit_card_ui/data/models/gradient_model.dart';

part 'local_client.g.dart';

abstract class LocalClient {
  factory LocalClient() {
    return _LocalClient();
  }

  Future<void> setGradient(GradientModel cardModel);

  Future<List<GradientModel>> getGradient();

  Future<void> deleteGradient(int index);

  Future<void> setBackImage(String imagePath);

  Future<List<String>> getBackImage();

  Future<void> deleteBackImage(int index);

  Future<void> setCard(CardModel? cardModel);

  Future<List<CardModel>> getCard();

  Future<void> editeCard({required int index, CardModel? cardModel});

  Future<void> deleteCard(int index);
}

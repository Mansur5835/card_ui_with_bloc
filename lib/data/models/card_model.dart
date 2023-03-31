import 'package:credit_card_ui/data/models/gradient_model.dart';
import '../constants/enums.dart';

class CardModel {
  String? name;
  String? icon;
  String? number;
  String? date;
  dynamic background;
  EntityType? entityType;

  CardModel(
      {this.date,
      this.icon,
      this.name,
      this.number,
      this.background,
      this.entityType});

  CardModel.fromJson(Map map) {
    name = map["name"];
    icon = map["icon"];
    date = map["date"];
    number = map["number"];
    entityType = stringToEnum(map["entityType"]);
    background = backToObject(map["background"]);
  }

  Map toJson() {
    return {
      "name": name,
      "icon": icon,
      "number": number,
      "date": date,
      "background": backToMap(background),
      "entityType": enumToString(entityType),
    };
  }

  dynamic backToMap(dynamic back) {
    if (back is GradientModel) return back.toJson();

    return back;
  }

  dynamic backToObject(dynamic back) {
    if (back is! String) return GradientModel.fromJson(back);

    return back;
  }

  String enumToString(EntityType? entityType) {
    switch (entityType) {
      case EntityType.image:
        return "image";
      case EntityType.gradient:
        return "gradient";
      case EntityType.blur:
        return "blur";
      case EntityType.fileImage:
        return "fileImage";
      default:
        return "blur";
    }
  }

  EntityType stringToEnum(String? entityType) {
    switch (entityType) {
      case "image":
        return EntityType.image;

      case "gradient":
        return EntityType.gradient;

      case "blur":
        return EntityType.blur;

      case "fileImage":
        return EntityType.fileImage;

      default:
        return EntityType.blur;
    }
  }
}

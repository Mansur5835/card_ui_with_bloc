import 'package:credit_card_ui/data/constants/enums.dart';
import 'package:credit_card_ui/data/models/aligment_model.dart';

class GradientModel {
  int? startColor;
  int? endColor;
  double? stopValue;
  double? radialValue;
  AligmentModel? startAligmentModel;
  AligmentModel? endAligmentModel;
  String? gradientType;

  GradientModel(
      {this.startAligmentModel,
      this.endColor,
      this.endAligmentModel,
      this.startColor,
      this.radialValue,
      this.stopValue,
      this.gradientType});

  Map toJson() {
    return {
      "startColor": startColor,
      "endColor": endColor,
      "radialValue": radialValue,
      "stopValue": stopValue,
      "gradientType": gradientType,
      "startAligmentModel": startAligmentModel?.toJson(),
      "endAligmentModel": endAligmentModel?.toJson(),
    };
  }

  GradientModel.fromJson(Map map) {
    startColor = map["startColor"];
    radialValue = map["radialValue"];
    endColor = map["endColor"];
    startAligmentModel = AligmentModel.fromJson(map["startAligmentModel"]);
    endAligmentModel = AligmentModel.fromJson(map["endAligmentModel"]);
    stopValue = map["stopValue"];
    gradientType = map["gradientType"];
  }
}

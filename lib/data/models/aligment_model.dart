import 'package:flutter/material.dart';

class AligmentModel {
  late double x;
  late double y;

  AligmentModel({this.y = 0, this.x = 0});

  AligmentModel.fromAligment(Alignment? alignment) {
    x = alignment?.x ?? 0;
    y = alignment?.y ?? 0;
  }

  AligmentModel.fromJson(Map map) {
    x = map["x"] ?? 0;
    y = map["y"] ?? 0;
  }

  Map<String, double> toJson() {
    return {"x": x, "y": y};
  }

  Alignment toAligmant() {
    return Alignment(x, y);
  }
}

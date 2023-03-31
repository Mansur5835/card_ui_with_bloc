import 'dart:io';
import 'dart:ui';
import 'package:credit_card_ui/data/constants/enums.dart';
import 'package:credit_card_ui/data/models/card_model.dart';
import 'package:credit_card_ui/data/models/gradient_model.dart';
import 'package:credit_card_ui/presentation/components/app_text.dart';
import 'package:credit_card_ui/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/utils/assets_meneger.dart';
import '../zoom_widget.dart';

class CardView extends StatelessWidget {
  const CardView(
      {super.key, required this.cardModel, this.entityType, this.background});
  final CardModel cardModel;
  final EntityType? entityType;
  final dynamic background;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Stack(children: [ZoomWidget(child: _backgrount()), _cardData()]),
    );
  }

  Widget _cardData() {
    return Container(
      width: double.infinity,
      height: 220,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 15),
            child: cardModel.icon != null
                ? Image.asset(
                    cardModel.icon!,
                    height: 70,
                    width: 70,
                  )
                : const SizedBox(
                    height: 70,
                    width: 70,
                  ),
          ),
          AppText(
            cardModel.name,
            color: AppColors.white,
            size: 18,
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              AppText(
                cardModel.number,
                color: AppColors.white,
                size: 21,
                fontWeight: FontWeight.w500,
              ),
              const Spacer(),
              AppText(
                cardModel.date,
                color: AppColors.white,
                size: 21,
                fontWeight: FontWeight.w500,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          AppText(
            cardModel.name,
            color: AppColors.white,
            size: 18,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _backgrount() {
    if ((entityType ?? cardModel.entityType) == EntityType.image) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            background ?? cardModel.background,
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if ((entityType ?? cardModel.entityType) == EntityType.fileImage) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.file(
            File(background ?? cardModel.background),
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if ((entityType ?? cardModel.entityType) == EntityType.gradient) {
      if ((cardModel.background is! GradientModel) && background == null) {
        return Container();
      }

      GradientModel gradientModel = background ?? cardModel.background;

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        height: 220,
        child: Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
            gradient: gradientModel.gradientType == "LINEAR"
                ? LinearGradient(
                    begin: gradientModel.startAligmentModel?.toAligmant() ??
                        const Alignment(0, 1),
                    end: gradientModel.endAligmentModel?.toAligmant() ??
                        const Alignment(0, -1),
                    stops: [
                        gradientModel.stopValue ?? 0,
                        1,
                      ],
                    colors: [
                        Color(gradientModel.startColor ??
                            AppColors.primaryColor.value),
                        Color(gradientModel.endColor ?? Colors.purple.value),
                      ])
                : RadialGradient(
                    radius: gradientModel.stopValue ?? 0,
                    colors: [
                      Color(gradientModel.startColor ??
                          AppColors.primaryColor.value),
                      Color(gradientModel.endColor ?? Colors.purple.value),
                    ],
                    center: Alignment(gradientModel.radialValue ?? 0, 0)),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 220,
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
              width: double.infinity,
              height: 220,
              alignment: Alignment.centerRight,
              child: Lottie.asset(AssetsManager.lottie(
                  name: background ?? cardModel.background))),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.1),
                        ]),
                    border: Border.all(color: Colors.white.withOpacity(0.13))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';
import 'package:credit_card_ui/core/utils/assets_meneger.dart';
import 'package:credit_card_ui/data/constants/enums.dart';
import 'package:credit_card_ui/presentation/components/animations/slide_and_opasity_animation.dart';
import 'package:credit_card_ui/presentation/components/animations/tween_anim.dart';
import 'package:credit_card_ui/presentation/components/app_bottom_sheet.dart';
import 'package:credit_card_ui/presentation/components/app_buttons.dart';
import 'package:credit_card_ui/presentation/components/app_dialog.dart';
import 'package:credit_card_ui/presentation/components/app_page_without_cubit.dart';
import 'package:credit_card_ui/presentation/components/app_text.dart';
import 'package:credit_card_ui/presentation/components/view/card_view.dart';
import 'package:credit_card_ui/presentation/components/view/warning_view.dart';
import 'package:credit_card_ui/presentation/pages/add_card/cubit/add_card_cubit.dart';
import 'package:credit_card_ui/presentation/pages/add_card_style/add_card_style_page.dart';
import 'package:credit_card_ui/presentation/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:credit_card_ui/presentation/routes/app_navigator.dart';
import 'package:credit_card_ui/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/input_formater.dart';
import '../../../data/constants/card_backgrounds.dart';
import '../../components/app_text_field.dart';
import '../../components/view/add_style_option_view.dart';

class AddCardPage extends AppPageWithoutCubit<AddCardCubit, AddCardState> {
  AddCardPage({super.key});

  @override
  Widget build(BuildContext context, state) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, dashState) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.black,
            elevation: 0,
            centerTitle: true,
            title: const AppText(
              "Add Your Card",
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: AppColors.black,
          body: Column(children: [
            _cardsStyle(state, dashState),
            Expanded(child: _cardForm(state)),
            const SizedBox(
              height: 60,
            ),
          ]),
        );
      },
    );
  }

  Widget _cardForm(AddCardState state) {
    return SingleChildScrollView(
      child: SlideAndOpasityAnimation(
        opasityDuration: 250,
        slideDuration: 500,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.blackGrey2,
              ),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        "Your Name",
                        color: AppColors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                      controller: cubit.name,
                      validator: InputFormoter.nameValidation,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                        LengthLimitingTextInputFormatter(30),
                        InputFormoter.upperCaseFormater,
                      ],
                      label: "FULL NAME",
                      onChanged: cubit.onName,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        "Card Number",
                        color: AppColors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                      controller: cubit.number,
                      textInputType: TextInputType.number,
                      validator: InputFormoter.numberValidation,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        InputFormoter.cardNumberFormater,
                      ],
                      label: "0000 0000 0000 0000",
                      onChanged: cubit.onCardNumber,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: AppText(
                        "Validity Date",
                        color: AppColors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: cubit.date,
                            textInputType: TextInputType.number,
                            validator: InputFormoter.dateValidation,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              InputFormoter.cardDateFormater,
                            ],
                            label: "MM/YY",
                            onChanged: cubit.onCardDate,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: PrimaryButton(
                          enabled: state.notEmpty,
                          onTap: () {
                            cubit.save();
                          },
                          title: "Save Card",
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardsStyle(AddCardState state, DashboardState dashState) {
    return TweenAnim<double>(
        begin: 240,
        end: dashState.keyboardIsOpened ? 0 : 240,
        duration: 400,
        child: (value) {
          return Opacity(
            opacity: dashState.keyboardIsOpened ? 0 : 1,
            child: SizedBox(
              height: value,
              child: PageView(
                controller: cubit.pageController,
                onPageChanged: cubit.onPage,
                children: [
                  ...List.generate(CardBackgounds.cardBackImages.length,
                      (index) {
                    if (index == cubit.index) {
                      cubit.setBackAndType(
                          back: CardBackgounds.cardBackImages[index],
                          entityType: EntityType.image);
                    }
                    return SlideAndOpasityAnimation(
                      slideBegin: const Offset(1, 0),
                      opasityDuration: 0,
                      slideDuration: ((index + 1) % 5) * 250,
                      child: CardView(
                        entityType: EntityType.image,
                        background: CardBackgounds.cardBackImages[index],
                        cardModel: state.cardModel ?? defaultmodel,
                      ),
                    );
                  }),
                  _blurBack(7, state),
                  ...List.generate(state.listOfGradients?.length ?? 0, (index) {
                    if ((8 + index) == cubit.index) {
                      cubit.setBackAndType(
                          back: state.listOfGradients?[index].toJson(),
                          entityType: EntityType.gradient);
                    }
                    return GestureDetector(
                      onTap: () {
                        AppDialog(
                          child: WarringView(
                            warningText: "Delete this Style?",
                            yesTab: () {
                              cubit.deleteStyleAction(index);
                            },
                          ),
                        ).show();
                      },
                      child: CardView(
                        background: state.listOfGradients![index],
                        entityType: EntityType.gradient,
                        cardModel: state.cardModel ?? defaultmodel,
                      ),
                    );
                  }),
                  ...List.generate(state.listOfBackImages?.length ?? 0,
                      (index) {
                    if ((8 + (state.listOfGradients?.length ?? 0)) + index ==
                        cubit.index) {
                      cubit.setBackAndType(
                          back: state.listOfBackImages![index],
                          entityType: EntityType.fileImage);
                    }
                    return GestureDetector(
                      onTap: () {
                        AppDialog(
                          child: WarringView(
                            warningText: "Delete this Style?",
                            yesTab: () {
                              cubit.deleteStyleAction(index,
                                  action: "BACKIMAGE");
                            },
                          ),
                        ).show();
                      },
                      child: CardView(
                        background: state.listOfBackImages![index],
                        entityType: EntityType.fileImage,
                        cardModel: state.cardModel ?? defaultmodel,
                      ),
                    );
                  }),
                  _addCardStyle()
                ],
              ),
            ),
          );
        });
  }

  Widget _blurBack(int index, AddCardState state) {
    if (index == cubit.index) {
      cubit.setBackAndType(back: "blob", entityType: EntityType.blur);
    }
    return CardView(
      background: "blob",
      entityType: EntityType.blur,
      cardModel: state.cardModel ?? defaultmodel,
    );
  }

  Widget _addCardStyle() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                AppBottomSheet(
                  height: 300,
                  child: AddStyleOptionView(
                    tabGradient: (isAdded) {
                      cubit.jumpToPage(isAdded);
                    },
                    tabImage: () {
                      cubit.pickImage();
                    },
                  ),
                ).show();
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: double.infinity,
                height: 220,
                alignment: Alignment.center,
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AssetsManager.icon(name: "add"),
                      width: 50,
                      height: 50,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          "Add Your Card",
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        AppText(
                          "Style",
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

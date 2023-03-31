import 'dart:ui';
import 'package:credit_card_ui/presentation/components/animations/slide_and_opasity_animation.dart';
import 'package:credit_card_ui/presentation/components/animations/tween_anim.dart';
import 'package:credit_card_ui/presentation/components/app_page_with_cubit.dart';
import 'package:credit_card_ui/presentation/pages/edit_card/cubit/edit_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/assets_meneger.dart';
import '../../../core/utils/input_formater.dart';
import '../../../data/constants/card_backgrounds.dart';
import '../../../data/constants/enums.dart';
import '../../components/app_bottom_sheet.dart';
import '../../components/app_buttons.dart';
import '../../components/app_dialog.dart';
import '../../components/app_text.dart';
import '../../components/app_text_field.dart';
import '../../components/view/card_view.dart';
import '../../components/view/warning_view.dart';
import '../../routes/app_navigator.dart';
import '../../styles/app_colors.dart';
import '../add_card/cubit/add_card_cubit.dart';
import '../add_card_style/add_card_style_page.dart';
import '../dashboard/cubit/dashboard_cubit.dart';

class EditCardPage extends AppPageWithCubit<EditCardCubit, EditCardState> {
  static const String route = "/edit_card_page";
  EditCardPage({super.key}) : super(bloc: EditCardCubit());

  @override
  Widget build(BuildContext context, state) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, dashState) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Center(
                  child: CustomButton.iconButton(
                      onTab: () {
                        AppDialog(
                            child: WarringView(
                          warningText: "Delete this card?",
                          yesTab: () {
                            cubit.delete();
                          },
                        )).show();
                      },
                      child: const Icon(Icons.delete)))
            ],
            backgroundColor: AppColors.black,
            elevation: 0,
            centerTitle: true,
            title: const AppText(
              "Edit Your Card",
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

  Widget _cardForm(EditCardState state) {
    return SlideAndOpasityAnimation(
      opasityDuration: 100,
      slideDuration: 500,
      child: SingleChildScrollView(
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
                        "Edit Name",
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
                        "Edit Card Number",
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
                        "Edit Validity Date",
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
                            cubit.edit();
                          },
                          title: "Edit Card",
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

  Widget _cardsStyle(EditCardState state, DashboardState dashState) {
    return SlideAndOpasityAnimation(
      opasityDuration: 100,
      slideDuration: 400,
      child: TweenAnim<double>(
          begin: 240,
          end: dashState.keyboardIsOpened ? 0 : 240,
          duration: 400,
          child: (value) {
            return Opacity(
              opacity: dashState.keyboardIsOpened ? 0 : 1,
              child: SizedBox(
                height: value,
                child: BlocBuilder<AddCardCubit, AddCardState>(
                  builder: (context, stateAddCard) {
                    return PageView(
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
                          return CardView(
                            entityType: EntityType.image,
                            background: CardBackgounds.cardBackImages[index],
                            cardModel: state.cardModel ?? defaultmodel,
                          );
                        }),
                        _blurBack(7, state),
                        ...List.generate(
                            stateAddCard.listOfGradients?.length ?? 0, (index) {
                          if ((8 + index) == cubit.index) {
                            cubit.setBackAndType(
                                back: stateAddCard.listOfGradients?[index]
                                    .toJson(),
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
                              background: stateAddCard.listOfGradients![index],
                              entityType: EntityType.gradient,
                              cardModel: state.cardModel ?? defaultmodel,
                            ),
                          );
                        }),
                        ...List.generate(
                            stateAddCard.listOfBackImages?.length ?? 0,
                            (index) {
                          if ((8 +
                                      (stateAddCard.listOfGradients?.length ??
                                          0)) +
                                  index ==
                              cubit.index) {
                            cubit.setBackAndType(
                                back: stateAddCard.listOfBackImages![index],
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
                              background: stateAddCard.listOfBackImages![index],
                              entityType: EntityType.fileImage,
                              cardModel: state.cardModel ?? defaultmodel,
                            ),
                          );
                        }),
                        _addCardStyle()
                      ],
                    );
                  },
                ),
              ),
            );
          }),
    );
  }

  Widget _blurBack(int index, EditCardState state) {
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
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            AppNavigator.back();
                            Future.delayed(Duration.zero, () async {
                              bool? isAdded = await AppNavigator.toNamed(
                                  AddCardStylePage.route);

                              cubit.jumpToPage(isAdded);
                            });
                          },
                          child: Hero(
                            tag: "gradient_style",
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              margin: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: AppColors.white),
                                  gradient: LinearGradient(colors: [
                                    AppColors.primaryColor,
                                    Colors.purple,
                                  ])),
                              child: AppText(
                                "Gradient Style",
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              cubit.pickImage();
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      AssetsManager.images(name: "back5"),
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    AppText(
                                      "Image Style",
                                      color: AppColors.white,
                                      size: 20,
                                    ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    )).show();
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

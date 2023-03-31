import 'package:flutter/material.dart';
import '../../../core/utils/assets_meneger.dart';
import '../../pages/add_card_style/add_card_style_page.dart';
import '../../routes/app_navigator.dart';
import '../../styles/app_colors.dart';
import '../app_text.dart';

class AddStyleOptionView extends StatelessWidget {
  const AddStyleOptionView(
      {super.key, required this.tabGradient, required this.tabImage});
  final Function(bool? isAdded) tabGradient;
  final Function() tabImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            AppNavigator.back();
            Future.delayed(Duration.zero, () async {
              bool? isAdded =
                  await AppNavigator.toNamed(AddCardStylePage.route);

              tabGradient(isAdded);
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
              AppNavigator.back();
              tabImage();
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
    );
  }
}

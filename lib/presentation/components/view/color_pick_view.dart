import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../core/utils/screen_size.dart';
import '../../routes/app_navigator.dart';
import '../../styles/app_colors.dart';
import '../app_buttons.dart';

class ColorPickView extends StatelessWidget {
  ColorPickView({super.key, required this.currentColor});
  final Color currentColor;

  Color _pickColor = Colors.black;

  void onChange(Color pickColor) {
    _pickColor = pickColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: ScreenSize.size.height - 100,
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: AppColors.blackGrey2,
            borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onChange,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                      size: Size(double.infinity, 50),
                      onTap: () {
                        AppNavigator.back();
                      },
                      label: "Cansel",
                      color: AppColors.primaryColor),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: PrimaryButton(
                    backGroundColor: AppColors.primaryColor,
                    onTap: () {
                      AppNavigator.back(result: _pickColor);
                    },
                    title: "Ok",
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

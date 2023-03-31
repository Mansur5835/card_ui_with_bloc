import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import 'app_text.dart';

class AppTab extends StatefulWidget {
  AppTab({
    super.key,
    required this.onTap,
    required this.title,
    this.isSelecded = false,
  });
  final String title;
  bool isSelecded;
  Function() onTap;

  @override
  State<AppTab> createState() => _AppSelectItemState();
}

class _AppSelectItemState extends State<AppTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
            border: widget.isSelecded
                ? null
                : Border.all(width: 2, color: AppColors.primaryColor),
            color:
                widget.isSelecded ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10)),
        child: AppText(widget.title, color: AppColors.white),
      ),
    );
  }
}

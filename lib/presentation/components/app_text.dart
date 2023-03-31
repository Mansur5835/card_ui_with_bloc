import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final double? size;
  final Color? color;
  final String? text;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextStyle? style;
  const AppText(this.text,
      {this.color, this.fontWeight, this.textAlign, this.size, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: style ??
          GoogleFonts.rubik(
            fontSize: size,
            color: color,
            fontWeight: fontWeight,
          ),
      textAlign: textAlign,
    );
  }
}

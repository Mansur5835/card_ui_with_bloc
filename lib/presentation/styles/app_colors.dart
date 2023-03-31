import 'package:flutter/material.dart';

import '../../core/extantions/hex_color.dart';

abstract class AppColors {
  static final Color primaryBack = HexColor("#000022");
  static final Color primaryColor = HexColor("#4A28E2");
  static final Color primaryColor08 = HexColor("#4A28E2").withOpacity(0.8);
  static final Color primaryColor04 = HexColor("#4A28E2").withOpacity(0.4);
  static final Color primaryColor02 = HexColor("#4A28E2").withOpacity(0.2);
  static final Color white = HexColor("#FFFDFA");
  static final Color black = HexColor("#1B1B1B");
  static final Color black05 = HexColor("#1B1B1B").withOpacity(0.5);
  static final Color black04 = HexColor("#1B1B1B").withOpacity(0.9);
  static final Color blackGrey = HexColor("#9C9E9F");
  static final Color grey = HexColor("#B4B4B8");
  static final Color grey1 = HexColor("#e7e7e7");
  static final Color primaryBlack = HexColor("#05050C");

  static final Color blackGrey2 = HexColor("#35383F");
  static final Color blackGrey1 = HexColor("#9C9E9F");

  static final Color primaryBlack1 = HexColor("#05050C");
  static final Color primaryBlack03 = HexColor("#05050C").withOpacity(0.3);
  static final Color primaryBlack2 = HexColor("#777787");
  static final Color primaryBlack3 = HexColor("#35383F");
}

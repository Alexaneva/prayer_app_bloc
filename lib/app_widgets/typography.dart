import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  static const fontFamily = 'Manrope';

  static const heading1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.grayScale800,
    fontSize: 24,
    height: 1.2,
  );
  static const heading2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    color: AppColors.grayScale800,
    fontSize: 18,
  );
  static const heading3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.grayScale800,
    fontSize: 16,
  );
  static const heading4 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.grayScale300,
    fontSize: 12,
  );
}

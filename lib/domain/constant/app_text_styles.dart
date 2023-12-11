import 'package:flutter/material.dart';
import 'package:kawanlama/domain/constant/app_sizes.dart';

export 'package:kawanlama/utilities/extension/app_text_styles_ext.dart';

class AppStyles {
  AppStyles._();

  static TextStyle get textXs => TextStyle(fontSize: FontSizes.s12);

  static TextStyle get textSm => TextStyle(fontSize: FontSizes.s14);

  static TextStyle get textMd => TextStyle(fontSize: FontSizes.s16);

  static TextStyle get textLg => TextStyle(fontSize: FontSizes.s18);

  static TextStyle get displayLg => TextStyle(fontSize: FontSizes.s28);
}
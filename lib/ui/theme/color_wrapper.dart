import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class ColorsWrapper {
  Color get colorTextFieldDefault;
  Color get colorTextFieldFocused;
  Color get colorHonoluluBlue;
  Color get colorWhite;
  Color get colorCultureWhite;
  Color get colorAzureWhite;
  Color get colorSilver;
  Color get colorAteneoBlue;
  Color get colorCarminePink;
  Color get colorBlack;
  Color get colorBlackGrey;
  Color get colorGraniteGrey;
  Color get colorLightBlue;
  Color get colorNavyBlue;
  Color get colorMidnightBlue;
  Color get colorDiamondBlue;
  Color get colorSkyBlue;
  Color get colorOffWhite;
  Color get colorAliceBlue;
  Color get colorCyberYellow;
  Color get colorKellyGreen;
  Color get colorYaleBlue;
  Color get colorEerieBlack;
  Color get colorDavyGrey;
  Color get colorBrightGray;
  Color get colorFrenchSkyBlue;
  Color get colorElectricRed;
  Color get colorOptionBorder;
  Color get colorElectricBlue;
  Color get colorLightSilver;
  Color get colorTaupeGray;
  Color get colorYankeeBlue;
  Color get colorVividOrange;
}

class AppThemeColors {
  ColorsWrapper get colors => AppColor();
}

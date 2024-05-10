import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';

class TextStyles {

  static const String poppins = 'Poppins';

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static TextStyle get embeddedLoaderTextStyle => TextStyle(
    inherit: false,
    color: AppColor().colorBlack,
    fontSize: 16,
    fontFamily: poppins,
    fontWeight: medium,
  );

  static TextStyle landingPageTitle = TextStyle(
      color: AppColor().colorBlackGrey,
      fontSize: 36,
      fontWeight: bold,
      fontFamily: poppins
  );

  static TextStyle landingPageSubTitle = TextStyle(
      color: AppColor().colorGraniteGrey,
      fontSize: 14,
      fontWeight: regular,
      fontFamily: poppins
  );

  static const TextStyle primaryButtonTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: medium,
      fontFamily: poppins,
      decoration: TextDecoration.none,
  );

  static TextStyle secondaryButtonTextStyle = TextStyle(
      color: AppColor().colorHonoluluBlue,
      fontSize: 16,
      fontWeight: medium,
      fontFamily: poppins
  );

  static const TextStyle loginTitleTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: medium,
      fontFamily: poppins
  );

  static TextStyle loginTNCTextStyleGray = TextStyle(
      color: AppColor().colorGraniteGrey,
      fontSize: 14,
      fontWeight: medium,
      fontFamily: poppins
  );

  static TextStyle loginTNCTextStyleBlue = TextStyle(
      color: AppColor().colorHonoluluBlue,
      fontSize: 14,
      fontWeight: medium,
      fontFamily: poppins,
  );

  static TextStyle textFieldTextStyle = TextStyle(
    color: AppColor().colorBlack,
    fontSize: 20,
    fontWeight: medium,
    fontFamily: poppins,
  );

  static TextStyle disabledTextFieldTextStyle = TextStyle(
    color: AppColor().colorSilver,
    fontSize: 16,
    fontWeight: medium,
    fontFamily: poppins,
  );

  static TextStyle textFieldHintTextStyle = TextStyle(
    color: AppColor().colorSilver,
    fontSize: 16,
    fontWeight: light,
    fontFamily: poppins,
  );

  static TextStyle errorMessage = TextStyle(
    color: AppColor().colorCarminePink,
    fontSize: 16,
    fontWeight: light,
    fontFamily: poppins,
  );

  static TextStyle otpResendActive = TextStyle(
    color: AppColor().colorHonoluluBlue,
    fontSize: 16,
    fontWeight: medium,
    fontFamily: poppins,
  );

  static TextStyle otpResendInActive = TextStyle(
    color: AppColor().colorGraniteGrey,
    fontSize: 16,
    fontWeight: medium,
    fontFamily: poppins,
  );

  static TextStyle otpTimerActive = TextStyle(
    color: AppColor().colorCarminePink,
    fontSize: 16,
    fontWeight: medium,
    fontFamily: poppins,
  );

  static TextStyle privacyPolicyTitle = TextStyle(
      color: AppColor().colorBlackGrey,
      fontSize: 24,
      fontWeight: semiBold,
      fontFamily: poppins
  );

  static TextStyle privacyPolicyDescription = TextStyle(
      color: AppColor().colorBlackGrey,
      fontSize: 16,
      fontWeight: regular,
      fontFamily: poppins
  );

  static TextStyle locationAccessHighlightText = TextStyle(
    color: AppColor().colorBlack,
    fontSize: 14,
    fontWeight: semiBold,
    fontFamily: poppins,
  );

  static TextStyle profileAppBarTitle = TextStyle(
    color: AppColor().colorWhite,
    fontSize: 20,
    fontWeight: bold,
    fontFamily: poppins,
  );

  static TextStyle editProfileAppBarTitle = TextStyle(
    color: AppColor().colorBlackGrey,
    fontSize: 20,
    fontWeight: semiBold,
    fontFamily: poppins,
  );

  static TextStyle profileFieldText = TextStyle(
    color: AppColor().colorWhite,
    fontSize: 14,
    fontWeight: regular,
    fontFamily: poppins,
  );

  static TextStyle profileMenuCardTitleText = TextStyle(
    color: AppColor().colorBlackGrey,
    fontSize: 14,
    fontWeight: regular,
    fontFamily: poppins,
  );

  static TextStyle segmentMaterialDefaultSelected = TextStyle(
    color: AppColor().colorWhite,
    fontSize: 16,
    fontWeight: medium,
    fontFamily: poppins,
  );

  static TextStyle segmentMaterialDefaultUnSelected = TextStyle(
    color: AppColor().colorHonoluluBlue,
    fontSize: 16,
    fontWeight: medium,
    fontFamily: poppins,
  );

  static TextStyle segmentCupertinoDefaultSelected = TextStyle(
    color: AppColor().colorBlack,
    fontSize: 13,
    fontWeight: bold,
    fontFamily: poppins,
  );

  static TextStyle segmentCupertinoDefaultUnSelected = TextStyle(
    color: AppColor().colorBlack,
    fontSize: 13,
    fontWeight: light,
    fontFamily: poppins,
  );

  static TextStyle timingSlotTextStyle = TextStyle(
    color: AppColor().colorBlackGrey,
    fontSize: 14,
    fontWeight: regular,
    fontFamily: poppins,
  );

  static TextStyle profilePicInitialTextStyle = TextStyle(
    color: AppColor().colorHonoluluBlue,
    fontSize: 48,
    fontWeight: semiBold,
    fontFamily: poppins,
  );

  static TextStyle tabBarActiveTextStyle = TextStyle(
    color: AppColor().colorHonoluluBlue,
    fontSize: 16,
    fontWeight: bold,
    fontFamily: poppins,
  );

  static TextStyle tabBarInActiveTextStyle = TextStyle(
    color: AppColor().colorBlackGrey,
    fontSize: 16,
    fontWeight: regular,
    fontFamily: poppins,
  );

  static TextStyle multipleMedicineSelectionTextStyle = TextStyle(
    color: AppColor().colorGraniteGrey,
    fontSize: 14,
    fontWeight: light,
    fontFamily: poppins,
  );

  static TextStyle subTitleTextStyle = TextStyle(
    color: AppColor().colorBlackGrey,
    fontSize: 16,
    fontWeight: medium,
    fontFamily: poppins,
  );

  static TextStyle snackBarTitleTextStyle = TextStyle(
    color: AppColor().colorBlack,
    fontSize: 16,
    fontWeight: medium,
    fontFamily: poppins,
  );

  static TextStyle snackBarSubTitleTextStyle = TextStyle(
    color: AppColor().colorBlack,
    fontSize: 16,
    fontWeight: regular,
    fontFamily: poppins,
  );

  static TextStyle upcomingDosageTextStyle = TextStyle(
    color: AppColor().colorOffWhite,
    fontSize: 10,
    fontWeight: regular,
    fontFamily: poppins,
  );

  static TextStyle tutorialDescTextStyle = TextStyle(
    color: AppColor().colorBlack,
    fontSize: 24,
    fontWeight: semiBold,
    fontFamily: poppins,
  );

  static TextStyle stepIndicatorTextStyle = TextStyle(
    color: AppColor().colorCultureWhite,
    fontSize: 14,
    fontWeight: semiBold,
    fontFamily: poppins,
  );

  static TextStyle puffPerDayTextStyle = TextStyle(
    color: AppColor().colorGraniteGrey,
    fontSize: 24,
    fontWeight: bold,
    fontFamily: poppins,
  );

  static TextStyle profileExtrasTextStyles = TextStyle(
    color: AppColor().colorFrenchSkyBlue,
    fontSize: 12,
    fontWeight: regular,
    fontFamily: poppins,
  );

  static TextStyle accountBlockedTextStyle = TextStyle(
      color: AppColor().colorHonoluluBlue,
      fontSize: 14,
      fontWeight: regular,
      fontFamily: poppins
  );

  static TextStyle reportSectionHeaderTextStyle = TextStyle(
      color: AppColor().colorYankeeBlue,
      fontSize: 18,
      fontWeight: medium,
      fontFamily: poppins
  );

  static TextStyle reportPercentTextStyle = TextStyle(
      color: AppColor().colorVividOrange,
      fontSize: 20,
      fontWeight: bold,
      fontFamily: poppins
  );

}
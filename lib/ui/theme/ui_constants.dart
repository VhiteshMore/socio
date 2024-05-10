import 'package:flutter/material.dart';

import 'color_wrapper.dart';

class UIConstants {

  static const borderShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30.0),
      ));

  static final borderTextFieldDefault = OutlineInputBorder(
    borderSide: BorderSide(color: AppThemeColors().colors.colorTextFieldDefault, width: 1.0),
    borderRadius: const BorderRadius.all(
      Radius.circular(8.0),
    ),
  );

  static final borderTextFieldFocused = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppThemeColors().colors.colorTextFieldFocused,
      width: 1.0,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(8.0),
    ),
  );

}
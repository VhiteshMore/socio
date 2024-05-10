import 'package:flutter/material.dart';

import '../../util/dialog_manager.dart';
import '../../util/widget_utility.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

class SoLoader {
  static Widget loaderWidget({double? height, double? width}) =>
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor().colorHonoluluBlue, width: 0.5)
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: WidgetUtility.spreadWidgets([
            const CircularProgressIndicator(),
            Text("Loading...", style: TextStyles.privacyPolicyDescription,)
          ], interItemSpace: 14),
        ),
      );

  static show(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          //useful when elevation is non zero and has bg color
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(120.0),
            ),
          ),
          content: Builder(
            builder: (context) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width / 12;
              return loaderWidget(height: 80, width: width);
            },
          ),
        ),
      ),
    );
  }

  static showLoader() {
    DialogManager.instance.showEasyDialog(builder: (context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Builder(
            builder: (context) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width / 6;
              return loaderWidget(height: 120, width: width);
            },
          ),
        ),
      );
    },);
  }

  static hide(context) {
    Navigator.of(context).pop();
  }

  static hideLoader() {
    DialogManager.instance.hideDialog();
  }
}
import 'package:flutter/material.dart';
import 'package:socio/constant/app_string_constants.dart';
import '../../util/dialog_manager.dart';
import '../../util/widget_utility.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

class SoDialogs {

  static Future showAlertDialog({
    required String title,
    required String description,
    VoidCallback? onCancelTap,
    VoidCallback? onOkayTap,
    String? primaryButtonTitle,
    String? secondaryButtonTitle,
    Function(BuildContext)? onOkayTapWithContext,
    Function(BuildContext)? onCancelTapWithContext,
  }) {
    return DialogManager.instance.showEasyDialog(
      barrierDismissible: true,
      builder: (context) {
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
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColor().colorHonoluluBlue,
                      )),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: WidgetUtility.spreadWidgets([
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                              child: Text(
                                title,
                                style: TextStyles.tabBarActiveTextStyle.copyWith(fontSize: 22),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Flexible(
                              child: Text(
                                description,
                                style: TextStyles.privacyPolicyDescription,
                              ))
                        ],
                      ),
                      Row(
                        children: WidgetUtility.spreadWidgets([
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                if (onCancelTapWithContext != null) {
                                  onCancelTapWithContext(context);
                                }
                                else if (onCancelTap != null) {
                                  onCancelTap();
                                }
                              },
                              child: Container(
                                height: 48,
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: AppColor().colorWhite, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColor().colorHonoluluBlue)),
                                child: Text(
                                  secondaryButtonTitle ?? AppStringConstants.secondaryButtonTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyles.secondaryButtonTextStyle,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                if (onOkayTapWithContext != null) {
                                  onOkayTapWithContext(context);
                                }
                                else if (onOkayTap != null) {
                                  onOkayTap();
                                }
                              },
                              child: Container(
                                height: 48,
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: AppColor().colorHonoluluBlue, borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  primaryButtonTitle ?? AppStringConstants.primaryButtonTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyles.primaryButtonTextStyle,
                                ),
                              ),
                            ),
                          ),
                        ], interItemSpace: 15),
                      )
                    ], interItemSpace: 24, flowHorizontal: false),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

}
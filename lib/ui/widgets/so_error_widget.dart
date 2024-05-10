import 'package:flutter/material.dart';
import 'package:socio/ui/theme/index.dart';

import '../../util/bottomsheet_manager.dart';
import '../../util/utils.dart';
import '../theme/ui_constants.dart';

class SoErrorWidget {

  static void showCIError({String? title, String? msg, bool isDismissible = true}) {
    BottomSheetManager.instance.showEasyModalBottomSheet(
      isDismissible: isDismissible,
      shape: UIConstants.borderShape,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor().colorHonoluluBlue,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                    20,
                  ),
                  topLeft: Radius.circular(
                    20,
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (Utils.isValidString(title)) Expanded(
                    flex: 8,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 40.0,bottom: 10.0, top: 10.0
                      ),
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: TextStyles.loginTNCTextStyleBlue.copyWith(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.close, size: 45,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            if (Utils.isValidString(msg)) Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                msg!,
                style: TextStyles.loginTNCTextStyleBlue.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        );
      },);
  }

}
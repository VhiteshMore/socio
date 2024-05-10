import 'package:flutter/material.dart';

import '../main.dart';

class BottomSheetManager {

  final BuildContext? _context = soNavigatorKey.currentContext;

  static final BottomSheetManager instance = BottomSheetManager();

  bool _showingBottomSheet = false;

  bool get isShowingBottomsheet => _showingBottomSheet;

  Future<T?> showEasyModalBottomSheet<T>({
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
  }) {
    _showingBottomSheet= true;
    return showModalBottomSheet(
      context: _context!,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
    ).then((value) {
      _showingBottomSheet= true;
      return null;
    });
  }
}
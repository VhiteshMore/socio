import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socio/ui/profile/profile_screen.dart';

typedef TabSwitch = void Function(Map<String, String>? params);

class TabSwitchEvent {

  final int switchToIndex;

  TabSwitchEvent({required this.switchToIndex});
}

class HomeTabBloc {

  static HomeTabBloc? _instance;

  TabController? _tabController;

  TabController? get tabController => _tabController;

  List<Widget> _screenWidgets = [];

  List<Widget> get screenWidgets => List.from(_screenWidgets,growable: false);

  HomeTabBloc._privateConstructor();

  static HomeTabBloc get instance {
    _instance = _instance ?? HomeTabBloc._privateConstructor();
    return _instance!;
  }

  void initialize(TickerProvider screen) {
    _tabController ??= TabController(length: 1, vsync: screen, initialIndex: 0);
    _addScreenWidgets();
  }

  void _addScreenWidgets() {
    _screenWidgets = [
      const ProfileScreen(),
    ];
  }

  void dispose() {
    _instance = null;
  }

}
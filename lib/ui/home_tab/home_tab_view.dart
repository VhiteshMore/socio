import 'dart:async';

import 'package:flutter/material.dart';
import 'bloc/home_tab_bloc.dart';

class HomeTabView extends StatefulWidget {

  const HomeTabView({Key? key}) : super(key: key);

  static const String route = "/HomeTabView";

  @override
  HomeTabViewState createState() => HomeTabViewState();
}

class HomeTabViewState extends State<HomeTabView> with TickerProviderStateMixin {

  final HomeTabBloc _homeBloc = HomeTabBloc.instance;
  final ValueKey convexAppBarKey = const ValueKey('convex_app_bar_key');

  @override
  void initState() {
    _homeBloc.initialize(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      key: convexAppBarKey,
      onWillPop: () {
        return Future.value(false);
      },
      child: body(),
    );
  }

  Widget body() {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          AnimatedBuilder(
            animation: _homeBloc.tabController!,
            builder: (context, _) {
              int currentIndex = _homeBloc.tabController!.index;
              return IndexedStack(
                index: currentIndex,
                children: _homeBloc.screenWidgets,
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              children: [
                Expanded(
                  child: TabBar(tabs: [
                    Tab(text: "Profile",)
                  ])
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}

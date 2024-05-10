import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socio/ui/onboarding/login_screen.dart';

import '../../bloc/session_bloc.dart';
import '../../util/service_locator.dart';
import '../../util/shared_preference_handler.dart';
import '../../util/user_data_helper.dart';

class SplashScreen extends StatefulWidget {
  static const route = "/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  UserDataHelper helper = injector<UserDataHelper>();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(const Duration(seconds: 3), () async{
        await helper.initialize();
        _getAppState();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: FlutterLogo(size: 100,),
          ),
        ),
      ),
    );
  }

  void _getAppState() async {
    if (await SessionBloc.isLoggedIn()) {
      // if (helper.userAccountNotifier!.value.status == UserStatus.REGISTERED) {
      //   Navigator.pushNamedAndRemoveUntil(context, PersonalDetailScreen.route, (route) => false, arguments: {Args.argIsRegistration: true});
      // } else {
      //   if (helper.userAccountNotifier!.value.isFirstTimeDosageSchedule != null) {
      //     if (!helper.userAccountNotifier!.value.isFirstTimeDosageSchedule!) {
      //       Navigator.pushNamedAndRemoveUntil(context, CongratulationsScreen.route, (route) => false,);
      //     } else {
      //       Navigator.of(context).pushNamedAndRemoveUntil(HomeTabView.route,(route) => false, arguments: {Args.newlyRegisteredUser : false});
      //     }
      //   } else {
      //     Navigator.pushNamedAndRemoveUntil(context, CongratulationsScreen.route, (route) => false,);
      //   }
      // }
    } else {
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route, (route) => false);
    }
  }
}

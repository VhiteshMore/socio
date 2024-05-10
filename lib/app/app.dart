import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socio/main.dart';
import 'package:socio/ui/home_tab/home_tab_view.dart';

import '../constant/args.dart';
import '../ui/onboarding/login_screen.dart';
import '../ui/onboarding/personal_details_screen.dart';
import '../ui/onboarding/splash_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: soNavigatorKey,
      title: 'Socio',
      debugShowCheckedModeBanner: kDebugMode,
      routes: {
        "/": (context) => const SplashScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        HomeTabView.route: (context) => const HomeTabView(),
      },
      onGenerateRoute: ((settings) {
        if (settings.name == PersonalDetailScreen.route) {
          final args = settings.arguments as Map;
          return MaterialPageRoute(
            builder: (context) => PersonalDetailScreen(
                isRegistration: args[Args.argIsRegistration],
                emailId: args[Args.argEmailId],
                uid: args[Args.argsUid]
            ),
          );
        }
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:socio/util/service_locator.dart';
import 'package:socio/util/shared_preference_handler.dart';

import 'app/app.dart';

final GlobalKey<NavigatorState> soNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  unawaited(
    runZonedGuarded<Future<void>>(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await init();
      await SharedPreferencesHandler.initialize();
      await Firebase.initializeApp();
      // await FirebaseAuth.instance.useAuthEmulator('192.168.0.231', 9099);
      // FirebaseFirestore.instance.useFirestoreEmulator('192.168.0.231', 8088);
      // FirebaseStorage.instance.useStorageEmulator('192.168.0.231', 9199);
      runApp(const App());
    }, (error, stack) {
      debugPrint("Error runZonedGuarded: $error");
    })
  );
}

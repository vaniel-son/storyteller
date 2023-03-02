import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storyteller/wrapper.dart';
import 'firebase_options.dart';

// TODO Apple:
// 1. add agora config
// 2. add video and camera config https://bettercoding.dev/flutter/tutorial-video-recording-and-replay/

void main() async {
  runZonedGuarded<Future<void>>(() async {

    ///Initialize Firebase services
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.black54,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      title: "Storyteller",
      home: const Wrapper(),
    ));

  }, (error, stack) => print('error: $error, stack: $stack'));

}


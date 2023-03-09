import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storyteller/screens/video_1p_v2/select_story_type_screen.dart';
import 'package:storyteller/screens/video_1p_v2/camera_screen.dart';
import 'package:storyteller/screens/what_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const WhatScreen();
    } else {
      return const SelectStoryTypeScreen();
    }
  }
}
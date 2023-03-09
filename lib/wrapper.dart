import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storyteller/models/user_model.dart';
import 'package:storyteller/screens/video_1p_v2/select_story_type_screen.dart';
import 'package:storyteller/screens/video_1p_v2/camera_screen.dart';
import 'package:storyteller/screens/what_screen.dart';
import 'package:storyteller/services/auth_service.dart';
import 'package:storyteller/services/database_service.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  // init for database services
  
  Future<bool> saveUserInLocalStorage() async {
    UserModel user = await AuthService.getUserFromSecureLocalStorage();
    if (user.uuid == null) {
      // user model doesn't contain data so add it
      final DatabaseServices databaseServices = DatabaseServices();
      String userName = await databaseServices.fetchUserName(uuid: FirebaseAuth.instance.currentUser!.uid);
      await AuthService.storeUserInSecureLocalStorage(uuid: FirebaseAuth.instance.currentUser!.uid, userName: userName);
      return true;
    } else {
      return true;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const WhatScreen();
    } else {
      return FutureBuilder<bool>(
          future: saveUserInLocalStorage(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return const SelectStoryTypeScreen();
            } else {
              return const CircularProgressIndicator();
            }
          });
    }
  }
}
import 'dart:developer';
// import 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:openai_client/openai_client.dart';
import 'package:uuid/uuid.dart';
import '../env/env.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:storyteller/services/general_service.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureLocalStorageService {
  // Initialize DB object with methods to call DB

  /// Constructor
  SecureLocalStorageService() {
    //
  }

  final storage = const FlutterSecureStorage();

  Future<String?> getSecureStorage({required String key}) {
    Future<String?> value = storage.read(key: key);
    return value;
  }

  Future<void> setSecureStorage({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<void> deleteSecureStorage() async {
    await storage.deleteAll();
  }

  Future<void> deleteSecureStorageItem({required String key}) {
    Future<void> value = storage.delete(key: key);
    return value;
  }
}

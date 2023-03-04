import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/models/user_model.dart';
import 'package:storyteller/services/local_storage_service.dart';
import 'package:storyteller/wrapper.dart';

class AuthService {

  static User? getUser() {
    //return FirebaseAuth.instance.currentUser != null ?  FirebaseAuth.instance.currentUser : null;
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      return null;
    } else {
      return auth.currentUser;
    }
  }

  // Use this method on each page where login is required
  static checkUserLoginStatus(context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      return Navigator.pushAndRemoveUntil(
          context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: const Wrapper()), (
          Route<dynamic> route) => false);
    } else {
      return true;
    }
  }

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  static Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    // delete uuid and username from secure local storage
    SecureLocalStorageService secureLocalStorageService = SecureLocalStorageService();
    secureLocalStorageService.deleteSecureStorageItem(key: 'uuid');
    secureLocalStorageService.deleteSecureStorageItem(key: 'userName');
  }

  static Future<void> storeUserInSecureLocalStorage({required String uuid, required String userName}) async {
    SecureLocalStorageService secureLocalStorageService = SecureLocalStorageService();

    await secureLocalStorageService.setSecureStorage(key: 'uuid', value: uuid);
    await secureLocalStorageService.setSecureStorage(key: 'userName', value: userName);
  }

  static Future<UserModel> getUserFromSecureLocalStorage() async {
    SecureLocalStorageService secureLocalStorageService = SecureLocalStorageService();

    String? uuid = await secureLocalStorageService.getSecureStorage(key: 'uuid');
    String? userName = await secureLocalStorageService.getSecureStorage(key: 'userName');

    UserModel user = UserModel(
      uuid: uuid,
      userName: userName,
    );

    return user;
  }
}



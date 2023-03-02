import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  /// ***********************************************************************
  /// ***********************************************************************
  /// Examples
  /// ***********************************************************************
  /// ***********************************************************************

  /// Get example
  Future<String> fetchNickname({userID}) async {
    final nicknameQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('User_ID', isEqualTo: userID)
        .get();

    if (nicknameQuery.docs.isEmpty) {
      return 'Default';
    } else {
      var result = nicknameQuery.docs.first.data();
      return result['Nickname'];
    }
  }

  /// Get snapshots example
  Stream<QuerySnapshot> fetchAllUsers() {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection('users')
        .snapshots();

    var result;
    result = dataStream;
    return result;
  }

  /// Update Example
  updateNickname({required String userID, required nickname}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(userID).update({'Nickname': nickname});
  }

  /// Add new record example
  ///Create User record in database.
  Future<void> addUser(uid, nickname) async {
    /// collection reference to query users table
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user
    return await userCollection
        .doc(uid)
        .set({
      'User_ID': uid, // John Doe
      'Nickname': nickname, // Stokes and Sons
      'Date_Created': DateTime.now(),
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  /// Store file in firebase storage


  /// Retrieve file in firebase storage

  /// ***********************************************************************
  /// ***********************************************************************
  /// TBD
  /// ***********************************************************************
  /// ***********************************************************************



}
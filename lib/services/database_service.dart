import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  /// ***********************************************************************
  /// ***********************************************************************
  /// Examples
  /// ***********************************************************************
  /// ***********************************************************************

  /// Get example
  Future<String> getExample({userID}) async {
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

  /// Add new user to users collection
  Future<void> addExample(uid, nickname) async {
    // reference to query users table
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

    // add a new user
    return await userCollection
        .doc(uid)
        .set({
      'uuid': uid, // John Doe
      'username': nickname, // Stokes and Sons
      'dateCreated': DateTime.now(),
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  /// Get snapshots example
  Stream<QuerySnapshot> getSnapshotExample() {
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

  /// Store file in firebase storage


  /// Retrieve file in firebase storage

  /// ***********************************************************************
  /// ***********************************************************************
  /// Users
  /// ***********************************************************************
  /// ***********************************************************************

  /// Add new user to users collection
  Future<void> addUser({required String uuid, required String userName}) async {
    // reference to query users table
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

    // add a new user
    return await userCollection
        .doc(uuid)
        .set({
      'uuid': uuid, // John Doe
      'username': userName, // Stokes and Sons
      'dateCreated': DateTime.now(),
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // get username for a user
  Future<String> fetchUserName({uuid}) async {
    final userNameQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('uuid', isEqualTo: uuid)
        .get();

    if (userNameQuery.docs.isEmpty) {
      return 'Default';
    } else {
      var result = userNameQuery.docs.first.data();
      return result['username'];
    }
  }

  /// ***********************************************************************
  /// ***********************************************************************
  /// Other (TBD)
  /// ***********************************************************************
  /// ***********************************************************************

  Future<void> saveSession(uid, nickname) async {
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

}
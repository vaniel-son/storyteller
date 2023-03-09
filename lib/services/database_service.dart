import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storyteller/models/your_story_model.dart';
import 'package:storyteller/services/general_service.dart';

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

  Future<void> saveSession({uuid, userName, videoURL, sessionType, storyType, storyPromptType, storyPrompt}) async {
    /// collection reference to query users table
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('storySessions');

    String documentID = GeneralService.randomUUID();

    // Call the user's CollectionReference to add a new user
    return await userCollection
        .doc(documentID) // create a random id for doc name
        .set({
      'id': documentID,
      'uuid': uuid,
      'userName': userName,
      'sessionType': sessionType, // ex. solo, actors, twoPlayers, etc. See SessionTypes in constants.dart
      'storyPromptType': storyPromptType, // ex. pregnancy, parent of toddler, etc. See StoryPromptTypes in constants.dart
      'storyPrompt': storyPrompt,
      'dateCreated': DateTime.now(),
      'videoURL': videoURL,
    })
        .then((value) => print("story session Added"))
        .catchError((error) => print("Failed to story session: $error"));
  }

  // Query firebase to return a collection of documents and then convert that to a list of maps
  Future<List<YourStoryModel>> getPlayerStories({required String uuid}) async {
    final playerStoryListResults = await FirebaseFirestore.instance
        .collection('storySessions')
        .where('uuid', isEqualTo: uuid)
        .orderBy('dateCreated', descending: true)
        .limit(10)
        .get();

    List<YourStoryModel> result = [];
    if (playerStoryListResults.docs.isNotEmpty) {
      for (var doc in playerStoryListResults.docs) {
        //result.add(doc.data());

        // add to story session model
        YourStoryModel yourStoryModel = YourStoryModel(
          id: doc.data()['id'],
          sessionType: doc.data()['sessionType'],
          storyPrompt: doc.data()['storyPrompt'],
          storyPromptType: doc.data()['storyPromptType'],
          userName: doc.data()['userName'],
          videoURL: doc.data()['videoURL'],
        );
        result.add(yourStoryModel);

        print('yourStoryModel: ${yourStoryModel.id}');
      }
    }

    return result;
  }

}
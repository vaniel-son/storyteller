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

class GeneralService {
  // Initialize DB object with methods to call DB

  /// Constructor
  GeneralService() {
    //
  }

  static displaySnackBar(BuildContext context, String message) {
  }

  Future<void> openAIService(context) async {
    // Load app credentials from environment variables or file.
    final configuration = await loadConfigurationFromEnvFile(context);

    // Create a new client.
    final client = OpenAIClient(
      configuration: configuration,
      enableLogging: true,
    );

    // Fetch the models.
    final models = await client.models.list().data;
    // Print the models list.
    print(models.toString());

    // Fetch a model by ID.
    final modelId = await client.models.byId(id: 'text-davinci-002').data;
    // Print the model.
    print(modelId.toString());

    // Create a completion.
    final completion = await client.completions
        .create(
      model: 'text-davinci-002',
      prompt: 'Batman was sleeping in his room when suddenly',
    )
        .data;
    // Print the completion.
    print(completion.toString());

    // Create an edit.
    final edit = await client.edits
        .create(
      model: 'text-davinci-edit-001',
      instruction: 'Fix the spelling mistakes',
      input: 'Batmaen and Robin were playing ches in the Batcave',
    )
        .data;
    // Print the edit.
    print(edit.toString());

    // Create an image.
    final image = await client.images
        .create(
      prompt: 'Batman is walking down the street with his friends',
      n: 2,
    )
        .data;
    // Print the image.
    log(image.toString());

    // Create an embedding.
    final embedding = await client.embeddings.create(
      model: 'text-similarity-babbage-001',
      input: ['Batman was talking to Alfred'],
    ).data;
    // Print the embedding.
    print(embedding.toString());

    final moderation =
    await client.moderations.create(input: 'Batman is a bad boy').data;
    // Print the moderation.
    print(moderation.toString());

    // Close the client and terminate the [http] connection.
    client.close();
  }

  /// Loads [OpenAIConfiguration] from environment variables
  Future<OpenAIConfiguration> loadConfigurationFromEnvFile(BuildContext context) async {
    return const OpenAIConfiguration(
      apiKey: Env.openAIKey,
      //organizationId: json['OPENAI_ORG_ID'] as String,
    );
  }

  static randomUUID(){
    var uuidObject = const Uuid();
    var uuid = uuidObject.v4();
    return uuid;
  }

  static Future<String> uploadVideo(String filePath) async {
    File file = File(filePath); // set file object
    var videoUUID = GeneralService.randomUUID(); // create a new uuid for video file name
    var videoName = videoUUID + '.mp4'; // set video file name

    late String firebaseURL; // stores the url of the file's location in firebase
    final firebaseStorage = FirebaseStorage.instance;

    try {
      var snapshot = await firebaseStorage.ref().child('videos/$videoUUID.mp4').putFile(File(filePath));
      firebaseURL = await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('upload error');
      print(e);
    }

    return firebaseURL;
  }
}

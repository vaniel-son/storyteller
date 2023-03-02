import 'dart:developer';

import 'package:openai_client/openai_client.dart';
import '../env/env.dart';

class OpenAIService {
  // Initialize DB object with methods to call DB

  /// Constructor
  OpenAIService() {
    //
  }

  Future<String> completion(String text) async {
    // Load app credentials from environment variables or file.
    final configuration = await loadConfigurationFromEnvFile();

    // Create a new client.
    final client = OpenAIClient(
      configuration: configuration,
      enableLogging: true,
    );

    // Create a completion.
    final completion = await client.completions
        .create(
      model: 'text-davinci-002',
      prompt: 'Rewrite this story so it has a beginning, middle, climax and end: $text',
      maxTokens: 100,
    ).data;

    // Print the completion.
    print('***********');
    print(completion.toMap());
    print('***********');

    Map dataMap = completion.toMap();
    String dataString = dataMap['choices'][0]['text'];


    // Close the client and terminate the [http] connection.
    client.close();

    return dataString;


  }

  Future<void> openAIServiceTest() async {
    // Load app credentials from environment variables or file.
    final configuration = await loadConfigurationFromEnvFile();

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
      prompt: 'Rewrite this so it sounds like David Mamet said this: He woke up tired.',
    ).data;

    // Print the completion.
    print('***********');
    print(completion.toString());
    print('***********');

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
  Future<OpenAIConfiguration> loadConfigurationFromEnvFile() async {
    return const OpenAIConfiguration(
      apiKey: Env.openAIKey,
      //organizationId: json['OPENAI_ORG_ID'] as String,
    );
  }
}

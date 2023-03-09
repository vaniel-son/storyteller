// model for firebase collection 'storySessions'

class YourStoryModel {
  YourStoryModel({
    this.id = 'none',
    this.sessionType = 'none',
    this.storyPrompt = 'none',
    this.storyPromptType = 'none',
    this.userName = 'none',
    this.videoURL = 'none',
  });

  String id;
  String sessionType; // ex. solo, actors, 2players
  String storyPrompt; // a story prompt the player will respond to
  String storyPromptType; // the category of the story prompt the player will respond to. Ex. pregnancy, general
  String userName;
  String videoURL;

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'sessionType': sessionType,
      'storyPrompt': storyPrompt,
      'storyPromptType': storyPromptType,
      'userName': userName,
      'videoURL': videoURL,
    };
  }

}

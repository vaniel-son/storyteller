class StorySessionModel {
  StorySessionModel({
    this.create = true,
    this.storyPrompt = 'none',
    this.roomName = 'none',
    this.storyPromptType = 'none',
    this.sessionType = 'none',
  });

  bool create; // true = creating a new room, false = joining a room
  String storyPrompt; // a story prompt the player will respond to
  String roomName; // the name of the room the player is creating or joining
  String storyPromptType; // the category of the story prompt the player will respond to
  String sessionType; // ex. solo, actors, 2players

  Map<String, dynamic> toMap(){
    return {
      'create': create,
      'playerPrompt': storyPrompt,
      'roomName': roomName,
      'playerPromptCategory': storyPromptType,
      'sessionType': sessionType,
    };
  }

}

class StorySessionModel {
  StorySessionModel({
    this.create = true,
    this.playerPrompt = 'none',
    this.roomName = 'none',
    this.playerPromptCategory = 'none',
    this.sessionType = 'none',
  });

  bool create; // true = creating a new room, false = joining a room
  String playerPrompt; // a story prompt the player will respond to
  String roomName; // the name of the room the player is creating or joining
  String playerPromptCategory; // the category of the story prompt the player will respond to
  String sessionType; // ex. solo, actors, 2players

  Map<String, dynamic> toMap(){
    return {
      'create': create,
      'playerPrompt': playerPrompt,
      'roomName': roomName,
      'playerPromptCategory': playerPromptCategory,
      'sessionType': sessionType,
    };
  }

}

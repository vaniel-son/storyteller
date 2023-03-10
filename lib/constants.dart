class StoryPromptType {
  static const String pregnancy = 'pregnancy';
  static const String parentOfToddler = 'parent of toddler';
  static const String parentOfAnAdult = 'parent of an adult';
  static const String general = 'general';
  static const String acting = 'acting';
}

class SessionType {
  static const String solo = 'solo'; // record a solo video and answer a story prompt
  static const String actors = 'actors'; // two player video chat with a script for the two to act out
  static const String twoPlayers = 'twoPlayers'; // two player video chat where each tell a story
  static const String soloCampaign = 'soloCampaign'; // prompts in a tailored sequence
  static const String twoPlayerCampaign = 'twoPlayerCampaign'; // two player video chat work together to tell a story
}
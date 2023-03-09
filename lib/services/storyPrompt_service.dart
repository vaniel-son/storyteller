import 'dart:developer';
import 'dart:math';
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
import 'package:storyteller/constants.dart' as constants;

class StoryPromptService {
  // Initialize DB object with methods to call DB

  /// Constructor
  StoryPromptService() {
    //
  }

  String setStoryPrompt(storyPromptType) {
    if (storyPromptType == constants.StoryPromptType.pregnancy) {
      return getRandomPregnancyStoryPrompt();
    } else if (storyPromptType == constants.StoryPromptType.parentOfToddler) {
      return getRandomParentOfToddlerStoryPrompt();
    } else if (storyPromptType == constants.StoryPromptType.general) {
      return getRandomGeneralStoryPrompt();
    } else {
      return 'error';
    }
  }

  String getRandomPregnancyStoryPrompt(){
    String storyPrompt1 = 'a surprising moment this week about pregnancy';
    String storyPrompt2 = 'who made you feel grateful this week';
    String storyPrompt3 = 'who you could throw into a dumpster';
    String storyPrompt4 = 'your food cravings';
    String storyPrompt5 = 'someone interesting you met';
    String storyPrompt6 = 'when you found out the gender of your baby';
    String storyPrompt7 = 'something exciting about being pregnant';
    String storyPrompt8 = 'What has been challenging about being pregnant?';
    String storyPrompt9 = 'Who is the most supportive person during pregnancy?';
    String storyPrompt10 = 'Who is the most annoying person during pregnancy?';
    String storyPrompt11 = 'How do you feel this week?';
    String storyPrompt12 = 'What milestones have been achieved lately?';
    String storyPrompt13 = 'I felt [fill in the blank] when I saw my first ultrasound';
    String storyPrompt14 = 'How are you figuring out your baby\'s name?';
    String storyPrompt15 = 'What was it like when you told your parents you were pregnant?';
    String storyPrompt16 = 'What symptoms do you have today?';
    String storyPrompt17 = 'What is on your list of baby names?';
    String storyPrompt18 = 'What did you never know about pregnancy?';
    String storyPrompt19 = 'What is the most surprising thing about pregnancy?';
    String storyPrompt20 = 'What was your last doctors visit like?';
    String storyPrompt21 = 'I felt [fill in the blank] when I found out we were having a boy/girl';
    String storyPrompt22 = 'WHen I see other babies, it makes me feel [fill in the blank]';
    String storyPrompt23 = 'What about becoming a parent thrills you the most?';
    String storyPrompt24 = 'What do you want to let go of before having children?';
    String storyPrompt25 = 'What do you want to hold on to before having children?';
    String storyPrompt26 = 'Which of your childhood memories gives you the most comfort?';
    String storyPrompt27 = 'Tell the story of when you found out you were pregnant';

    List storyPrompt = [storyPrompt1,
      storyPrompt2,
      storyPrompt3,
      storyPrompt4,
      storyPrompt5,
      storyPrompt6,
      storyPrompt7,
      storyPrompt8,
      storyPrompt9,
      storyPrompt10,
      storyPrompt11,
      storyPrompt12,
      storyPrompt13,
      storyPrompt14,
      storyPrompt15,
      storyPrompt16,
      storyPrompt17,
      storyPrompt18,
      storyPrompt19,
      storyPrompt20,
      storyPrompt21,
      storyPrompt22,
      storyPrompt23,
      storyPrompt24,
      storyPrompt25,
      storyPrompt26,
      storyPrompt27,
    ];

    int randomNumber = GeneralService.getRandomNumber(29);
    if (randomNumber > 27) {
      randomNumber = 27;
    }

    return storyPrompt[randomNumber];
  }

  String getRandomGeneralStoryPrompt(){
    String storyPrompt1 = '2Surprising moment this week about pregnancy';
    String storyPrompt2 = '2Who made you feel grateful this week';
    String storyPrompt3 = '2Who you could throw into a dumpster';
    String storyPrompt4 = '2Your food cravings this past week';
    String storyPrompt5 = '2Someone interesting you met this week';

    List storyPrompt = [storyPrompt1, storyPrompt2, storyPrompt3, storyPrompt4, storyPrompt5];

    int randomNumber = GeneralService.getRandomNumber(6);
    if (randomNumber > 4) {
      randomNumber = 4;
    }

    return storyPrompt[randomNumber];
  }

  String getRandomParentOfToddlerStoryPrompt(){
    String storyPrompt1 = '3Surprising moment this week about pregnancy';
    String storyPrompt2 = '3Who made you feel grateful this week';
    String storyPrompt3 = '3Who you could throw into a dumpster';
    String storyPrompt4 = '3Your food cravings this past week';
    String storyPrompt5 = '3Someone interesting you met this week';

    List storyPrompt = [storyPrompt1, storyPrompt2, storyPrompt3, storyPrompt4, storyPrompt5];

    int randomNumber = GeneralService.getRandomNumber(6);
    if (randomNumber > 4) {
      randomNumber = 4;
    }

    return storyPrompt[randomNumber];
  }
}

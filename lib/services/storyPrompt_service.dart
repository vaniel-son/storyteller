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
    } else if (storyPromptType == constants.StoryPromptType.acting) {
      return getRandomActingStoryPrompt();
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
    String storyPrompt1 = 'I am... [fill in the blank]';
    String storyPrompt2 = 'Throughout my life, I have been haunted by [fill in the blank]';
    String storyPrompt3 = 'Everywhere I go, I [fill in the blank]';
    String storyPrompt4 = 'I secretly love [fill in the blank]';
    String storyPrompt5 = 'I secretly hate [fill in the blank]';

    List storyPrompt = [storyPrompt1, storyPrompt2, storyPrompt3, storyPrompt4, storyPrompt5];

    int randomNumber = GeneralService.getRandomNumber(6);
    if (randomNumber > 4) {
      randomNumber = 4;
    }

    return storyPrompt[randomNumber];
  }

  String getRandomActingStoryPrompt(){
    String storyPrompt1 = ''
        'Jeff is a security guard working the night shift in a lobby of an apartment building.'
        'William, his supervisor, is a stickler for doing everything right, for following rules and living an honest clean life.'
        'It is a philosophy that has paid off for him (he became youngest captain in history of the security firm),'
        'and he is proud of how different he is from his irresponsible brother, who was arrested earlier in the day.'
        'But tonight, as Williams enter the lobby on his usual rounds, something is clearly bothering him.\n\n'
        'It has been an odd night for Jeff, who is a bit of an oddball and misfit-- and not a stickler for following rules.'
        'Just before William arrived, Jeff spent time talking to an attractive young female police officer who was waiting in the lobby for her partner'
        ', a seasons cop who has she has fallen in love with. Jeff wound up telling her that her partner was actually visiting a prostitute in the building.'
        'William arrives just after the two police officers have left.\n\n'
        '\n\nWIlliam enters onto the street and comes into the lobby.\n\n\n\n'
        'Jeff: Hey, William. How you doing?\n\n'
        'William: Hello, Jeff. How\'s it going? \n\n'
        'Jeff: Pretty good. The police were just here, but they didn\'t ask about you, and I signed them right in. It was that cop Bill and his partner. He said tell William Bill says hi. \n\n'
        'William: Was that all? \n\n'
        'Jeff: That was all \n\n'
        'William: (Sitting down) Ok...\n\n'
        'Jeff: Oh, yeah, and I told Manuel to clean up his desk.\n\n'
        'William: (Takes out cigarette) What? \n\n'
        'Jeff: I said, I told Manuel to clean up the desk -- to straighten up his desk drawers \n\n'
        'William: Oh yeah, yeah, thank you. \n\n'
        'Jeff: I really laid into him, too, because this desk is disgusting. I mean, when you open this drawer it should be spotless. I told him I want to be able to eat my breakfast outta this drawer tomorrow morning. I told him you were ready to kill somebody about these drawers. I really did. \n\n'
        'William: Ok, Jeff. Thanks.  \n\n'
        'Jeff: You\'re welcome. Taken care of. (long pause) You\'re not very chatt tonight... \n\n'
        'William: What? \n\n'
        'Jeff: I said you\'re not very chatty tonight. You\'re not really holding up your end of the conversation very well. \n\n'
        'William: Sorry, Jeff. I\'ve got a lot on my mind. \n\n'
        'Jeff: That\'s OK. We don\'t have to talk about anything. I\'m just glad to see your smiling face. \n\n'
        'William: Same here, Jeff. You just keep talking. If I hear anything worth responding to I\'ll just jump in. \n\n'
        'Jeff: Ok. (pause) How\'s your brother doing? \n\n'
        'William: I don\'t know. I haven\'t spoken to him. \n\n'
        'Jeff: Did you find out what he did? Oh no, you knew what he did, you just didn\'t want to tell me about it. I forgot. That is completely fine. I don\'t mean to sound so inquisitive. I\'m sorry. (pause) So did you see where the mayor says he\'s gonna shut down all the --\n\n'
        'William: .. All right, let me ask you something, Jeff. Suppose somebody who\'s supposed to be near and dear to you was accused of donig some kidn of terrible crime, and was trying to use you as an alibi. What would you do, for example, if it was a false alibi? WThat is to say, you weren\'t with the person when they said that you were? \n\n'
        'Jeff: I don\'t know. I guess it would depend on who they were and what... \n\n'
        'William: Yeah, you see, we already part company. I like to tell the truth. \n\n'
        'Jeff: Well, so do I...\n\n'
        'William: What are you talking about, man? I didn\'t even get through the details of the hypothetical situation and you\'re already gearing up to perjure yourself. \n\n'
        'Jeff: No I\'m not. I was just.. I mean if it was my mother or something... \n\n'
        'William: Right, because that\'s what everybody expects, right? But that\'s where I part company with 95% of the human race. So I\'m a freak. But I wouldn\'t do it.\n\n'
        'Jeff: Are you talking.. I assume you\'re talking about your brother? \n\n'
        'William: It doesn\'t matter who I\'m talking about.\n\n'
        'Jeff: So but what did he do?\n\n'
        'William: I don\'t know what he did, man, because he hasn\'t been tried in a court of law.\n\n'
        'Jeff: What are you, some kind of Robotron? What did they accuse him of?\n\n'
        '\n\n (Pause.)\n\n'
        'William: THey say.. they arrested him and two friends for allegedly going into a hospital last night to steal pharmaceutical drugs, and some nurse apparently saw them and they attacked her...\n\n'
        'Jeff: Oh my God... \n\n'
        'William: ... and they beat her up with a pipe or something like that and now she\'s dead\n\n'
        'Jeff: Oh my God... \n\n'
        'William: ... And according to my brother\'s girlfriend, my brother told the police I was with him at the time at some movie.\n\n'
        'Jeff: Wow. \n\n'
        'William: Yeah, gave her a whole made-up schedule what we were supposedly doing last night for me to memorize: what movie, who called who, what time we ate, who ate what, you wouldn\'t believe it. See, he can\'t handle getting a job or applying himself to go to school, but he has the wherewithal to come up with that shit on the spur of the moment when he\'s in the jailhouse under arrest for murder at two oclock in the morning.\n\n'
        'Jeff: Wow. \n\n'
        'William: Wow. \n\n'
        'Jeff: Well, I would -- I mean, God, I mean -- do you--\n\n'
        'William: And it\'s not like... See, his girlfriend called me tonight, and apparently two of my brother\'s friends--these real criminals, mind--were identified by some doctor, and the cops picked them up and they named my brother as the third guy. But the doctor didn\'t really get a good look at him, so they\'re trying to dig up something substantial that would link him to the scene. And meanwhile my brother says he was at home alone, with no alibi, and so would I say he was at the movies with me last night?\n\n'
        'Jeff: Jesus Christ. \n\n'
        'William: See, I don\'t think he\'d ever od anything that fuckin\' heinous, but he\' definitely done a lot of other shit. And I know these guys he\' always with, and... You know, I want to be objective about it, to some degree. I want to... I can\'t just be saying, \'Well, seeing how he\'s my brother, it is therefore impossible for him to have done this ghastly thing.\' You know what I mean? \n\n'
        'Jeff: Yeah...\n\n'
        'William: I just wish I had more information. But who am I gonna talk to? His girlfriend? She just parrots everything he says, she\'s got no will of her own. And what\'s he gonna tell me? That he\'s guilty? He knows what I\'ll do then.\n\n'
        'Jeff: Yeah... Wow\n\n'
        'William: And I am not the type of person who sympathizes with the criminal element in this kind of situation. Not at all. But the fact remains that there\'s a lot of people in jail who don\'t belong there, a lot of black people in jail who don\'t belong there, and a lot of cops and prosecutors and what have you who just as soon throw somebody in jail as nobody. And I hate to say it, but my brother is tailor made for the part, and if he\'s being railroaded in some way, I don\'t know what right I may hve to my privat eresrevations. So it\'s an interesting dilemma. It\'s interesting. But I\'ll tell you something, Jeff, and you can quote e on this right now: If he had anything to do with killing that woman I\'d sooner put a bullet through his head myself than lift a finger to help him. Because that is inhuman. Inhuman. Even if he just was standing by... Some innocent person... and all she did was show up work at night? (pause) But we\'re not hoping it\'s all some terrible misunderstanding, right? \n\n'
        'Jeff: Right. Right. \n\n'
        'William: So what would you do there, Jeff?\n\n'
        'Jeff: Me? Oh, well, the first thing I would do is I would definitely try to find out if my brother was with those guys or not. Because that could really inform the whole situation right there.\n\n'
        '\n\n (Pause.) \n\n'
        'William: Well no fuckin\' shit, Jeff, how in the world do you expect me to do that? \n\n'
        'Jeff: Don\'t get mad at me, you asked me what I would do!\n\n'
        'William: Well what the fuck do you expect me to do? \'Find out if he was there or not.\' Hot dog. I never would have thought of that. \n\n'
        'Jeff: All right, all right! \n\n'
        'William: If I could just find that out the rest of this shit might just fall into place!\n\n'
        'Jeff: Why can\'t you go see him? Can\'t you talk to him? You\'ll be able to tell whether or not he\'s lying. \n\n'
        'William: No I can\'t go see him, Goddamn it, he\'s locked up in fuckin\' Riker\'s Island! I can\'t go see him \'til after the arraignment! \n\n'
        'Jeff: OK, what about his girlfriend? Maybe you should go see...\n\n'
        'William: I already talked to her, Jeff! Look, look, I don\'t actually expect you to solve this for me, let\'s just forget I brought it up. \n\n'
        'Jeff: I\'m sorry. This kind of problem is not exactly within my forte. \n\n'
        'William: Which is what? \n\n'
        'Jeff: OK, you don\'t have to get nasty, I\'m only tryin\' to be... \n\n'
        'William: What is your forte, man? What is your forte? \n\n'
        '\n\n(Pause.)\n\n'
        'Jeff: I don\'t have one. Losing money. \n\n'
        'William: All right, never mind, Jeff. Thanks anyway. \n\n'
        'Jeff: Do you know if the nurse was white or black? \n\n'
        'William: No. \n\n'
        'Jeff: Because that could... \n\n'
        'William: What difference does that make?\n\n'
        'Jeff: It\'s just if she\'s white there\'s probably gonna be a big stink about it in the papers, and if she\'s black they probably won\'t play it up as much. \n\n'
        'William: Well, I don\'t know what color she was... I just better figure out what I\'m gonna do before the cops catch up with me, because I\'m not gonna get two chances to do this right. (He starts to go...)\n\n'
        'Jeff: Is there anything you want me to tell the cops if they show up ?\n\n'
        'William: (stops) What? \n\n'
        'Jeff: If the cops come by and ask me if I\'ve seen you? \n\n'
        'William: Tell them you saw me. \n\n'
        'Jeff: What if they ask me if I talked about your brother? What should I tell em?\n\n'
        'William: Maybe it\'d be better if you didn\'t mention any of that till I figure out what I\'m doing. \n\n'
        'Jeff: Well, I don\'t feel comfortable lying to them. \n\n'
        'William: OK. Well... In that case, just...\n\n'
        'Jeff: No I was just.. I\'m kidding. \n\n'
        'William: Oh. \n\n'
        'Jeff: Sorry. \n\n'
        '\n\n (Pause.)\n\n'
        'William: What the fuck do you find funny about this, man? \n\n'
        'Jeff: Nothing. I\'m really sorry. I really apologize. \n\n'
        'William: All right. I should get going.\n\n'
        '\n\n END SCENE \n\n';

    List storyPrompt = [storyPrompt1];

    int randomNumber = GeneralService.getRandomNumber(6);
    if (randomNumber > 4) {
      randomNumber = 4;
    }

    return storyPrompt[0];
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

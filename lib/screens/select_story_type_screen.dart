import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/menu_screen.dart';
import 'package:storyteller/models/story_session_model.dart';
import 'package:storyteller/screens/select_story_screen.dart';
import 'package:storyteller/services/auth_service.dart';
import 'package:storyteller/services/openai_service.dart';
import 'package:storyteller/services/general_service.dart';
import 'package:storyteller/constants.dart' as constants;

class SelectStoryTypeScreen extends StatefulWidget {
  const SelectStoryTypeScreen({Key? key}) : super(key: key);

  @override
  State<SelectStoryTypeScreen> createState() => _SelectStoryTypeScreenState();
}

class _SelectStoryTypeScreenState extends State<SelectStoryTypeScreen> {
  String roomName = '';

  GeneralService generalService = GeneralService();
  OpenAIService openAIService = OpenAIService();
  StorySessionModel storySession = StorySessionModel();

  bool isLoading = false;

  selectOption(String storyPromptType){
    storySession.storyPromptType = storyPromptType; // set the story category type

    Navigator.push(
        context, PageTransition(type: PageTransitionType.bottomToTop, child: SelectStoryScreen(storySession: storySession)));
  }

  menuAction() {
    Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: Menu()));
  }

  @override
  Widget build(BuildContext context) {
    print('user: ${AuthService.getUser()}');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // title: const Text('Video Room'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            menuAction();
          },
        ),
      ),
      /*bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HighEmphasisButtonWithAnimation(
          onPressAction: rewrite,
          title: 'Rewrite with AI',
        ),
      ),*/
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Lottie.network('https://assets10.lottiefiles.com/private_files/lf30_gqirhcr7.json', fit: BoxFit.contain),
                      const Text('What type of story will you tell?', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              child: Card(
                                child: InkWell(
                                  onTap: (){
                                    selectOption(constants.StoryPromptType.pregnancy); // true = created room
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SizedBox.expand(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          /*SizedBox(
                                                  height: 30,
                                                  child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_fivxlkum.json')),*/
                                          Icon(
                                            Icons.pregnant_woman,
                                            color: Colors.yellow,
                                            size: 30.0,
                                          ),
                                          Text('During Pregnancy', style: TextStyle(fontSize: 18))],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              child: Card(
                                child: InkWell(
                                  onTap: (){
                                    selectOption(constants.StoryPromptType.parentOfToddler); // false = joins a room
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SizedBox.expand(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Icon(
                                            Icons.child_care,
                                            color: Colors.yellow,
                                            size: 30.0,
                                          ),
                                          Text('Parent of a toddler', style: TextStyle(fontSize: 18),)],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              child: Card(
                                child: InkWell(
                                  onTap: (){
                                    selectOption(constants.StoryPromptType.general); // true = created room
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SizedBox.expand(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          /*SizedBox(
                                                  height: 30,
                                                  child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_fivxlkum.json')),*/
                                          Icon(
                                            Icons.data_saver_on_sharp,
                                            color: Colors.yellow,
                                            size: 30.0,
                                          ),
                                          Text('General', style: TextStyle(fontSize: 18))],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              child: Card(
                                child: InkWell(
                                  onTap: (){
                                    selectOption(constants.StoryPromptType.general); // true = created room
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SizedBox.expand(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          /*SizedBox(
                                                  height: 30,
                                                  child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_fivxlkum.json')),*/
                                          Icon(
                                            Icons.festival_rounded,
                                            color: Colors.yellow,
                                            size: 30.0,
                                          ),
                                          Text('Actors in a play', style: TextStyle(fontSize: 18))],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

/*            ElevatedButton(
                    onPressed: () {
                    join();
                    },
                    child: const Text('Join'),
                  ),*/
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

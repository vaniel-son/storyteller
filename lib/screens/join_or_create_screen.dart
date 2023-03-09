import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/screens/video_1p/camera_screen.dart';
import 'package:storyteller/screens/video_2p/input_room_name_screen.dart';
import 'package:storyteller/models/story_session_model.dart';
import 'package:storyteller/services/openai_service.dart';
import 'package:storyteller/services/general_service.dart';
import 'package:lottie/lottie.dart';
import 'package:storyteller/constants.dart' as constants;

class JoinOrCreateRoomScreen extends StatefulWidget {
  const JoinOrCreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinOrCreateRoomScreen> createState() => _JoinOrCreateRoomScreenState();
}

class _JoinOrCreateRoomScreenState extends State<JoinOrCreateRoomScreen> {
  String roomName = '';

  GeneralService generalService = GeneralService();
  OpenAIService openAIService = OpenAIService();
  StorySessionModel storySession = StorySessionModel();

  bool isLoading = false;

  selectOption(bool create){
    storySession.create = create; // true for creating, false for joining
    storySession.sessionType = constants.SessionType.twoPlayers; // set session type

    Navigator.push(
        context, PageTransition(type: PageTransitionType.bottomToTop, child: InputRoomName(storySession: storySession)));
  }

  soloCampfireButton(){
    storySession.sessionType = constants.SessionType.solo;
    Navigator.push(
        context, PageTransition(type: PageTransitionType.bottomToTop, child: CameraScreen(storySession: storySession,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // title: const Text('Video Room'),
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
          // loading icon
          Visibility(
            visible: isLoading,
            child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_p8bfn5to.json'),
          ),
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
                      Lottie.network('https://assets2.lottiefiles.com/packages/lf20_mvof7nsb.json', width: 200, height: 200, fit: BoxFit.fill),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              child: Card(
                                child: InkWell(
                                  onTap: (){
                                    selectOption(true); // true = created room
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SizedBox.expand(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          /*SizedBox(
                                                  height: 30,
                                                  child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_fivxlkum.json')),*/
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.person,
                                                color: Colors.yellow,
                                                size: 30.0,
                                              ),
                                              Icon(
                                                Icons.person,
                                                color: Colors.yellow,
                                                size: 30.0,
                                              ),
                                            ],
                                          ),
                                          const Text('Create group Campfire', style: TextStyle(fontSize: 18))],
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
                                    selectOption(false); // false = joins a room
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SizedBox.expand(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.person,
                                                color: Colors.yellow,
                                                size: 30.0,
                                              ),
                                              Icon(
                                                Icons.person,
                                                color: Colors.yellow,
                                                size: 30.0,
                                              ),
                                            ],
                                          ),
                                          const Text('Join existing Campfire', style: TextStyle(fontSize: 18),)],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
/*                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              child: Card(
                                child: InkWell(
                                  onTap: (){
                                    soloCampfireButton();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SizedBox.expand(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          *//*SizedBox(
                                                  height: 30,
                                                  child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_fivxlkum.json')),*//*
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.person,
                                                color: Colors.yellow,
                                                size: 30.0,
                                              ),
                                            ],
                                          ),
                                          const Text('Solo campfire', style: TextStyle(fontSize: 18))],
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
                              child: Container(),
                            ),
                          ),
                        ],
                      ),*/
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

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/menu_screen.dart';
import 'package:storyteller/models/story_session_model.dart';
import 'package:storyteller/screens/video_2p/join_or_create_screen.dart';
import 'package:storyteller/screens/video_2p/video_chat_screen.dart';
import 'package:storyteller/services/auth_service.dart';
import 'package:storyteller/services/local_storage_service.dart';
import 'package:storyteller/services/general_service.dart';
import 'package:storyteller/constants.dart' as constants;
import 'package:storyteller/services/storyPrompt_service.dart';

class SelectStoryType2PScreen extends StatefulWidget {
  const SelectStoryType2PScreen({Key? key, required this.storySession}) : super(key: key);

  final StorySessionModel storySession;

  @override
  State<SelectStoryType2PScreen> createState() => _SelectStoryType2PScreenState();
}

class _SelectStoryType2PScreenState extends State<SelectStoryType2PScreen> {
  GeneralService generalService = GeneralService();
  SecureLocalStorageService secureLocalStorageService = SecureLocalStorageService();
  // StorySessionModel storySession = StorySessionModel();
  StoryPromptService storyPromptService = StoryPromptService();
  late String? currentStoryPromptTypeSelected = 'none';
  bool isLoading = false;

  selectOption(String storyPromptType) async {
    // await secureLocalStorageService.setSecureStorage(key: 'storyPromptType', value: storyPromptType);
    widget.storySession.storyPromptType = storyPromptType; // update story object for use on next screen

    // set story prompt based on the type
    widget.storySession.storyPrompt = storyPromptService.setStoryPrompt(widget.storySession.storyPromptType);

    // ux: change color of selected item
    currentStoryPromptTypeSelected = widget.storySession.storyPromptType;
    setState(() {

    });

    if (mounted) {
      Navigator.push(
          context, PageTransition(type: PageTransitionType.bottomToTop, child: VideoChat(storySession: widget.storySession)));
    }
  }

  menuAction() {
    Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: const Menu()));
  }

  @override
  Widget build(BuildContext context) {
    print('user: ${AuthService.getUser()}');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('2 Player Storyteller'),
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
                                color: (currentStoryPromptTypeSelected == constants.StoryPromptType.general) ? Colors.lightBlue: Colors.white10,
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
                                color: (currentStoryPromptTypeSelected == constants.StoryPromptType.acting) ? Colors.lightBlue: Colors.white10,
                                child: InkWell(
                                  onTap: (){
                                    selectOption(constants.StoryPromptType.acting); // false = joins a room
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: SizedBox.expand(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Icon(
                                            Icons.theater_comedy,
                                            color: Colors.yellow,
                                            size: 30.0,
                                          ),
                                          Text('Acting', style: TextStyle(fontSize: 18),)],
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

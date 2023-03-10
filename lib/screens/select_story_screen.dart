import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/screens/video_2p/join_or_create_screen.dart';
import 'package:storyteller/models/story_session_model.dart';
import 'package:storyteller/services/general_service.dart';
import 'package:lottie/lottie.dart';
import 'package:storyteller/constants.dart' as constants;

class SelectStoryScreen extends StatefulWidget {
  const SelectStoryScreen({Key? key, required this.storySession}) : super(key: key);

  final StorySessionModel storySession;

  @override
  State<SelectStoryScreen> createState() => _SelectStoryScreenState();
}

class _SelectStoryScreenState extends State<SelectStoryScreen> {
  String roomName = '';
  GeneralService generalService = GeneralService();
  bool isLoading = false;

  // default questions
  String storyPrompt1 = 'Surprising moment this week about pregnancy';
  String storyPrompt2 = 'Who made you feel grateful this week';
  String storyPrompt3 = 'Who you could throw into a dumpster';
  String storyPrompt4 = 'Your food cravings this past week';
  String storyPrompt5 = 'Someone interesting you met this week';

  setStoryPrompt() {
    if (widget.storySession.storyPromptType == constants.StoryPromptType.pregnancy) {
      storyPrompt1 = 'Surprising moment this week about pregnancy';
      storyPrompt2 = 'Who made you feel grateful this week';
      storyPrompt3 = 'Who you could throw into a dumpster';
      storyPrompt4 = 'Your food cravings this past week';
      storyPrompt5 = 'Someone interesting you met this week';
    } else if (widget.storySession.storyPromptType == constants.StoryPromptType.parentOfToddler) {
      storyPrompt1 = '2Surprising moment this week about pregnancy';
      storyPrompt2 = '2Who made you feel grateful this week';
      storyPrompt3 = '2Who you could throw into a dumpster';
      storyPrompt4 = '2Your food cravings this past week';
      storyPrompt5 = '2Someone interesting you met this week';
    } else if (widget.storySession.storyPromptType == constants.StoryPromptType.general) {
      storyPrompt1 = '3Surprising moment this week about pregnancy';
      storyPrompt2 = '3Who made you feel grateful this week';
      storyPrompt3 = '3Who you could throw into a dumpster';
      storyPrompt4 = '3Your food cravings this past week';
      storyPrompt5 = '3Someone interesting you met this week';
    }
  }

  selectQuestion(String storyPrompt){
    print('storyPrompt: $storyPrompt');
    widget.storySession.storyPrompt = storyPrompt; // store story prompt in the object

    Navigator.push(
        context, PageTransition(type: PageTransitionType.bottomToTop, child: const JoinOrCreateRoomScreen()));
  }

  @override
  Widget build(BuildContext context) {
    setStoryPrompt(); // determine set of questions based on category

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Choose a story'),
      ),
      /*bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HighEmphasisButtonWithAnimation(
          onPressAction: (){},
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
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Lottie.network('https://assets1.lottiefiles.com/packages/lf20_jTM81dQuPv.json'),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Woof. Tell me about a story about...',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          /*SizedBox(
                          height: 200,
                          child: Card(
                            child: InkWell(
                              onTap: (){},
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: SizedBox.expand(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 30,
                                          child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_fivxlkum.json')),
                                      const Text('What surprised you about pregnancy this week?', style: TextStyle(fontSize: 24), maxLines: 20,)],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),*/
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                  selectQuestion(storyPrompt1);
                                }, // selectQuestion(storyPrompt1),
                                child: Text(
                                  storyPrompt1,
                                  style: const TextStyle(fontSize: 30),
                                  maxLines: 20,
                                )),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                  selectQuestion(storyPrompt2);
                                }, // selectQuestion(storyPrompt2),
                                child: Text(
                                  storyPrompt2,
                                  style: const TextStyle(fontSize: 30),
                                  maxLines: 20,
                                )),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                  selectQuestion(storyPrompt3);
                                },
                                child: Text(storyPrompt3, style: const TextStyle(fontSize: 30), maxLines: 20,)),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                  selectQuestion(storyPrompt4);
                                },
                                child: Text(storyPrompt4, style: const TextStyle(fontSize: 30), maxLines: 20,)),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                                onTap: (){
                                  selectQuestion(storyPrompt5);
                                },
                                child: Text(storyPrompt5, style: const TextStyle(fontSize: 30), maxLines: 20,)),
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
              ),
/*          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HighEmphasisButtonWithAnimation(
                      onPressAction: rewrite,
                      title: 'Rewrite with AI',
                    ),
                  ),
                ],
              ),
            ),*/
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/screens/story_writer/ai_rewrite_screen.dart';
import 'package:storyteller/services/openai_service.dart';
import 'package:storyteller/widgets/button_widget.dart';
import 'package:storyteller/services/general_service.dart';
import 'package:lottie/lottie.dart';

// Create the story
// Display the story
// Edit the story
// Save the story
// Confirm it's saved and is available during the campfire

// Display list of saved stories
// Tap and edit a story
// Save edited story

// ** Writing use cases
// - don't like the story so want to rewrite it
// - i want to mix and match my old story and the new story

// ** User flow cases
// - I write a story and re-tell it
// - I am in a campfire and I am prompted to tell a story
// - I am in a campfire and I tell a story about a topic I choose
// - I record a solo story with same cases above



class WriteOralStory extends StatefulWidget {
  const WriteOralStory({Key? key}) : super(key: key);

  @override
  State<WriteOralStory> createState() => _WriteOralStoryState();
}

class _WriteOralStoryState extends State<WriteOralStory> {
  String roomName = '';
  final channelTextController = TextEditingController(text: ''); // To access the TextField
  final channelTextController2 = TextEditingController(text: ''); // To access the TextField
  final channelTextController3 = TextEditingController(text: ''); // To access the TextField
  final channelTextController4 = TextEditingController(text: ''); // To access the TextField
  final channelTextController5 = TextEditingController(text: ''); // To access the TextField


  GeneralService generalService = GeneralService();
  OpenAIService openAIService = OpenAIService();

  bool isLoading = false;

  join(){
    return Container();
  }

  rewrite() async {
    setState(() {
      isLoading = true; // hide loading animation
    });

    // call openai service to get the rewritten story
    String rewrittenStory = await openAIService.completion(channelTextController.text);

    //isLoading = false; // hide loading animation

    setState(() {
      isLoading = false; // hide loading animation
    });

    displayAiOutput(rewrittenStory); // navigate to AIRewriteScreen();
  }

  displayAiOutput(rewrittenStory) {
    Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: AIRewriteScreen(rewrittenStory: rewrittenStory)));
  }

  @override
  Widget build(BuildContext context) {
    // display a text input field and button, when the button is pressed, navigate to the video chat screen, pass the room name to the video chat screen
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*appBar: AppBar(
        title: const Text('Write Story'),
      ),*/
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HighEmphasisButtonWithAnimation(
          onPressAction: rewrite,
          title: 'Rewrite with AI',
        ),
      ),
      body: Stack(
        children: [
          // loading icon
          Visibility(
            visible: isLoading,
            child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_p8bfn5to.json'),),
          CustomScrollView(
          slivers:
          <Widget>[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: channelTextController,
                            minLines: 5,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Write a story',
                            ),
                          ),
                          const SizedBox(height: 8),
                          /*TextField(
                            controller: channelTextController2,
                            minLines: 5,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'What is the main obstacle?',
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: channelTextController3,
                            minLines: 5,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'What is the punchline?',
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: channelTextController4,
                            minLines: 5,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Write your story',
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: channelTextController5,
                            minLines: 5,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Write your story',
                            ),
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
        )],
      ),
    );
  }
}

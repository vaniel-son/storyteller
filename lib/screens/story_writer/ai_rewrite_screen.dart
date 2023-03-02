import 'package:flutter/material.dart';
import 'package:storyteller/widgets/button_widget.dart';

// Create the story
// Display the story
// Edit the story
// Save the story
// Confirm it's saved and is available during the campfire

// Display list of saved stories
// Tap and edit a story
// Save edited story

class AIRewriteScreen extends StatefulWidget {
  const AIRewriteScreen({Key? key, required this.rewrittenStory}) : super(key: key);

  final String rewrittenStory;

  @override
  State<AIRewriteScreen> createState() => _AIRewriteScreenState();
}

class _AIRewriteScreenState extends State<AIRewriteScreen> {
  late final channelTextController = TextEditingController(text: widget.rewrittenStory);

  save(){
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // display a text input field and button, when the button is pressed, navigate to the video chat screen, pass the room name to the video chat screen
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('AI Rewrite'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HighEmphasisButtonWithAnimation(
          onPressAction: save,
          title: 'Save',
        ),
      ),
      body: CustomScrollView(
        slivers:
        <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text('Storyteller\nA\nB\nC\nD', style: TextStyle(color: Colors.black54), maxLines: 20,),
                      const SizedBox(height: 8),
                      TextField(
                        controller: channelTextController,
                        minLines: 15,
                        maxLines: 15,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Edit your story here and save',
                        ),
                      )

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
      ),
    );
  }
}

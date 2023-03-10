import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/models/story_session_model.dart';
import 'package:storyteller/screens/video_2p/select_story_type_2p_screen.dart';
import 'package:storyteller/widgets/button_widget.dart';
import 'package:storyteller/services/general_service.dart';
import 'package:storyteller/screens/video_2p/video_chat_screen.dart';
import 'package:lottie/lottie.dart';

class InputRoomName extends StatefulWidget {
  const InputRoomName({Key? key, required this.storySession}) : super(key: key);

  final StorySessionModel storySession;

  @override
  State<InputRoomName> createState() => _InputRoomNameState();
}

class _InputRoomNameState extends State<InputRoomName> {
  String roomName = '';
  final channelTextController = TextEditingController(text: ''); // To access the TextField

  // widget.storySession.create = create; // true for creating, false for joining

  // when button is pressed, navigate to main.dart and pass the room name to the video chat screen
  join() {
    channelName = channelTextController.text;
    widget.storySession.roomName = channelName;
    if (channelName.isEmpty) {
      GeneralService.displaySnackBar(context, 'Enter a room name');
    } else {
      // navigate to the video chat screen
      Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SelectStoryType2PScreen(storySession: widget.storySession)));
    }
  }

  @override
  Widget build(BuildContext context) {
    String buttonText = 'Create Room';
    String subtitle = 'Make up a name for your campfire';
    if (widget.storySession.create) {
      subtitle = 'Make up a name for your Campfire';
      buttonText = 'Create a Campfire';
    } else {
      buttonText = 'Join';
      subtitle = 'What\'s the name of the Campfire you wanna to join?';
    }

    return Scaffold(
      appBar: AppBar(
          //title: const Text('Join a storytelling room'),
          ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.network(height: 150, 'https://assets4.lottiefiles.com/packages/lf20_xiuflspu.json'),
              Text(subtitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 64),
              TextField(
                controller: channelTextController,
                decoration: const InputDecoration(
                  hintText: 'Provide a campfire name',
                ),
              ),
              const SizedBox(height: 8),
              HighEmphasisButtonWithAnimation(
                onPressAction: join,
                title: buttonText,
              ),
/*            ElevatedButton(
                onPressed: () {
                  join();
                },
                child: const Text('Join'),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

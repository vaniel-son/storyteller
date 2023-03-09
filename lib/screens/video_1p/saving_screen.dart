import 'package:flutter/material.dart';
import 'package:storyteller/models/story_session_model.dart';
import 'package:storyteller/models/user_model.dart';
import 'package:storyteller/screens/video_1p/video_screen.dart';
import 'package:storyteller/services/auth_service.dart';
import 'package:storyteller/services/database_service.dart';
import 'package:storyteller/services/general_service.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SavingScreen extends StatefulWidget {
  final String filePath;
  final StorySessionModel storySession;

  const SavingScreen({Key? key, required this.filePath, required this.storySession}) : super(key: key);

  @override
  SavingScreenState createState() => SavingScreenState();
}

class SavingScreenState extends State<SavingScreen> {
  late VideoPlayerController _videoPlayerController;
  late String firebaseURLofVideo;

  // init database services
  DatabaseServices databaseServices = DatabaseServices();

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  uploadVideo() async {
    firebaseURLofVideo = await GeneralService.uploadVideo(widget.filePath); // upload the video to firebase storage, returns receive the download URL
    print('Video: $firebaseURLofVideo');
  }

  // save a record of the session to firestore
  saveSession() async {
    // fetch user info
    UserModel user = await AuthService.getUserFromSecureLocalStorage(); // returns a User object

    // some set statement: date/time, video URL, user ID, prompt, promptType
    await databaseServices.saveSession(
      uuid: user.uuid,
      userName: user.userName,
      sessionType: widget.storySession.sessionType, // ex. solo, 2p
      storyPromptType: widget.storySession.storyPromptType, // ex. pregnancy, general
      storyPrompt: widget.storySession.storyPrompt,
      videoURL: firebaseURLofVideo,
    );
  }

  uploadAndSave() async {
    await uploadVideo();
    await saveSession();

    // redirect to video replay screen
    final route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => VideoScreen(filePath: widget.filePath),
    );

    /*if (mounted) {
      Navigator.push(context, route);
    }*/

    return VideoScreen(filePath: widget.filePath);

  }

  @override
  Widget build(BuildContext context) {
    uploadAndSave();

    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              print('do something with the file');
            },
          )
        ],
      ),*/
      // extendBodyBehindAppBar: true,
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:  CrossAxisAlignment.center,
            children: const [
              Text('Uploading video, please wait...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
              CircularProgressIndicator(),
            ],
          )),
    );
  }
}

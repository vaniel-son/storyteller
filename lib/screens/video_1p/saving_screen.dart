import 'dart:io';
import 'package:flutter/material.dart';
import 'package:storyteller/services/general_service.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';

class SavingScreen extends StatefulWidget {
  final String filePath;

  const SavingScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  SavingScreenState createState() => SavingScreenState();
}

class SavingScreenState extends State<SavingScreen> {
  late VideoPlayerController _videoPlayerController;
  final _firebaseStorage = FirebaseStorage.instance;
  late String firebaseURL;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  uploadVideo() async {
    String firebaseURLofVideo = await GeneralService.uploadVideo(widget.filePath); // upload the video to firebase storage, returns receive the download URL
    print('Video: $firebaseURLofVideo');
  }

  // save a record of the session to firestore
  saveSession(){
    // some set statement: date/time, video URL, user ID, prompt, promptType

  }

  @override
  Widget build(BuildContext context) {
    uploadVideo();

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

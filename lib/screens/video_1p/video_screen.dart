import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/wrapper.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String filePath;

  const VideoScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    print('video path: ${widget.filePath}');
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Replay your video'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(type: PageTransitionType.rightToLeftWithFade, child: const Wrapper()),
                      (Route<dynamic> route) => false);
                }
              })
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }
}

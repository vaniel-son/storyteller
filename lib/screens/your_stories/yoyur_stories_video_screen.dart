import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/wrapper.dart';
import 'package:video_player/video_player.dart';

class YourStoriesVideoScreen extends StatefulWidget {
  final String videoURL;

  const YourStoriesVideoScreen({Key? key, required this.videoURL}) : super(key: key);

  @override
  YourStoriesVideoScreenState createState() => YourStoriesVideoScreenState();
}

class YourStoriesVideoScreenState extends State<YourStoriesVideoScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoURL);
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
                  Navigator.pop(context);
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

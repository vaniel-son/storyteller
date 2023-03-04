import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:storyteller/models/story_session_model.dart';
import 'package:storyteller/screens/video_1p/saving_screen.dart';
import 'package:storyteller/screens/video_1p/video_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key, required this.storySession}) : super(key: key);

  final StorySessionModel storySession;

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;
  late final String filePath;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();

      setState(() => _isRecording = false);

      // redirect to saving screen

      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => SavingScreen(filePath: file.path, storySession: widget.storySession),
      );

      if (mounted) {
        Navigator.push(context, route);
      }

    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(_cameraController),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              decoration: const BoxDecoration(
                color: Colors.grey,
                //borderRadius: roundCornersRadius(),
              ),
              child: Text(
                widget.storySession.playerPrompt,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              //Text('  Personal Record: $personalRecord  ', style: Theme.of(context).textTheme.caption)
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(_isRecording ? Icons.stop : Icons.circle),
                onPressed: () => _recordVideo(),
              ),
            ),
          ],
        ),
      );
    }
  }
}
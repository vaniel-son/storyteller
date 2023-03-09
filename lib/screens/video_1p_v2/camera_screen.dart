import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/menu_screen.dart';
import 'package:storyteller/models/story_session_model.dart';
import 'package:storyteller/screens/video_1p/saving_screen.dart';
import 'package:storyteller/screens/video_1p/video_screen.dart';
import 'package:storyteller/constants.dart' as constants;
import 'package:storyteller/services/local_storage_service.dart';
import 'package:storyteller/services/storyPrompt_service.dart';
import 'package:storyteller/style/colors.dart';
import 'package:storyteller/style/style_misc.dart';

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
  StoryPromptService storyPromptService = StoryPromptService();
  SecureLocalStorageService secureLocalStorageService = SecureLocalStorageService();

  @override
  void initState() {
    _updateStoryObject();
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  /// create story object
  // StorySessionModel storySession = StorySessionModel();
  _updateStoryObject() async {
    widget.storySession.sessionType = constants.SessionType.solo;

    // set default story prompt type
    // widget.storySession.storyPromptType = constants.StoryPromptType.pregnancy;

    // set default item if not set
    /*if (currentStoryPromptTypeSelected == null) {
      await secureLocalStorageService.setSecureStorage(key: 'storyPromptType', value: constants.StoryPromptType.pregnancy);
    }*/

    // set story prompt based on the type
    widget.storySession.storyPrompt = storyPromptService.setStoryPrompt(widget.storySession.storyPromptType);
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

  menuAction() {
    Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: const Menu()));
  }

  // hide the story prompt
  bool displayLargeStoryPrompt = true;
  bool displaySmallStoryPrompt = false;

  hide() {
    setState(() {
      displayLargeStoryPrompt = false;
      displaySmallStoryPrompt = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.black12,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          // title: const Text('Video Room'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Stack(
            //alignment: Alignment.bottomCenter,
            children: [
              CameraPreview(_cameraController),
              Visibility(
                visible: displayLargeStoryPrompt,
                child: InkWell(
                  onTap: () {
                    hide(); // true = created room
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height - 200,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    decoration: BoxDecoration(
                      color: surfaceColorTransparent1,
                      borderRadius: borderRadius2(),
                      // borderRadius: roundCornersRadius(),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Tell a story about...',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          widget.storySession.storyPrompt,
                          style: const TextStyle(color: Colors.white, fontSize: 48),
                        ),
                      ],
                    ),
                    //Text('  Personal Record: $personalRecord  ', style: Theme.of(context).textTheme.caption)
                  ),
                ),
              ),
              Visibility(
                visible: displaySmallStoryPrompt,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          //borderRadius: roundCornersRadius(),
                        ),
                        child: Text(
                          widget.storySession.storyPrompt,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        //Text('  Personal Record: $personalRecord  ', style: Theme.of(context).textTheme.caption)
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
              ),
            ],
          ),
        ),
      );
    }
  }
}

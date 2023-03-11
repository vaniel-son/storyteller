import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:storyteller/models/story_session_model.dart';
import 'package:storyteller/style/colors.dart';
import 'package:storyteller/style/style_misc.dart';
import 'package:storyteller/constants.dart' as constants;

const String appId = "314afbc9a3bf4d0ead3e840ce212515c";
String channelName = '<--Insert channel name here-->';
String token = '<--Insert authentication token here-->';
int uid = 0; // uid of the local user
String serverUrl =
    "https://agora-token-service-production-c810.up.railway.app"; // For example, "https://agora-token-service-production-92ff.up.railway.app"

class VideoChat extends StatefulWidget {
  const VideoChat({Key? key, required this.storySession}) : super(key: key);

  final StorySessionModel storySession;

  @override
  State<VideoChat> createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  /*final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: appId,
      channelName: widget.roomName,
      tokenUrl: serverUrl,
      uid: uid,
    ),
  );*/
  late AgoraClient client;
  double storyPromptFontSize = 14;

  @override
  void initState() {
    super.initState();
    initAgoraClient();
    initAgora();
  }

  void initAgoraClient() {
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: appId,
        channelName: widget.storySession.roomName,
        tokenUrl: serverUrl,
        uid: uid,
      ),
    );
  }

  void initAgora() async {
    await client.initialize();
  }

  void determineFontSize() {
    if (widget.storySession.storyPromptType == constants.StoryPromptType.acting) {
      storyPromptFontSize = 14.0;
    } else if (widget.storySession.storyPromptType == constants.StoryPromptType.general) {
      storyPromptFontSize = 48.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.storySession.roomName),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                layoutType: Layout.floating,
                enableHostControls: true, // Add this to enable host controls
              ),
              AgoraVideoButtons(
                client: client,
                onDisconnect: () {
                  Navigator.pop(context);
                },
              ),
            Container(
              height: MediaQuery.of(context).size.height - 300,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              decoration: BoxDecoration(
                color: surfaceColorTransparent1,
                borderRadius: borderRadius2(),
                // borderRadius: roundCornersRadius(),
              ),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: (widget.storySession.storyPromptType == constants.StoryPromptType.acting),
                          child: Column(
                            children: [
                              Text(
                                widget.storySession.storyPrompt,
                                style: const TextStyle(color: Colors.white, fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: (widget.storySession.storyPromptType == constants.StoryPromptType.general),
                          child: Column(
                            children: [
                              Text(
                                widget.storySession.storyPrompt,
                                style: const TextStyle(color: Colors.white, fontSize: 24.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //Text('  Personal Record: $personalRecord  ', style: Theme.of(context).textTheme.caption)
            ),
            ],
          ),
        ),
      ),
    );
  }
}

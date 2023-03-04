import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:storyteller/models/story_session_model.dart';

const String appId = "314afbc9a3bf4d0ead3e840ce212515c";
String channelName = '<--Insert channel name here-->';
String token = '<--Insert authentication token here-->';
int uid = 0; // uid of the local user
String serverUrl =
    "https://agora-token-service-production-c810.up.railway.app"; // For example, "https://agora-token-service-production-92ff.up.railway.app"

class VideoChat extends StatefulWidget {
  const VideoChat({Key? key, required this.roomName, required this.storySession}) : super(key: key);

  final String roomName;
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
        channelName: widget.roomName,
        tokenUrl: serverUrl,
        uid: uid,
      ),
    );
  }

  void initAgora() async {
    await client.initialize();
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
            ],
          ),
        ),
      ),
    );
  }
}

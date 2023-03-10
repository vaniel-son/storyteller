import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/menu_screen.dart';
import 'package:storyteller/models/user_model.dart';
import 'package:storyteller/models/your_story_model.dart';
import 'package:storyteller/screens/video_2p/join_or_create_screen.dart';
import 'package:storyteller/models/story_session_model.dart';
import 'package:storyteller/screens/your_stories/yoyur_stories_video_screen.dart';
import 'package:storyteller/services/auth_service.dart';
import 'package:storyteller/services/database_service.dart';
import 'package:storyteller/services/general_service.dart';
import 'package:lottie/lottie.dart';
import 'package:storyteller/constants.dart' as constants;

class PlayerStoriesListScreen extends StatefulWidget {
  const PlayerStoriesListScreen({Key? key,}) : super(key: key);

  @override
  State<PlayerStoriesListScreen> createState() => _PlayerStoriesListScreenState();
}

class _PlayerStoriesListScreenState extends State<PlayerStoriesListScreen> {
  String roomName = '';
  GeneralService generalService = GeneralService();
  bool isLoading = false;
  DatabaseServices databaseServices = DatabaseServices();

  Future<List<YourStoryModel>> getPlayerStoryList() async {
    print('starting');
    // UserModel user = await AuthService.getUserFromSecureLocalStorage(); // returns a User object
    // print('uuid: ${user.uuid}');
    List<YourStoryModel> playerStoryList = await databaseServices.getPlayerStories(uuid: FirebaseAuth.instance.currentUser!.uid);
    print('completed');
    print('uuid: ${FirebaseAuth.instance.currentUser!.uid}');
    print(playerStoryList.length);
    print('completed2');
    return playerStoryList;
  }

  // route to video replay screen
  void displayVideo(String videoURL){
    final route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => YourStoriesVideoScreen(videoURL: videoURL),
    );

    if (mounted) {
      Navigator.push(context, route);
    }
  }

  menuAction() {
    Navigator.push(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: const Menu()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Your Stories'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            menuAction();
          },
        ),
      ),
      body: Stack(
        children: [
          // loading icon
          Visibility(
            visible: isLoading,
            child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_p8bfn5to.json'),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Lottie.network('https://assets1.lottiefiles.com/packages/lf20_jTM81dQuPv.json'),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Woof. Watch all your stories',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          FutureBuilder<List<YourStoryModel>>(
                              future: getPlayerStoryList(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<YourStoryModel> playerStoryList = snapshot.data!;
                                  return SizedBox(
                                    height: 800,
                                    child: ListView.separated(
                                      padding: const EdgeInsets.all(4.0),
                                      separatorBuilder: (BuildContext context, int index) {
                                        return const SizedBox(
                                          width: 8.0,
                                        );
                                      },
                                      scrollDirection: Axis.vertical,
                                      itemCount: playerStoryList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                    onTap: (){
                                                      displayVideo(playerStoryList[index].videoURL);
                                                    },
                                                    child: Text(playerStoryList[index].storyPrompt, style: const TextStyle(fontSize: 30))),
                                              ),
                                              const Divider(),
                                              //const SizedBox(height: 16.0),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                          const SizedBox(height: 8),

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
          )
        ],
      ),
    );
  }
}

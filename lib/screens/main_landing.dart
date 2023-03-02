import 'package:flutter/material.dart';
import 'package:storyteller/screens/story_writer/write_story_screen.dart';

class MainLanding extends StatefulWidget {
  const MainLanding({Key? key}) : super(key: key);

  @override
  State<MainLanding> createState() => _MainLandingState();
}

class _MainLandingState extends State<MainLanding> {
  @override
  Widget build(BuildContext context) {
    // display a text input field and button, when the button is pressed, navigate to the video chat screen, pass the room name to the video chat screen
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: Colors.black12,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Storyteller', style: TextStyle(color: Colors.black54)),
/*          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              menuAction();
            },
          ),*/
          backgroundColor: Colors.white,
          bottom: const TabBar(
            isScrollable: false,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.tealAccent,
            tabs: [
              Tab(text: 'Campfires'),
              Tab(text: 'Prepare a story'),
              Tab(text: 'Select a story'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // yourHomePage(context, 0),
            // HomeTab(context: context, index: 0, playerRecords: mainLandingSelectController.getPlayerRecords, phoBowlsEarnedFromFirebase: mainLandingSelectController.getPhoBowlsEarnedFromFirebase, pushupStats: mainLandingSelectController.getPushupStats),
            //InputRoomName(),
            WriteOralStory(),
            //SelectStoryScreen(),
          ],
        ),
      ),
    );
  }
}

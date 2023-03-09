import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/screens/join_or_create_screen.dart';
import 'package:storyteller/screens/video_1p_v2/select_story_type_screen.dart';
import 'package:storyteller/screens/video_1p_v2/camera_screen.dart';
import 'package:storyteller/screens/your_stories/your_stories_screen.dart';
import 'package:storyteller/services/auth_service.dart';
// ignore: unused_import
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storyteller/wrapper.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  late Future<String> nickname;

  // Manage admin view
  bool enableAdminView = false;

  @override
  void initState() {
    super.initState();
  }

  backButtonAction() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: primaryBackgroundColor2,
      appBar: AppBar(
        //title: PageTitle(title: 'TURN BASED 2 PLAYER'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            backButtonAction();
          },
        ),
        // backgroundColor: primaryBackgroundColor2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            margin: const EdgeInsets.all(0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// Solo
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: const SelectStoryTypeScreen()), (Route<dynamic> route) => false);
                                print('tap');
                              },
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  const Icon(Icons.person,
                                      size: 32, color: Colors.yellow,),
                                  const SizedBox(width: 16),
                                  Text('Solo Story', style: Theme.of(context).textTheme.bodyText1),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),

                        /// Divider
                        const SizedBox(height: 16),
                        const Divider(height: 1.0, thickness: 1.0, indent: 0.0),
                        const SizedBox(height: 16),

                        /// Your Stories
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: const PlayerStoriesListScreen()), (Route<dynamic> route) => false);
                                print('tap');
                              },
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  const Icon(Icons.book,
                                      size: 32, color: Colors.yellow,),
                                  const SizedBox(width: 16),
                                  Text('Your Stories', style: Theme.of(context).textTheme.bodyText1),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),

                        /// Divider
                        const SizedBox(height: 16),
                        const Divider(height: 1.0, thickness: 1.0, indent: 0.0),
                        const SizedBox(height: 16),

                        /// Two Players
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: const JoinOrCreateRoomScreen()), (Route<dynamic> route) => false);
                                print('tap');
                              },
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  const Icon(Icons.people,
                                      size: 32, color: Colors.yellow,),
                                  const SizedBox(width: 16),
                                  Text('Two Player Story', style: Theme.of(context).textTheme.bodyText1),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),

                        /// Divider
                        const SizedBox(height: 16),
                        const Divider(height: 1.0, thickness: 1.0, indent: 0.0),
                        const SizedBox(height: 16),

                        /// Two Player: Acting
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: const JoinOrCreateRoomScreen()), (Route<dynamic> route) => false);
                                print('tap');
                              },
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  const Icon(Icons.theater_comedy,
                                      size: 32, color: Colors.yellow,),
                                  const SizedBox(width: 16),
                                  Text('Two Player Acting', style: Theme.of(context).textTheme.bodyText1),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),


                        /// Divider
                        const SizedBox(height: 16),
                        const Divider(height: 1.0, thickness: 1.0, indent: 0.0),
                        const SizedBox(height: 16),



                        /// Sign Out
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                AuthService.signOut();
                                Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: const Wrapper()), (Route<dynamic> route) => false);
                              },
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  const Icon(Icons.logout,
                                      size: 32, color: Colors.yellow,),
                                  const SizedBox(width: 16),
                                  Text('Sign Out', style: Theme.of(context).textTheme.bodyText1),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),

                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // top module
  }
}

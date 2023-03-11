import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storyteller/screens/authentication/login_screen.dart';
import 'package:storyteller/screens/authentication/register.dart';
import 'package:storyteller/screens/video_1p_v2/select_story_type_screen.dart';
import 'package:storyteller/services/auth_service.dart';
import 'package:storyteller/widgets/button_widget.dart';
import 'package:lottie/lottie.dart';

class WhatScreen extends StatefulWidget {
  const WhatScreen({Key? key}) : super(key: key);

  @override
  State<WhatScreen> createState() => _WhatScreenState();
}

class _WhatScreenState extends State<WhatScreen> {
  next() {
    Navigator.push(
        context, PageTransition(type: PageTransitionType.bottomToTop, child: const SelectStoryTypeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    print('user: ${AuthService.getUser()}');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*appBar: AppBar(
        // title: const Text('Video Room'),
      ),*/
      /*bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HighEmphasisButtonWithAnimation(
          onPressAction: rewrite,
          title: 'Rewrite with AI',
        ),
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network('https://assets4.lottiefiles.com/packages/lf20_xiuflspu.json', height: 200),
            const Text('WELCOME, STORYTELLER', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Video record your personal stories to share with family, me (woof), or to pass on to your future generations.', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14)),
            InkWell(
              onTap: () {
                // next(); // true = created room
              },
              child: Column(
                children: [
                  Lottie.network('https://assets1.lottiefiles.com/packages/lf20_jTM81dQuPv.json'),
                  Container(),
                  // const Text('(Tap my head to begin)', style: TextStyle(fontSize: 14)),
                ],
              ),),
            const SizedBox(height: 8),
            HighEmphasisButtonWithAnimation2(
              onPressAction: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const LoginScreen()));
              },
              title: 'Sign in',
            ),
            HighEmphasisButtonWithAnimation2(
              onPressAction: (){
                Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: const RegisterScreen()));
              },
              title: 'Register',
            )


/*            ElevatedButton(
          onPressed: () {
          join();
          },
          child: const Text('Join'),
        ),*/
          ],
        ),
      ),
    );
  }
}

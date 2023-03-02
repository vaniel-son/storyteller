import 'package:flutter/material.dart';

void buttonPressAction(x){
  x();
}

/// Animated Button
class HighEmphasisButtonWithAnimation extends StatefulWidget {
  const HighEmphasisButtonWithAnimation({
    Key? key,
    this.id = 0,
    required this.title,
    this.primaryColor = Colors.blue,
    this.onPrimaryColor = Colors.white,
    required this.onPressAction,
  }) : super(key: key);

  final int id;
  final String title;
  final Color primaryColor;
  final Color onPrimaryColor;
  final Function onPressAction;

  @override
  HighEmphasisButtonWithAnimationState createState() => HighEmphasisButtonWithAnimationState();
}

class HighEmphasisButtonWithAnimationState extends State<HighEmphasisButtonWithAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this, value: 0.0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        width: (MediaQuery.of(context).size.width) * 0.90,
        height: 48,
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              //boxShadow1(),
              BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(1,1),
                blurRadius: 5,
                spreadRadius: 2,
              ),
              /*const BoxShadow(
                color: Colors.white,
                offset: Offset(-6,-6),
                blurRadius: 5,
                spreadRadius: 1,
              ),*/

            ], borderRadius: const BorderRadius.all(Radius.circular(80))),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: widget.primaryColor, // background
            onPrimary: widget.onPrimaryColor, // foreground
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
          ),
          onPressed: () {
            buttonPressAction(widget.onPressAction);
          },
          //van57onPressed: widget.onPressAction,
          child: Text(widget.title),
        ),
      ),
    );
  }
}

/// Animated Button
class HighEmphasisButtonWithAnimation2 extends StatefulWidget {
  const HighEmphasisButtonWithAnimation2({
    Key? key,
    this.id = 0,
    required this.title,
    this.primaryColor = Colors.blue,
    this.onPrimaryColor = Colors.white,
    required this.onPressAction,
  }) : super(key: key);

  final int id;
  final String title;
  final Color primaryColor;
  final Color onPrimaryColor;
  final Function onPressAction;

  @override
  HighEmphasisButtonWithAnimationState2 createState() => HighEmphasisButtonWithAnimationState2();
}

class HighEmphasisButtonWithAnimationState2 extends State<HighEmphasisButtonWithAnimation2> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this, value: 0.0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        width: (MediaQuery.of(context).size.width) * 0.90,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            //primary: widget.primaryColor, // background
            //onPrimary: widget.onPrimaryColor, // foreground
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
          ),
          onPressed: () {
            buttonPressAction(widget.onPressAction);
          },
          //van57onPressed: widget.onPressAction,
          child: Text(widget.title),
        ),
      ),
    );
  }
}

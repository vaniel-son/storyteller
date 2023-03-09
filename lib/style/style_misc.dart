import 'package:flutter/material.dart';
import 'colors.dart';

/// ***********************************************************************
/// Borders
/// ***********************************************************************

borderRadius1() {
  return const BorderRadius.only(
    topLeft: Radius.circular(6),
    topRight: Radius.circular(6),
    bottomLeft: Radius.circular(6),
    bottomRight: Radius.circular(6),
  );
}

borderRadius2() {
  return const BorderRadius.only(
    topLeft: Radius.circular(12),
    topRight: Radius.circular(12),
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
  );
}

roundCornersRadius() {
  return const BorderRadius.only(
    topLeft: Radius.circular(80),
    topRight: Radius.circular(80),
    bottomLeft: Radius.circular(80),
    bottomRight: Radius.circular(80),
  );
}

/// ***********************************************************************
/// Shadows
/// ***********************************************************************

boxShadow1() {
  return BoxShadow(
    color: Colors.black.withOpacity(0.3),
    blurRadius: 5,
    offset: const Offset(5, 5),
  );
}

/// ***********************************************************************
/// Spacing
/// ***********************************************************************

// Dynamically create spacing based on screen real estate size
spaceVertical(context) {
  return SizedBox(height: (MediaQuery.of(context).size.height * .03).roundToDouble());
}

// Dynamically create spacing based on screen real estate size
spaceHorizontal(context) {
  return SizedBox(width: (MediaQuery.of(context).size.height * .01).roundToDouble());
}

// Dynamically create spacing based on screen real estate size
spaceVertical2({context, bool half = false}) {
  double multiplier = 0.03;
  if (half) {
    multiplier = 0.03/2;
  }

  return SizedBox(height: (MediaQuery.of(context).size.height * multiplier).roundToDouble());
}

/// Current Screen Height and relevant sizes
// Screen height: (MediaQuery.of(context).size.height)
// Screen width: (MediaQuery.of(context).size.width)
// (MediaQuery.of(context).padding).top -
// (MediaQuery.of(context).padding).bottom,
// Toolbar height:import 'package:flutter/cupertino.dart';

/// Edge insets (padding, margins)
// TBD

/// ***********************************************************************
/// Misc
/// ***********************************************************************

/// Colors for inkwell taps
class inkWell{
  // primary inkwell splash color
  static Color splashColor1 = Colors.red;
  static Color splashColorHighlight1 = Colors.red.withOpacity(0.5);

  // this is rarely used
  static Color splashColor2 = Colors.blue.withAlpha(30);
}

/// ***********************************************************************
/// Primary Gradients
/// ***********************************************************************

/// Blue gradient background
BoxDecoration backgroundBlueGradient(){
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        primaryColor,
        primaryColorDark1,
      ],
    ),
  );
}

/// ***********************************************************************
/// Opacity
/// ***********************************************************************

/// Opacity
backgroundOpacity(opacity){
  String opacity = 'low';
  late final Color opacityColor;

  if (opacity == 'low') {
    opacityColor = const Color(0x66161B30);
  } else if (opacity == 'medium') {
    opacityColor = const Color(0x8C161B30);
  } else if (opacity == 'high') {
    opacityColor = const Color(0xCC161B30);
  } else {
    // fully opaque
    opacityColor = const Color(0x00161B30);
  }
  return Container(
    decoration: BoxDecoration(
      color: opacityColor,
    ),
  );
}

/// ***********************************************************************
/// Secondary Gradients (rarely used)
/// ***********************************************************************

/// Red to Blue gradient
// the upper half is darker than bottom half (less content)
BoxDecoration blueRedGradient() {
  return const BoxDecoration(
    gradient: LinearGradient(
      tileMode: TileMode.mirror,
      begin: Alignment.bottomLeft,
      end: Alignment(0.1, -1.0),
      colors: [
        Color(0xff6d120c),
        Color(0xff10064a),
      ],
      stops: [
        0,
        1,
      ],
    ),
    backgroundBlendMode: BlendMode.saturation,
  );
}

BoxDecoration gameModeCardGradient(){
  return BoxDecoration(
      borderRadius: borderRadius1(),
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0x9900528E),
          Color(0x9922283D),
        ],
      ),
  );
}

/// ***********************************************************************
/// Judge card Gradients (rarely used)
/// ***********************************************************************

BoxDecoration judgeCardBoxDecoration() {
  return BoxDecoration(
    borderRadius: borderRadius1(),
    gradient: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xFFB31217),
        Color(0xFFE52D27),
      ],
    ),
  );
}

BoxDecoration judgeCardBoxDecorationPending() {
  return BoxDecoration(
    borderRadius: borderRadius1(),
    gradient: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xFF1B2E57),
        Color(0xFF1B2E57),
      ],
    ),
  );
}

BoxDecoration judgeCardBoxDecorationSuccess() {
  return BoxDecoration(
    borderRadius: borderRadius1(),
    gradient: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xFF5D59FF),
        Color(0xFF7672FF),
      ],
    ),);
}

BoxDecoration judgeCardBoxDecorationFail() {
  return BoxDecoration(
    borderRadius: borderRadius1(),
    gradient: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xFF1B2E57),
        Color(0xFF1B2E57),
      ],
    ),
  );
}

/*
Widget temp() {
  return                   Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('01. ${mnemonic[0]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('13. ${mnemonic[12]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('02. ${mnemonic[1]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('14. ${mnemonic[13]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('03. ${mnemonic[2]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('15. ${mnemonic[14]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('04. ${mnemonic[3]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('16. ${mnemonic[15]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('05. ${mnemonic[4]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('17. ${mnemonic[16]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('06. ${mnemonic[5]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('18. ${mnemonic[17]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('07. ${mnemonic[6]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('19. ${mnemonic[18]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('08. ${mnemonic[7]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('20. ${mnemonic[19]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('09. ${mnemonic[8]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('21. ${mnemonic[20]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('10. ${mnemonic[9]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('22. ${mnemonic[21]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('11. ${mnemonic[10]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('23. ${mnemonic[22]} ', style: PrimaryCaption1()),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('12. ${mnemonic[11]} ', style: PrimaryCaption1()),
          SizedBox(width: 32),
          Text('24. ${mnemonic[23]} ', style: PrimaryCaption1()),
        ],
      ),


    ],
  );
}
*/

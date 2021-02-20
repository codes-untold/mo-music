import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TypewriterAnimatedTextKit(
            speed: Duration(milliseconds: 200),
            text: ['Mo-Music🎵'],
            textStyle: TextStyle(fontSize: 40.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'Italianno'),


          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end:Alignment.topLeft,
                colors: [Color(0xff060518), Color(0xff455a64)]
            )
        ),
      ),
    );
  }
}

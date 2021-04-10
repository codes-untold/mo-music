import 'package:flutter/material.dart';
import 'package:momusic/Arguments.dart';

class Rough extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThirdArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(

      backgroundColor: Colors.white,
      body: Center(
        child: FlatButton(
          child: Text("stop"),
          onPressed: (){
            args.audioPlayer.pause();
          },
        ),
      ),
    );
  }
}

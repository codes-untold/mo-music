import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:momusic/DirectoryLogic.dart';
import 'package:momusic/HomeScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class WelcomeScreen extends StatefulWidget {


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

DirectoryLogic directoryLogic = DirectoryLogic();

class _WelcomeScreenState extends State<WelcomeScreen> {

  bool isVisible = false;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  void initState() {

    work();
  }

void work()async{

  await Permission.storage.request();

}


  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Center(
          child: Stack(

            children:
            [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: WelcomeLogo((){
                    setState(() {
                      isVisible = true;
                    });
                    nextSlide();
                   // print("object");
                  }),

              ),
              Positioned(
                bottom: 20,
                left: 5.0,
                right: 5.0,

                child: Visibility(
                  visible: isVisible,
                  child: Container(
                    child: SpinKitWave(
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),

                ),
              )
            ],

          ),
        ),
        decoration:  BoxDecoration(
          color: Color(0xff060518),
          image: DecorationImage(image: AssetImage('images/photo1.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop)),
        ),
      ),
    );
  }



  void nextSlide()async{
  await directoryLogic.fetchData((){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
      musicFiles: directoryLogic.musicFiles,
    )));
    Navigator.pop(context);
  });

  }




  static Widget WelcomeLogo(Function function) {
    return TypewriterAnimatedTextKit(
      textAlign: TextAlign.center,
      alignment: Alignment.center,
      onFinished:function,
      totalRepeatCount: 1,
      speed: Duration(milliseconds: 200),
      text: ['Mo-Music🎵'],
      textStyle: TextStyle(fontSize: 40.0,
          fontWeight: FontWeight.w900,
          fontFamily: 'Italianno',
        textBaseline: TextBaseline.alphabetic
      ),

    );
  }

}




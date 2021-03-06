import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:momusic/DirectoryLogic.dart';
import 'package:momusic/constants.dart';
import 'package:permission_handler/permission_handler.dart';


class WelcomeScreen extends StatefulWidget {


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

DirectoryLogic directoryLogic = DirectoryLogic();

class _WelcomeScreenState extends State<WelcomeScreen> {


  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  void initState() {
    work();
  }

void work()async{

  await Permission.storage.request();

  directoryLogic.fetchData(nextSlide);

}




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
        decoration: gradient_color
      ),
    );
  }


  void nextSlide(){

    for(String list in directoryLogic.musicFiles ){
      print(list);
    }

  }
}


Future<List<FileSystemEntity>> dircontents(Directory dir){
var files = <FileSystemEntity>[];
var complete = Completer<List<FileSystemEntity>>();
var lister = dir.list(recursive: true);
lister.listen((event) {files.add(event);},
onDone: ()=> complete.complete(files),
);
return complete.future;
}



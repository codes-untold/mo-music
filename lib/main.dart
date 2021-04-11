

import 'package:flutter/material.dart';
import 'package:momusic/Data.dart';
import 'package:momusic/HomeScreen.dart';
import 'package:momusic/MusicScreen.dart';
import 'package:momusic/WelcomeScreen.dart';
import 'package:provider/provider.dart';



void main() {

  runApp(ChangeNotifierProvider<Data>(
    create: (context)=> Data(),
    child: MaterialApp(
      initialRoute: '/',

      routes: {
        '/':(context) => WelcomeScreen(),
        '/first':(context) => HomeScreen(),
        '/second':(context) => MusicScreen(),
      },
      debugShowCheckedModeBanner: false,
    ),
  ));
}


import 'package:flutter/material.dart';
import 'package:momusic/CounterText.dart';
import 'package:momusic/constants.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';


class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}



class _MusicScreenState extends State<MusicScreen> {

  Duration _duration = new Duration();
  Duration _position = new Duration();

  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();

  IconData icon = Icons.play_arrow;
  IconData iconRepeat = Icons.repeat;
  bool buttonplay = true;
  bool repeat = false;


  @override
  void initState() {
   initPlayer();
  }


  void playButton(){

    if(buttonplay == true){
      audioCache.play('song.mp3');
      setState(() {
        icon = Icons.pause;
        buttonplay = false;
      });
    }
    else{
      audioPlayer.pause();
      setState(() {
        icon = Icons.play_arrow;
        buttonplay = true;
      });
    }
  }

  void repeatButton(){
    if(repeat == false){
      setState(() {
        iconRepeat = Icons.repeat_one;
        repeat = true;
      });

    }
    else{
      setState(() {
        iconRepeat = Icons.repeat;
        repeat = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 10.0,right: 10,top:75.0,bottom: 0),
     decoration: gradient_color,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
         children: [
           CircleAvatar(
             radius: 75.0,
             backgroundImage: AssetImage('images/moimage.png'),

           ),
           SizedBox(
             height: 20.0,
           ),
           Text('High School Buzz',
           style: TextStyle(
             color: Colors.white,
             fontSize: 20.0,
             fontWeight: FontWeight.w500
           ),),
           SizedBox(
             height: 8.0,
           ),
           Text('J Nikky Feat Sensei',
             style: TextStyle(
                 color: Colors.white54,
                 fontSize: 12.0,
                 fontWeight: FontWeight.w500
             ),),
           SizedBox(
             height: MediaQuery.of(context).size.height * 0.2,
           ),

           Row(

             children: [
               Expanded(child: CounterText(value: _position.inSeconds,),flex: 1,),
               Expanded(
                 child: Slider(
                   value: _position.inSeconds.toDouble(),
                   activeColor: Colors.pinkAccent,
                   inactiveColor:Colors.grey ,
                   onChanged: (double value){
                     setState(() {
                       seekToSecond(value.toInt());
                       value = value;
                     });
                   },
                   min: 0.0,
                   max: _duration.inSeconds.toDouble(),
                 ),
               flex: 7,),
               Expanded(child: CounterText(value: _duration.inSeconds,),flex: 1,),
             ],
           ),

           SizedBox(
             height: 20.0,
           ),

           Flexible(
             child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 IconButton(
                   icon: Icon(Icons.shuffle,
                     color: Colors.white,),
                   onPressed: (){},
                 ),

                 IconButton(
                   icon: Icon(Icons.fast_rewind,
                     color: Colors.white,),
                   onPressed: (){},
                 ),
                 Container(
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(30.0)),
                       color: Colors.pinkAccent,
                       boxShadow: [BoxShadow(
                         color: Colors.grey.withOpacity(0.7),
                         blurRadius: 10.0,
                         spreadRadius: 0.0,

                       )]
                   ),
                   child: IconButton(icon: Icon(icon),
                     color: Colors.white,
                     onPressed: (){
                     playButton();
                     },),

                 ),
                 IconButton(
                   icon: Icon(Icons.fast_forward,
                     color: Colors.white,),
                   onPressed: (){

                   },
                 ),

                 IconButton(
                   icon: Icon(iconRepeat,
                     color: Colors.white,),
                   onPressed: (){
                repeatButton();
                   },
                 ),

               ],),
           ),

         ],

        ),
),
    );
  }

  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }


  void initPlayer(){
    audioPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.durationHandler = (d) {
      setState(() {
        _duration = d;
      });

    };

    audioPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });
  }
}



//audioPlayer = await audioCache.loop('assets/song.mp3');
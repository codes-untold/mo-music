
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:momusic/Data.dart';
import 'package:momusic/MetaData.dart';
import 'package:momusic/Methods.dart';
import 'package:momusic/MusicScreen.dart';
import 'package:momusic/TrackDuration.dart';
import 'package:momusic/constants.dart';
import 'package:provider/provider.dart';
import 'package:move_to_background/move_to_background.dart';


import 'Arguments.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  List <Metadata> metaFiles = [];
  Metadata metaData;
  static List <String> musicFiles = [];
  var retriever = new MetadataRetriever();
  AudioPlayer audioPlayer = AudioPlayer();
  MetaDataWork metaDataWork = MetaDataWork();
  int count =0;


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        if(Provider.of<Data>(context).playing){
          MoveToBackground.moveTaskToBack();
          return false;
        }else{
          return true;
        }

      },
      child: Scaffold(
        body: SafeArea(
          child: Container(

            decoration: gradient_color,
            child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10.0,top: 50.0),
                        alignment: Alignment.topLeft,
                        child: Text('Mo-Music🎵',
                        style:TextStyle(fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Italianno',
                        color: Colors.white),),
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('images/photo1.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop)),
                        ),
                      ),

                FutureBuilder(
                  future: chee() ,
                  initialData: [],
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.done){


                      return musicFiles.isNotEmpty? MusicList(metaFiles: metaFiles,
                        musicFiles: musicFiles,
                        audioPlayer: audioPlayer,

                      ):  Container(
                        height: MediaQuery.of(context).size.height* 0.5,
                        width: MediaQuery.of(context).size.width *0.8,
                        child: Center(
                          child: Text(""
                              "Couldn't fetch music files (Android version < 11)"
                          ,style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white
                            ),
                          textAlign: TextAlign.center,)
                        ),
                      );
                    }
                    else
                      if(snapshot.hasError){
                      throw snapshot.error;
                    }
                    else{
                      return Container(
                        height: MediaQuery.of(context).size.height* 0.5,
                        width: MediaQuery.of(context).size.width *0.8,
                        child: Center(
                          child: SpinKitCircle(
                            color: Colors.white,

                          ),
                        ),
                      );
                    }

                  },
                ),
                    ],
                  ),

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

Future <List> chee()async{

    if(count == 0){
      String tin;
      final ScreenArguments args = ModalRoute.of(context).settings.arguments;
      musicFiles.addAll(args.list);
      print(ModalRoute.of(context).settings.name);
      for(tin in musicFiles){
        await metaDataWork.fetchMetaData(tin);
        metaFiles.add(metaDataWork.metaData);
        count++;

      }
      return metaFiles;
    }


    else{

    }

}
}

class MusicList extends StatefulWidget  {
   MusicList({
    @required this.metaFiles,
    @required this.musicFiles,
    this.audioPlayer
  }) ;

  final List<Metadata> metaFiles;
  final List<String> musicFiles;
  static final Method method = Method();
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {

  //AudioPlayer audioPlayer = AudioPlayer();
  IconData icon;
  int value;
  bool loaded = false;
  bool loadedstate = false;

  @override
  void initState() {
    super.initState();

    value = Method().dowork(widget.musicFiles);
  }

  @override
  Widget build(BuildContext context) {

  icon = Provider.of<Data>(context).playing? Icons.pause:Icons.play_arrow;

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: ListView.builder(itemBuilder: (BuildContext context,int i){
                return Padding(
                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                  child: GestureDetector(
                    onTap: ()async{
                      loaded = true;

                      widget.audioPlayer.pause();
                      widget.audioPlayer.play(widget.musicFiles[i], isLocal: true);


                   Provider.of<Data>(context).selected = i;

                      if(!Provider.of<Data>(context).playing){
                        setState(() {
                          Provider.of<Data>(context).changeState();
                          icon = Icons.pause;
                        });
                      }

                    final result =  await Navigator.pushNamed(context, "/second",arguments:
                     SecondArguments(metaFiles: widget.metaFiles,musicFiles: widget.musicFiles,currentFile: i,audioPlayer: widget.audioPlayer));


                      setState(() {
                        Provider.of<Data>(context).selected = result;
                        print("fgbxdfdfzxdf");

                      });


                    }
                    ,
                    child: MusicTile(trackName: widget.metaFiles[i].trackName,
                      trackDuration: widget.metaFiles[i].trackDuration,
                      ArtistName: widget.metaFiles[i].trackArtistNames,
                      rawFileName: widget.musicFiles[i],
                      currentFile: i,
                      musicFiles: widget.musicFiles,
                      metaFiles: widget.metaFiles,

                    ),
                  ),
                );
              },
                shrinkWrap: true,
                itemCount: widget.metaFiles.length,


              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: ()async{
                  final result =  await Navigator.pushNamed(context, "/second",arguments:
                  SecondArguments(metaFiles: widget.metaFiles,musicFiles: widget.musicFiles,currentFile:
                  Provider.of<Data>(context).selected  == null ? value:Provider.of<Data>(context).selected ,audioPlayer: widget.audioPlayer));
                  if(result == false){
                    setState(() {
                    });
                  }

                },
                child: Container(
                  decoration: gradient_color,
                  child: Row(

                    children: [
                      Expanded(flex: 8,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20.0,
                            ),
                            CircleAvatar(
                              backgroundImage: AssetImage('images/albumart.jpeg'),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Provider.of<Data>(context).selected  == null ? widget.metaFiles[value].trackName == null? MusicList.method.work(widget.musicFiles[value]): widget.metaFiles[value].trackName.length>25
                                    ?"${widget.metaFiles[value].trackName.substring(0,15)}... ": widget.metaFiles[value].trackName:
                                widget.metaFiles[Provider.of<Data>(context).selected ].trackName == null? MusicList.method.work(widget.musicFiles[Provider.of<Data>(context).selected ]): widget.metaFiles[Provider.of<Data>(context).selected ].trackName.length>25
                                    ?"${widget.metaFiles[Provider.of<Data>(context).selected ].trackName.substring(0,15)}... ": widget.metaFiles[Provider.of<Data>(context).selected ].trackName,

                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                      color: Colors.white70
                                  ),),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(Provider.of<Data>(context).selected  == null ? widget.metaFiles[value].trackArtistNames != null?
                                widget.metaFiles[value].trackArtistNames[0]:"Unknown": widget.metaFiles[Provider.of<Data>(context).selected].trackArtistNames != null?
                                widget.metaFiles[Provider.of<Data>(context).selected].trackArtistNames[0]:"Unknown",
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white70
                                  ),),
                              ],
                            ),
                          ],
                        ),),


                      Expanded(flex: 2,
                        child: IconButton(
                          icon: Icon(icon,
                            color: Colors.blue[200],
                          ),
                          onPressed: (){
                              setState(() {

                                if(loaded == false){
                                  if( Provider.of<Data>(context).playing == false){
                                    widget.audioPlayer.play(widget.musicFiles[value], isLocal: true);
                                  loadedstate = true;
                                  print('1st');
                                    Provider.of<Data>(context).changeState();
                                  }
                                  else{
                                    widget.audioPlayer.pause();
                                    loadedstate = false;
                                    print('2nd');
                                    Provider.of<Data>(context).changeState();
                                  }

                                }
                                else{
                                  if( Provider.of<Data>(context).playing == true){

                                    Provider.of<Data>(context).changeState();
                                    icon = Icons.play_arrow;
                                    widget.audioPlayer.pause();
                                  }
                                  else{
                                    Provider.of<Data>(context).changeState();
                                    icon = Icons.pause;
                                    widget.audioPlayer.play(widget.musicFiles[ Provider.of<Data>(context).selected], isLocal: true);
                                  }
                                }

                              });
                              print("e suppose stop");
                          },
                          iconSize: 30.0,

                        ),)],
                  ),
                ),
              ),
            )  ],
        ),
      ),
    );
  }
}


class MusicTile extends StatefulWidget {

  final String rawFileName;
  final String trackName;
  List <dynamic> ArtistName;
  final int trackDuration;

  final List<Metadata> metaFiles;
  final List<String> musicFiles;
  final int currentFile;


  MusicTile({
    this.trackName,
    this.trackDuration,
    this.ArtistName,
    this.rawFileName,
    this.metaFiles,
    this.musicFiles,
    this.currentFile,

});

  @override
  _MusicTileState createState() => _MusicTileState();
}

class _MusicTileState extends State<MusicTile> {

  @override
  Widget build(BuildContext context) {
    TrackDuration trackcount = TrackDuration();
    trackcount.changeDuration(widget.trackDuration);

    int index1 = widget.rawFileName.lastIndexOf("/");
    int index2 = widget.rawFileName.indexOf(".mp3");
    String rawRaw = widget.rawFileName.substring(index1+1,index2);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 10,
          child: Row(
            children: [
              Icon(
                Icons.sort,
                color: Colors.white54,
              ),

              SizedBox(
                width: 30.0,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.metaFiles[widget.currentFile].trackName == null? rawRaw: widget.metaFiles[widget.currentFile].trackName.length >25
                      ?"${widget.metaFiles[widget.currentFile].trackName.substring(0,23)}... ": widget.metaFiles[widget.currentFile].trackName ,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,


                    ),),
                  Text( widget.metaFiles[widget.currentFile].trackArtistNames == null? "Unknown  .${trackcount.minute}"
                      ": ${trackcount.second}": "${widget.metaFiles[widget.currentFile].trackArtistNames[0]} .${trackcount.minute} : ${trackcount.second}",
                    style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        fontSize: 12.0
                    ),)
                ],
              ),
              SizedBox(
                height: 55.0,
              ),


            ],
          ),
        ),
        Expanded(
          flex: 2,
          child:  Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Visibility(
              visible:Provider.of<Data>(context).playing == true? Provider.of<Data>(context).selected==widget.currentFile?true:false:false,
              child: SpinKitWave(
                color: Colors.blue[100],
                size: 15.0,
              ),
            ),
          ),
        )],
    );
  }
}
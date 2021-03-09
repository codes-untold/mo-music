

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:momusic/MetaData.dart';
import 'package:momusic/constants.dart';

class HomeScreen extends StatelessWidget {

  List <String> musicFiles = [];
  HomeScreen({this.musicFiles});
  MetaDataWork metaDataWork = MetaDataWork();


  var retriever = new MetadataRetriever();
  @override
  Widget build(BuildContext context) {

    //chee();
    return Scaffold(

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
                  ],
                ),

              ),

              Expanded(
                flex:1 ,
                child: Container(
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
                          Text("John Harley",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                              fontSize: 15.0,
                            color: Colors.white70
                          ),),
                          SizedBox(
                            height: 2.0,
                          ),
                          Text("sing out!",
                          style: TextStyle(
                            fontSize: 12.0,
                              color: Colors.white70
                          ),),
                        ],
                      ),
                      SizedBox(
                        width:  MediaQuery.of(context).size.width * 0.28,
                      ),


                   IconButton(
                     icon: Icon(Icons.play_arrow,
                       color: Colors.pinkAccent,
                    ),
                     onPressed: (){

                     },
                     iconSize: 30.0,

                   ) ],
                  ),
                  decoration: gradient_color
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
void chee()async{
  await metaDataWork.fetchMetaData(musicFiles[0]);
   print(metaDataWork.metaData.trackDuration);

}
}


import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:momusic/MetaData.dart';
import 'package:momusic/TrackDuration.dart';
import 'package:momusic/constants.dart';

class HomeScreen extends StatefulWidget {

  List <String> musicFiles = [];

  HomeScreen({this.musicFiles});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <Metadata> metaFiles = [];

  Metadata metaData;

  var retriever = new MetadataRetriever();

  MetaDataWork metaDataWork = MetaDataWork();





  @override
  void initState() {

  }



  @override
  Widget build(BuildContext context) {
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

              FutureBuilder(
                future: chee() ,
                builder: (context,snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    return MusicList(metaFiles: metaFiles,
                      musicFiles: widget.musicFiles,
                    );
                  }
                  else if(snapshot.hasError){
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
                       color: Colors.blue[200],
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

Future <List> chee()async{
String tin;
    for(tin in widget.musicFiles){
      await metaDataWork.fetchMetaData(tin);
      metaFiles.add(metaDataWork.metaData);
    }

return metaFiles;
}
}

class MusicList extends StatelessWidget {
  const MusicList({
    @required this.metaFiles,
    @required this.musicFiles
  }) ;

  final List<Metadata> metaFiles;
  final List<String> musicFiles;

  @override
  Widget build(BuildContext context) {
    return Flexible(
       child: Padding(
         padding: const EdgeInsets.only(top: 5.0,left: 5.0,right: 5.0),
         child: ListView.builder(itemBuilder: (BuildContext context,int i){

           return MusicTile(trackName: metaFiles[i].trackName,
             trackDuration: metaFiles[i].trackDuration,
             ArtistName: metaFiles[i].writerName,
             rawFileName: musicFiles[i],

           );
         },
           shrinkWrap: true,
           itemCount: metaFiles.length,

         ),
       ),
     );
  }
}


class MusicTile extends StatelessWidget {

  final String rawFileName;
  final String trackName;
  final String ArtistName;
  final int trackDuration;


  MusicTile({
    this.trackName,
    this.trackDuration,
    this.ArtistName,
    this.rawFileName

});


  @override
  Widget build(BuildContext context) {
    TrackDuration trackcount = TrackDuration();
    trackcount.changeDuration(trackDuration);
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
                  Text(trackName == null? "Unknown": trackName.length>25
                      ?"${trackName.substring(0,23)}... ": trackName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,


                    ),),
                  Text( ArtistName == null? "Sing out  .${trackcount.minute}"
                      ": ${trackcount.second}": ArtistName,
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
            child: SpinKitWave(
              color: Colors.white,
              size: 15.0,
            ),
          ),
        )],
    );
  }
}
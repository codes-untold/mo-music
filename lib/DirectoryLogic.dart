
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DirectoryLogic{

  List <String> musicFiles = [];

  fetchData(Function function)async{

    if(await Permission.storage.isGranted){
      print('granted');

    }
    else{
      await Permission.storage.request();
    }


    final Directory dir =  Directory((await getExternalStorageDirectory()).path.toString().substring(0,20));

    dir.list(recursive: true).listen((FileSystemEntity entity) {
      if(entity.path.contains('mp3') ){
        musicFiles.add(entity.path);
      }

    },onDone: function,);

  }

//  final Directory extDir = await getExternalStorageDirectory();
//final String dirpath = extDir.path.toString().substring(0,20);
//  print(dirpath);



}
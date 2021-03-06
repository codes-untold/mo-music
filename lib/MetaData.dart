import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class MetaData{



  void fetchMetaData(String path)async{
    var retriever = new MetadataRetriever();
    await retriever.setFile(new File(path));
    Metadata metaData = await retriever.metadata;


  }

}
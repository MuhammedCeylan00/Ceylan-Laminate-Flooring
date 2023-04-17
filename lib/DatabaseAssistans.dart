import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAssistans{

  static final String databaseName="Ceylan_app.sqlite";

  static Future<Database> databaseAccess() async {
    String databasePath= join(await getDatabasesPath(),databaseName);

    if(await databaseExists(databasePath)){
      print("Veri tabanı zaten var kopyalamaya gerek yok");
    }else{
      ByteData data = await rootBundle.load("database/$databaseName");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      await File(databasePath).writeAsBytes(bytes,flush:true);
      print("Veri tabanı kopylaandı.");
    }

    return openDatabase(databasePath);
  }


}
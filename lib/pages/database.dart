// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/recordMyLife.dart';

class DataBase extends StatefulWidget{
  const DataBase({Key? key}) : super(key: key);

  @override
  _DataBaseState createState() => _DataBaseState();
}

class _DataBaseState extends State<DataBase>{
  String datas = '';

  static const version = 1;
  static const fileName = 'recordmylife.db';

  Future<Database> database() async {
    // Open the database and store the reference.
    return  openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      // Set the path to the database.
      join(await getDatabasesPath(), fileName),

      // When the database is first created, create a table to store db file.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        // sqllite data tyle은 5가지: https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=tokimdh77&logNo=220561836945
        return db.execute(
          "CREATE TABLE recordmylife(id INTEGER PRIMARY KEY, date TEXT, lng REAL, lat REAL, memo TEXT)",
        );
      },
      
      // table정보가 변경되었을 경우 사용함.
      //onUpgrade: (db, oldVersion, newVersion){ if (oldVersion < newVersion){ ... } },

      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: version,
    );
  }

  // 데이터베이스에 추가하는 함수를 정의합니다.
  Future<void> insert(RecordMyLife recordMyLife) async {
    // 데이터베이스 reference를 얻습니다.
    final Database db = await database();

    await db.insert(
      'recordmylife',
      recordMyLife.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> upate(RecordMyLife recordMyLife) async {
    // 데이터베이스 reference를 얻습니다.
    final db = await database();

    // 주어진 Dog를 수정합니다.
    await db.update(
      'recordmylife',
      recordMyLife.toMap(),
      // id가 일치하는 지 확인합니다.
      where: "id = ?",
      // id를 whereArg로 넘겨 SQL injection을 방지합니다.
      whereArgs: [recordMyLife.id],
    );
  }

  Future<void> delete(int id) async {
    // 데이터베이스 reference를 얻습니다.
    final db = await database();

    // 데이터베이스에서 Dog를 삭제합니다.
    await db.delete(
      'recordmylife',
      where: "id = ?",
      // id를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [id],
    );
  }

  Future<List<RecordMyLife>> findAll() async {
    // 데이터베이스 reference를 얻습니다.
    final Database db = await database();

    // 모든 Dog를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('recordmylife');

    // List<Map<String, dynamic>를 List<Dog>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return RecordMyLife(
        id: maps[i]['id'],
        date: maps[i]['date'],
        lng: maps[i]['lng'],
        lat: maps[i]['lat'],
        memo: maps[i]['memo'],
      );
    });
  }

  void insertData() async {
      RecordMyLife recordMyLife1 = RecordMyLife(id: 1, date: '20220222', lng: 100, lat: 100, memo: '메모1');
      RecordMyLife recordMyLife2 = RecordMyLife(id: 2, date: '20220222', lng: 50, lat: 50, memo: '메모2');
      RecordMyLife recordMyLife3 = RecordMyLife(id: 3, date: '20220222', lng: 500, lat: 500, memo: '메모3');
      RecordMyLife recordMyLife4 = RecordMyLife(id: 4, date: '20220222', lng: 0, lat: 0, memo: '메모4');

      await insert(recordMyLife1);
      await insert(recordMyLife2);
      await insert(recordMyLife3);
      await insert(recordMyLife4);
  }

  // ignore: non_constant_identifier_names
  void Find() async {
    List<RecordMyLife> listdata = await findAll();

    for(int i =0; i<listdata.length; i++ ) {      
      datas += ('[' + i.toString() + '] ' +  listdata[i].toString() + '\n');
    } 

    // 화면을 다시 그리기 위해 사용함.
    setState(() {
      // print(datas);       
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SingleChildScrollView (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,        
          children: <Widget>[ 
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton( 
                  child: const Text("Insert"), 
                  onPressed: insertData, 
                ),
                ElevatedButton( 
                  child: const Text("Update"), 
                  onPressed: insertData, 
                ),
                ElevatedButton( 
                  child: const Text("FindAll"), 
                  onPressed: Find, 
                ),                
              ]
            ),            
            Text(datas),
          ]
        ), 
      ),
    );
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoritePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => FavoritePageState();

}

class FavoritePageState extends State<FavoritePage> {
  TestDataProvider provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Row(
      children: <Widget>[
        RaisedButton(
          onPressed: add,
          child: Text("增", style: TextStyle(fontSize: 20)),
        ),
        RaisedButton(
          onPressed: del,
          child: Text("删", style: TextStyle(fontSize: 20)),
        ),
        RaisedButton(
          onPressed: update,
          child: Text("改", style: TextStyle(fontSize: 20)),
        ),
        RaisedButton(
          onPressed: search,
          child: Text("查", style: TextStyle(fontSize: 20)),
        ),
      ],
    ),) ;
  }

  void add() async {
    provider.add(Test("张三",20));
    provider.add(Test("李四",21));
    provider.add(Test("王五",22));
  }

  void del() {
    provider.del("张三");
  }

  void update() {
    provider.update(Test("李四",28));

  }

  void search() {
    provider.searchAll();
  }

  @override
  void initState() {
    super.initState();
    provider = TestDataProvider();
    provider.open();
  }
  @override
  void dispose() {
    super.dispose();
    provider.close();
    print("close====database");
  }
}

class Test {
  int id;
  String name;
  int value;

  Test( this.name, this.value,{this.id});

  Test.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
  @override
  String toString() {
    return '{id=$id;name=$name;value=$value}';

  }
}

class TestDataProvider {
  Database db;
  static const String table_name = 'table_db';
  static const String test_id = 'id';
  static const String test_name = 'name';
  static const String test_value = 'value';

//打开数据库　
  Future open() async {
    String path = join(await getDatabasesPath(), table_name);
    db = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute("""
      create table $table_name(
      $test_id integer primary key autoincrement,
      $test_name text not null,
      $test_value integer not null)
      """);
    });
  }

//  增
  Future<Test> add(Test test) async
  {
    test.id = await db.insert(table_name, test.toJson());
    return test;
  }

//  删
  Future<int> del(String name) async {
    return await db.delete(
        table_name, where: '$test_name=?', whereArgs: [name]);
  }

//  改
  Future update(Test test) async {
    await db.update(table_name, test.toJson(), where: '$test_name=?',
        whereArgs: [test.name]);
  }

//  查
  Future<Test> search(String name) async {
    List<Map> mapList = await db.query(
        table_name, where: '$test_name=?', whereArgs: [name]);
    if (mapList != null && mapList.length != 0) {
      return Test.fromJson(mapList.first);
    }
    return null;
  }

  Future searchAll() async{
    List<Map> mapList = await db.query(table_name);
    List<Test>res =  mapList.map((m){
      return Test.fromJson(m);
    }).toList();
    print(res.toString());
  }

//  关闭数据库
  Future close() async => db.close();

}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wan_android_flutter/database/sqflite_helper.dart';
class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Favorite"),),
    body: RaisedButton(onPressed: (
        ){
     SqlFlutterHelper.instance.articleDao.search();
//      SqlFlutterHelper.instance..test="123"..test="456"..
    }),);

  }
}

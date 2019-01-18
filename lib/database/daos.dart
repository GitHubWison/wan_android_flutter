import 'dart:async';

import 'package:wan_android_flutter/beans/entity.dart';
import 'package:sqflite/sqflite.dart';

class ArticleDao extends DaoCommon {
  static const tableName = "Article";
  static const CREATE_SQL =
      'CREATE TABLE $tableName (_id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'fresh INTEGER,apkLink TEXT,envelopePic TEXT,id INTEGER,origin TEXT,'
      'zan INTEGER,title TEXT,type INTEGER,link TEXT,superChapterId INTEGER,'
      'courseId INTEGER,chapterName TEXT,collect INTEGER,desc TEXT,'
      'chapterId INTEGER,publishTime INTEGER,userId INTEGER,projectLink TEXT,'
      'superChapterName TEXT,visible INTEGER,niceDate TEXT,author TEXT)';

  ArticleDao(Database db) : super(db);

  Future<Null> insert(Article article) async {
    await db.insert(tableName, article.toJson());
  }

  Future<Null> search() async {
    List tempList = await db.query(tableName);
    List<Article> list = tempList.map((m) {
      return Article.fromJson(m);
    }).toList();
    print(list.toString());
  }
}

class TreeDao {}

class SystemDao {}

abstract class DaoCommon {
  final Database db;

  DaoCommon(this.db);
}

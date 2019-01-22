import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wan_android_flutter/beans/entity.dart';

class WandAndroidDataBaseHelper {
  static Database _dataBase;

  static Future<Database> getDb() async {
    if (_dataBase == null) {
      var path = join(await getDatabasesPath(), 'wa.db');
      _dataBase = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
//        建表
        print("=====开始建表=====");
        db.execute('''
      CREATE TABLE ${ArticleDao.tb_name} (_id INTEGER PRIMARY KEY AUTOINCREMENT,
      chapterId INTEGER,apkLink TEXT,tags TEXT,chapterName TEXT,
      superChapterId INTEGER,desc TEXT,type INTEGER,courseId INTEGER,
      link TEXT,visible INTEGER,title TEXT,origin TEXT,zan INTEGER,
      userId INTEGER,superChapterName TEXT,collect INTEGER,publishTime INTEGER,
      id INTEGER,envelopePic TEXT,fresh INTEGER,projectLink TEXT,niceDate TEXT,
      author TEXT)
      ''');
        db.execute('''
            CREATE TABLE ${TagsDao.tb_name} 
            (_id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,
            url TEXT,id INTEGER)
            ''');
        print("=====建表结束=====");
      });
    }
    return _dataBase;
  }
}

class ArticleDao {
  static const tb_name = 'article_tb';
  static ArticleDao _instance;

  factory ArticleDao() => _getInstance();
  ArticleDao._internal();
  static ArticleDao get instance => _getInstance();

  static ArticleDao _getInstance() {
    if (_instance == null) {
      _instance =  ArticleDao._internal();
    }
    return _instance;
  }

  Future<int> insert(Article article) async {
    Database db = await WandAndroidDataBaseHelper.getDb();
    var tagsList = article.tags;
    tagsList.forEach((tag) async {
      tag.id = article.id;
      await TagsDao.instance.insert(tag);
    });
    article.tags = [];
    var temJson = article.toJson();
    return await db.insert(tb_name, temJson);
  }

  Future<List<Article>> getFavorite() async {
    Database db = await WandAndroidDataBaseHelper.getDb();
    var temp = await db.query(tb_name);
    var articleList = List<Article>();
    for (var value in temp) {
      var art = Article.fromJson(value);
      art.tags = await TagsDao.instance.getTagsById(art.id);
      articleList.add(art);
    }
    return articleList;
  }
}

class TagsDao {
  static const tb_name = 'tags_tb';
  static TagsDao _instance;

  factory TagsDao() => _getInstance();
  TagsDao._internal();
  static TagsDao get instance => _getInstance();

  static TagsDao _getInstance() {
    if (_instance == null) {
      _instance = TagsDao._internal();
    }
    return _instance;
  }

  Future<int> insert(Tags tags) async {
    Database db = await WandAndroidDataBaseHelper.getDb();
    return await db.insert(tb_name, tags.toJson());
  }

  Future<List<Tags>> getTagsById(int id) async {
    Database db = await WandAndroidDataBaseHelper.getDb();
    var temp = await db.query(tb_name, where: 'id=?', whereArgs: [id]);
    return temp.map((m) {
      return Tags.fromJson(m);
    }).toList();
  }
}

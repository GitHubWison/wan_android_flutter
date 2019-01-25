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
      CREATE TABLE ${FavoriteArticleDao.tb_name} (_id INTEGER PRIMARY KEY AUTOINCREMENT,
      chapterName TEXT,originId INTEGER,origin TEXT,desc TEXT,author TEXT,
      courseId INTEGER,chapterId INTEGER,title TEXT,zan INTEGER,
      publishTime INTEGER,niceDate TEXT,userId INTEGER,visible INTEGER,
      link TEXT,id INTEGER,envelopePic TEXT)
      ''');
        db.execute('''
            CREATE TABLE ${TagsDao.tb_name} 
            (_id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,
            url TEXT,id INTEGER)
            ''');
      });
    }
    return _dataBase;
  }
}

class FavoriteArticleDao {
  static const tb_name = 'favorite_article_tb';
  static FavoriteArticleDao _instance;

  static FavoriteArticleDao get instance => _getInstance();

  factory FavoriteArticleDao() => _getInstance();

  static FavoriteArticleDao _getInstance() {
    if (_instance == null) {
      _instance = FavoriteArticleDao._internal();
    }
    return _instance;
  }

  FavoriteArticleDao._internal();

//插入收藏的列表
  Future<Null> insert(List<FavoriteArticle> list) async {
    Database db = await WandAndroidDataBaseHelper.getDb();
    for (var value in list) {
      await db.insert(tb_name, value.toJson());
    }
    return null;
  }
//插入单个文章
  Future<Null> insertSingleArticle(FavoriteArticle article) async {
    Database db = await WandAndroidDataBaseHelper.getDb();
    await db.insert(tb_name, article.toJson());
    return null;
  }

//  删除所有收藏
  Future<Null> deleteAll() async {
    Database db = await WandAndroidDataBaseHelper.getDb();
    db.delete(tb_name);
    return null;
  }

//  删除指定的文章
  Future<Null> deleteArticleWithId(int id) async {
    Database db = await WandAndroidDataBaseHelper.getDb();
    db.delete(tb_name, where: 'id=?', whereArgs: [id]);
    return null;
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
      _instance = ArticleDao._internal();
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

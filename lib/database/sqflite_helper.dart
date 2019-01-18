import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wan_android_flutter/database/daos.dart';

class SqlFlutterHelper {
  var test = "123";
  Database database;
  ArticleDao articleDao;
  static final SqlFlutterHelper instance = SqlFlutterHelper();

  factory SqlFlutterHelper({ttt, ddd, ss, ff}) => SqlFlutterHelper.internal();

  SqlFlutterHelper.internal() {
    openSQLiteDataBase();
    articleDao = ArticleDao(database);
  }

  void openSQLiteDataBase() async {
    var dataBasePath = await getDatabasesPath();
    var path = join(dataBasePath, "wanandroid.db");

    database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(ArticleDao.CREATE_SQL);
    });
  }
}

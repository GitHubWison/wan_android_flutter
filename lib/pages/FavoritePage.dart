import 'package:flutter/material.dart';
import 'package:wan_android_flutter/database/WanAndroidDataBase.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: RaisedButton(onPressed: () {
        () async {
          var artList = await ArticleDao.instance.getFavorite();
          artList.forEach((m) {
            print(m.toJson());
          });
        }();
      }),
    );
  }
}

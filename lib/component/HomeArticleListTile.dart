import 'package:flutter/material.dart';
import 'package:wan_android_flutter/WanAndroidNativeChannel.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/ArticlePadding.dart';
class HomeArticleListTile extends StatelessWidget {
  final Article article;

  HomeArticleListTile(this.article);

  @override
  Widget build(BuildContext context) {
    Column _column1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('作者:'),
            Text(
              '${article.author}',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        ArticlePadding(),
        Text(
          '${article.title}',
          style: TextStyle(fontSize: 18),
        ),
        ArticlePadding(),
        Text(
          '${article.chapterName}',
          style: TextStyle(color: Colors.blue),
        )
      ],
    );
    Column _column2 = Column(
      children: <Widget>[
        Text('${article.niceDate}'),
        ArticlePadding(),
        Icon(Icons.favorite_border)
      ],
    );
    return GestureDetector(
      onTap: openWebView,
      child: Card(
        elevation: 0,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _column1,
                ),
                _column2
              ],
            )),
      ),
    );
  }

  void openWebView() async {
    await WanAndroidNativeChannel.showWebView(article);
  }
}

import 'package:flutter/material.dart';
import 'package:wan_android_flutter/beans/entity.dart';

class FavoriteArticleList extends StatelessWidget {
  final onRefresh;
  final onLoadMore;
  final List<FavoriteArticle> list;

  FavoriteArticleList(
    this.list,
    this.onRefresh,
    this.onLoadMore,
  );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
          itemBuilder: (context, index) {
            var temp = list[index];
            return FavoriteArticleTile(temp);
          },
          itemCount: list.length,
          physics: AlwaysScrollableScrollPhysics(),
          controller: _getListViewController(),
        ),
        onRefresh: onRefresh);
  }

  ScrollController _getListViewController() {
    ScrollController controller = ScrollController();
    controller.addListener(() {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        onLoadMore();
      }
    });
    return controller;
  }
}

class FavoriteArticleTile extends StatelessWidget {
  final FavoriteArticle article;

  FavoriteArticleTile(this.article);

  @override
  Widget build(BuildContext context) {
    return Card(
      child:  Padding(padding: EdgeInsets.all(10),child: Row(
        children: <Widget>[

          Expanded(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(article.title,style: TextStyle(color: Colors.black,fontSize: 22),),
                ),
                Align(
                    alignment: Alignment.centerLeft, child: Text(article.desc,style: TextStyle(color: Colors.grey,fontSize: 18),maxLines: 2,semanticsLabel: '...',)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('${article.publishTime} @${article.author}',style: TextStyle(color: Colors.grey,fontSize: 15),)),
              ],
            ),
          ),
          Icon(Icons.delete)
        ],
      ),) ,
    );
  }
}

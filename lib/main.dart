import 'package:flutter/material.dart';
import 'package:wan_android_flutter/pages/KnowLedgeArticle.dart';
import 'WanAndroidPage.dart';
void main()=>runApp(new MaterialApp(
  home: new WanAndroidPage(),
  routes: {
    '/knowledge_article_list':(context){
      return KnowledgeArticleList();
    }
  },
));
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/WanAndroidPage.dart';
import 'package:wan_android_flutter/pages/KnowLedgeArticleV2.dart';
import 'package:wan_android_flutter/pages/LoginPage.dart';

const String knowledgeArticleRoute = '/knowledgeArticleRoute';
const String wanAndroidRoute = '/wanAndroidRoute';
const String loginRoute = '/loginRoute';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  knowledgeArticleRoute: (BuildContext context) => KnowLedgeArticleV2(),
  wanAndroidRoute: (BuildContext context) => WanAndroidPage(),
  loginRoute:(BuildContext context)=>LoginPage(),
};
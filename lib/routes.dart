import 'package:flutter/material.dart';
import 'package:wan_android_flutter/pages/KnowLedgeArticleV2.dart';

const String knowledgeArticleRoute = '/knowledgeArticleRoute';
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  knowledgeArticleRoute: (BuildContext context) => KnowLedgeArticleV2(),

};
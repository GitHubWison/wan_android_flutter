import 'package:flutter/material.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/pages/SplashPage.dart';
import 'package:wan_android_flutter/routes.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:wan_android_flutter/redux_state.dart';
import 'WanAndroidPage.dart';

void main() => runApp(StoreProvider(
    store: Store(
      reduce,
      initialState: WanAndroidState(
          homeArticleList: List(),
          homeBannerList: List(),
          treeList: List(),
          knowledgeInfo: KnowledgeSys(children: List())),
    ),
    child: MaterialApp(
      home: SplashPage(),
      routes: routes,
    )));

//数据仓库
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/Snack.dart';
import 'package:wan_android_flutter/database/WanAndroidDataBase.dart';
import 'package:wan_android_flutter/http/ApiAddress.dart';
import 'package:wan_android_flutter/redux_state.dart';
import 'package:wan_android_flutter/http/DioHelper.dart';

class WanAndroidRepository {
  static WanAndroidRepository _instance;
  static Store<WanAndroidState> storeTest;

  factory WanAndroidRepository() => _getInstance();

  static WanAndroidRepository get instance => _getInstance();

  static WanAndroidRepository _getInstance() {
    if (_instance == null) {
      _instance = WanAndroidRepository.internal();
    }
    return _instance;
  }

  WanAndroidRepository.internal();

//获取首页的文章列表
  void getHomeArticleListWithPageNo(Store<WanAndroidState> store,
      {int pageNo = 0}) {
    WanAndroidDio.instance.doGet("article/list/$pageNo/json",
        onSuccess: (data,r) {
      Data tempData = Data.fromJson(data.data);
      List<Article> responseList = tempData.datas;
      List<Article> resList = store.state.homeArticleList;
      if (pageNo == 0) {
//        需要刷新
        resList.clear();
      }
      resList.addAll(responseList);
      store.dispatch(HomeArticleListAction(resList));
    });
  }

//获取首页的广告列表
  void getHomeBannerList(Store<WanAndroidState> store) {
    WanAndroidDio.instance.doGet("banner/json",
        onSuccess: (data,r) {
      List tempList = data.data;
      List<BannerBean> responseList = tempList.map((m) {
        return BannerBean.fromJson(m);
      }).toList();
      List<BannerBean> originalList = store.state.homeBannerList;
      originalList.clear();
      originalList.addAll(responseList);
      store.dispatch(RefreshHomeBannerListAction(originalList));
    });
  }

//  获取知识树
  void getTree(Store<WanAndroidState> store) {
    WanAndroidDio.instance.doGet("tree/json", onSuccess: (WanAndroidBean data,r) {
      List temp = data.data;
      List<KnowledgeSys> responseList = temp.map((m) {
        return KnowledgeSys.fromJson(m);
      }).toList();
      List<KnowledgeSys> originalList = store.state.treeList;
      originalList.clear();
      originalList.addAll(responseList);
      store.dispatch(RefreshTreeAction(originalList));
    });
  }

  void getKnowledgeInfo(Store<WanAndroidState> store, KnowledgeSys info) {
    store.dispatch(RefreshKnowledgeInfoAction(info));
  }

//  获取知识树中某一个知识下的某个领域的内容
  void getKnowledgeUnderTree(
      Store<WanAndroidState> store, int cid, int pageNo, int indicateIndex) {
    WanAndroidDio.instance.doGet('article/list/$pageNo/json?cid=$cid',
        onSuccess: (WanAndroidBean data,r) {
      Data allData = Data.fromJson(data.data);
      List<Article> tempList = allData.datas;
      KnowledgeSys originalInfo = store.state.knowledgeInfo;
      Children originalArticleList = originalInfo.children[indicateIndex];
      if (pageNo == 0) {
        originalArticleList.children.clear();
      }
      originalArticleList.children.addAll(tempList);

      store.dispatch(RefreshKnowledgeInfoAction(originalInfo));
    });
  }

//  获取收藏的文章
  void getFavoriteArticleList(Store<WanAndroidState> store) async {
    var favList = await ArticleDao.instance.getFavorite();
    store.dispatch(RefreshFavoriteListAction(favList));
  }

//  添加收藏的文章
  void addFavoriteArticleList(
      Store<WanAndroidState> store, Article article) async {
//    将添加的文章放入数据库中
    await ArticleDao.instance.insert(article);
    store.dispatch(AddFavoriteListAction(article));
  }

//  登录
  void login(Store<WanAndroidState> store, String userName, String passWord,
  {AfterSuccess afterSuccess}) async {
    WanAndroidDio.instance.doPost(ApiAddress.login_api,
        data: FormData.from({'username': userName, 'password': passWord}),
        onSuccess: (WanAndroidBean data,Response r) {
      UserInfo userInfo = UserInfo.fromJson(data.data);
      String resCookie = '';
      r.headers.forEach((String name,List<String>values){
        if (name=='set-cookie') {
          values.forEach((cookieStr){
            resCookie='$resCookie''$cookieStr'';';
          });
        }
      });
      WanAndroidDio.instance.setCookie(resCookie);
      store.dispatch(RefreshUserInfoAction(userInfo));
      if(afterSuccess!=null){
        afterSuccess();
      }
//      Navigator.of(context).pop();
    });
  }

//  收藏列表
  void getFavoriteListFromNet(Store<WanAndroidState> store,int pageNo){
    WanAndroidDio.instance.doGet(ApiAddress.favoriteApi(pageNo));
  }
}
typedef void AfterSuccess();

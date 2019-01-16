//数据仓库
import 'package:redux/redux.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/redux_state.dart';
import 'package:wan_android_flutter/http/DioHelper.dart';

class WanAndroidRepository {
  static WanAndroidRepository _instance;

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
        onSuccess: (WanAndroidBean data) {
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
        onSuccess: (WanAndroidBean data) {
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
}

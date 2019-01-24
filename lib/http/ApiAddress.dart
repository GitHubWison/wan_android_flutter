class ApiAddress {
//  登录
  static const login_api = 'user/login';

//  收藏
  static String favoriteApi(int pageNo) => 'lg/collect/list/$pageNo/json';
}

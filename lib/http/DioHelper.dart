import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/WanAndroidNativeChannel.dart';
import 'package:wan_android_flutter/beans/entity.dart';
class WanAndroidDio {
//  errorCode = 0 代表执行成功，不建议依赖任何非0的 errorCode.
//errorCode = -1001 代表登录失效，需要重新登录。
  static const SUCCESS_CODE = 0;
  var cookie = '';
// 工厂模式
  factory WanAndroidDio() => _getInstance();

  static WanAndroidDio get instance => _getInstance();
  static WanAndroidDio _instance;
  Dio _dio;
  WanAndroidDio._internal() {
    // 初始化
    _dio = new Dio(Options(baseUrl: 'http://www.wanandroid.com/'));
  }

  static WanAndroidDio _getInstance() {
    if (_instance == null) {
      _instance = new WanAndroidDio._internal();
    }
    return _instance;
  }

  void doPost(String address,
      {data,options,OnSuccess onSuccess,ServerFailure onSerFailure,NetError onNetError,Finish onFinish}) async {
    _httpRequest(address,
        data: data,
        options:options,
        onSuccess: onSuccess,
        onFinish: onFinish,
        onSerFailure: onSerFailure,
        isGet: false);
  }

  void doGet(String address,
      {data,options,OnSuccess onSuccess,ServerFailure onSerFailure,NetError onNetError,Finish onFinish}) async {
    _httpRequest(address,
        data: data,
        options:options,
        onSuccess: onSuccess,
        onFinish: onFinish,
        onSerFailure: onSerFailure,
        isGet: true);
  }

  void _httpRequest(String address,
      {bool isGet = true,
      data,
      options,
        OnSuccess onSuccess,
        ServerFailure onSerFailure,
        NetError onNetError,
        Finish onFinish}) async {

    Map<String, String>  map = Map();
    map["Cookie"] = cookie;
    Response r ;
    try{
      r  = isGet
    ? await _dio.get(address, data: data, options: Options(headers: map))
        : await _dio.post(address, data: data,options: Options(headers: map));
    }catch(e){

    }
    if(r==null){
      if(onNetError!=null){
        onNetError(-1,null);
      }
      return;
    }
    if (r.statusCode == 200) {
      final WanAndroidBean responseData = WanAndroidBean.fromJson(r.data);
      if (responseData.errorCode == SUCCESS_CODE) {
//        请求成功
        if (onSuccess != null) {
          onSuccess(responseData,r);
        }
      } else {
//        服务端报错
        if (onSerFailure != null) {
          onSerFailure( responseData,r);
        }
        await WanAndroidNativeChannel.showToast(responseData.errorMsg);
      }
      print("""
          ===========================================
          ==请求url:${_dio.options.baseUrl}$address
          ==请求参数:${data.toString()}
          ==请求结果:${r.data}
          ===========================================
          """);
    } else {
      await WanAndroidNativeChannel.showToast('${r.statusCode}');
//      404,406等
      if (onNetError != null) {
        onNetError(r.statusCode,r);
      }
      print("""
      ===============================
      ==onNetError=${r.statusCode}
      ===============================
      """);
    }
    if (onFinish != null) {
      onFinish();
    }
  }

  void setCookie(String resCookie) {this.cookie = resCookie;}
  void clearCookie(){
    this.cookie = '';
  }
}
typedef void OnSuccess(WanAndroidBean data,Response response);
typedef void ServerFailure( WanAndroidBean data,Response response);
typedef void NetError(int statusCode,Response response);
typedef void Finish();


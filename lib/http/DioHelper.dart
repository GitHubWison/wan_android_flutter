import 'package:dio/dio.dart';
import 'package:wan_android_flutter/beans/entity.dart';

class DioHelper {
  static get dio => _getDio();
  static Dio _dio;

  static _getDio() {
    if (_dio == null) {
      _dio = new Dio(Options(baseUrl: 'http://www.wanandroid.com/'));
    }
    return _dio;
  }
}

class WanAndroidDio {
//  errorCode = 0 代表执行成功，不建议依赖任何非0的 errorCode.
//errorCode = -1001 代表登录失效，需要重新登录。
  static const SUCCESS_CODE = 0;

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
      {data, onSuccess, onSerFailure, onNetError, onFinish}) async {
    _httpRequest(address,
        data: data,
        onSuccess: onSuccess,
        onFinish: onFinish,
        onSerFailure: onSerFailure,
        isGet: false);
  }

  void doGet(String address,
      {data, onSuccess, onSerFailure, onNetError, onFinish}) async {
    _httpRequest(address,
        data: data,
        onSuccess: onSuccess,
        onFinish: onFinish,
        onSerFailure: onSerFailure,
        isGet: true);
  }

  void _httpRequest(String address,
      {bool isGet = true,
      data,
      onSuccess,
      onSerFailure,
      onNetError,
      onFinish}) async {
    Response r = isGet
        ? await _dio.get(address, data: data)
        : await _dio.post(address, data: data);
    if (r.statusCode == 200) {
      final WanAndroidBean responseData = WanAndroidBean.fromJson(r.data);
      if (responseData.errorCode == SUCCESS_CODE) {
//        请求成功
        if (onSuccess != null) {
          onSuccess(responseData);
        }
      } else {
//        服务端报错
        if (onSerFailure != null) {
          onSerFailure(responseData);
        }
      }
      print("""
          ===========================================
          ==请求url:${_dio.options.baseUrl}$address
          ==请求参数:${data.toString()}
          ==请求结果:${r.data}
          ===========================================
          """);
    } else {
//      404,406等
      if (onNetError != null) {
        onNetError(r.statusCode);
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
}

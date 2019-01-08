import 'package:flutter/services.dart';
import 'package:wan_android_flutter/beans/entity.dart';

class WanAndroidNativeChannel {
  static const _channel = const MethodChannel('native.wan.android');

  static showWebView(Article article) async {
    _channel.invokeMethod("showWebView",article.toJson());
  }
}

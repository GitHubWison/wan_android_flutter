import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_flutter/beans/entity.dart';
import 'package:wan_android_flutter/component/ArticlePadding.dart';
import 'package:wan_android_flutter/component/EditTextWithClearState.dart';
import 'package:wan_android_flutter/component/Snack.dart';
import 'package:wan_android_flutter/http/ApiAddress.dart';
import 'package:wan_android_flutter/http/DioHelper.dart';
import 'package:wan_android_flutter/redux_state.dart';
import 'package:wan_android_flutter/repo/repositories.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();

  Store<WanAndroidState> _getStore() {
    return StoreProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: Builder(builder: (ct) {
             return GestureDetector(onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              }, child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    EditTextWithClear(userNameController, "用户名"),
                    ArticlePadding(),
                    EditTextWithClear(
                      passWordController,
                      "密码",
                      obscureText: true,
                    ),
                    ArticlePadding(),
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "登录",
                          style: TextStyle(fontSize: 30, letterSpacing: 15),
                        ),
                      ),
                      elevation: 1.0,
                      onPressed: () {
                        _login(userNameController, passWordController, ct);
                      },
                    ),
                  ],
                ),
              ),);

        }));
  }

  void _login(TextEditingController userNameController,
      TextEditingController passWordController, BuildContext context) {
    var userName = userNameController.text;
    var passWord = passWordController.text;
    if ('' == userName || '' == passWord) {
      Snack.show(context, "用户名/密码不能为空!");
      return;
    }
    WanAndroidRepository.instance.login(_getStore(), userName, passWord,context);
  }
}

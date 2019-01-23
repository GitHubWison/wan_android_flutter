import 'package:flutter/material.dart';
import 'package:wan_android_flutter/component/ArticlePadding.dart';
import 'package:wan_android_flutter/component/EditTextWithClearState.dart';
import 'package:wan_android_flutter/component/Snack.dart';
import 'package:wan_android_flutter/http/ApiAddress.dart';
import 'package:wan_android_flutter/http/DioHelper.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final passWordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body:Builder(builder: (ct){
        return Padding(
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
                  _login(userNameController, passWordController,ct);
                },
              ),
            ],
          ),
        );
      })
    );
  }

  void _login(TextEditingController userNameController,
      TextEditingController passWordController,BuildContext context) {
    var userName = userNameController.text;
    var passWord = passWordController.text;
    if ('' == userName || '' == passWord) {
      Snack.show(context, "用户名/密码不能为空!");
      return;
    }
    WanAndroidDio.instance.doPost(ApiAddress.login_api,data: {
      "username":userName,
      "password":passWord
    });
  }
}

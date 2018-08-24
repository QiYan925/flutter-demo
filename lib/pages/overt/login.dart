import 'package:flutter/material.dart';
import 'package:loan_archive/tools.dart';
import 'package:loan_archive/widgets/input_editview.dart';
import 'package:loan_archive/widgets/verify_codeview.dart';
import 'package:loan_archive/pages/maintabs.dart';
import 'dart:async';
import 'forget_password.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  MultipleStatusView statusView;
  TextEditingController _accountController =
      TextEditingController.fromValue(new TextEditingValue(text: ""));
  TextEditingController _passwordController =
      TextEditingController.fromValue(new TextEditingValue(text: ""));
  VerifyCodeController _codeController = new VerifyCodeController(0);
  MultipleStatusController _statusController =
      new MultipleStatusController(TipDialogType.NOTHING);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(AppStrings.login),
        ),
        body: statusView = new MultipleStatusView(
            new ListView(
              children: <Widget>[
                new Container(
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      new InputEditView(
                        name: "手机号码\u3000",
                        maxLength: 11,
                        keyboardType: TextInputType.phone,
                        autofocus: true,
                        hint: "请输入手机号码",
                        controller: _accountController,
                      ),
                      new Padding(
                          padding:
                              EdgeInsets.only(left: AppDimens.bothSideSpacing),
                          child: new Divider(
                            height: AppDimens.dividerHeight,
                            color: AppColors.dividerColor,
                          )),
                      new InputEditView(
                        name: "密\u3000\u3000码" + "\u3000",
                        maxLength: 20,
                        obscureText: true,
                        hint: "请输入登录密码",
                        controller: _passwordController,
                      )
                    ],
                  ),
                ),
                new Container(
                    margin: EdgeInsets.only(
                        top: AppDimens.bothSideSpacing * 2,
                        left: AppDimens.bothSideSpacing,
                        right: AppDimens.bothSideSpacing),
                    child: new RaisedButton(
                        child: new Text(
                          "登录",
                          style: new TextStyle(
                              color: Colors.white, fontSize: AppDimens.h3),
                        ),
                        padding: EdgeInsets.only(
                            top: AppDimens.bothTbSpacing,
                            bottom: AppDimens.bothTbSpacing),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          _login(_accountController.text,
                              _passwordController.text);
                        })),
                new Container(
                    margin: EdgeInsets.only(
                        top: AppDimens.bothSideSpacing,
                        left: AppDimens.bothSideSpacing,
                        right: AppDimens.bothSideSpacing),
                    child: new RaisedButton(
                        child: new Text(
                          "免费注册",
                          style: new TextStyle(
                              color: Colors.black, fontSize: AppDimens.h3),
                        ),
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.dividerColor,
                                width: AppDimens.dividerHeight)),
                        padding: EdgeInsets.only(
                            top: AppDimens.bothTbSpacing,
                            bottom: AppDimens.bothTbSpacing),
                        textColor: Colors.black,
                        color: Colors.white,
                        disabledColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new RegisterPage()));
                        })),
                new GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new ForgetPswPage()));
                  },
                  child: new Container(
                      padding: EdgeInsets.all(AppDimens.bothSideSpacing),
                      alignment: Alignment.centerRight,
                      child: new Text("忘记密码？",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: AppDimens.h4))),
                )
              ],
            ),
            _statusController));
  }

  ///执行登录逻辑
  void _login(String account, String password) {
    if (account.length != 11) {
      setStatus(TipDialogType.INFO, text: "请输入正确的手机号码");
    } else if (password.length == 0) {
      setStatus(TipDialogType.INFO, text: "请输入密码");
    } else {
      setStatus(TipDialogType.LOADING);
      new Future.delayed(new Duration(seconds: 1), () {
        setStatus(TipDialogType.NOTHING);
        if ("123456" != password) {
          setStatus(TipDialogType.FAIL, text: "密码不正确");
        } else {
          UserStore.saveUser(
              new User(account: account, name: "事已成昨", logined: true));
          setStatus(TipDialogType.SUCCESS, text: "登录成功", callback: () async {
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (context) => new MainTabsPage()));
          });
        }
      });
    }
  }

  ///改变控件状态
  void setStatus(TipDialogType status, {String text, VoidCallback callback}) {
    statusView.setStatus(status, text: text, callback: callback);
  }
}

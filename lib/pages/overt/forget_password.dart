import 'package:flutter/material.dart';
import 'package:loan_archive/tools.dart';
import 'package:loan_archive/widgets/input_editview.dart';
import 'package:loan_archive/widgets/verify_codeview.dart';

class ForgetPswPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ForgetPswPageState();
  }
}

class _ForgetPswPageState extends State<ForgetPswPage> {
  MultipleStatusView statusView;
  TextEditingController _accountController =
  TextEditingController.fromValue(new TextEditingValue(text: ""));
  TextEditingController _passwordController =
  TextEditingController.fromValue(new TextEditingValue(text: ""));
  VerifyCodeController _codeController = new VerifyCodeController(0);
  MultipleStatusController _statusController =
  new MultipleStatusController(TipDialogType.NOTHING);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(AppStrings.forget_psw),
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
                      new VerifyCodeView(
                        name: "验证码" + "\u3000" + " " + "\u3000",
                        maxLength: 20,
                        hint: "请输入验证码",
                        controller: _codeController,
                        onGetCode: () {
//                          new Future.delayed(new Duration(seconds: 3), () {
//                            _codeController.reset();
//                          });
                        },
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
                          "重置密码",
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
                          _register(_accountController.text,
                              _codeController.text, _passwordController.text);
                        }))
              ],
            ),
            _statusController));
  }

  ///执行登录逻辑
  void _register(String account, String code, String password) {
    if (account.length != 11) {
      setStatus(TipDialogType.INFO, text: "请输入正确的手机号码");
    } else if (code.length == 0) {
      setStatus(TipDialogType.INFO, text: "请输入验证码");
    } else if (password.length == 0) {
      setStatus(TipDialogType.INFO, text: "请输入密码");
    } else {
      setStatus(TipDialogType.LOADING);
      new Future.delayed(new Duration(seconds: 1), () {
        setStatus(TipDialogType.NOTHING);
        if ("123456" != code) {
          setStatus(TipDialogType.FAIL, text: "验证码不正确");
        } else {
          setStatus(TipDialogType.SUCCESS, text: "登录成功", callback: () async {
            UserStore.saveUser(
                new User(account: account, name: "事已成昨", logined: true));
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

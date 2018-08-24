import 'package:flutter/material.dart';
import 'package:loan_archive/tools.dart';
import 'dart:async';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MePageState();
  }
}

class _MePageState extends State<MePage> {
  String name;
  String account;

  @override
  void initState() {
    super.initState();
    UserStore.getUser().then((u) {
      setState(() {
        name = u.name;
        account = u.name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppStrings.me),
      ),
      body: new Center(
        child: new GestureDetector(
          child: new Text("欢迎" + name + "[" + account + "],点击退出"),
          onTap: () {
            UserStore.loginOut();
            Navigator.pushReplacementNamed(context, AppPage.LOGIN);
          },
        ),
      ),
    );
  }
}

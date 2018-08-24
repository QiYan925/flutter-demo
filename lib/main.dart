import 'package:flutter/material.dart';
import 'dart:async';
import 'package:loan_archive/tools.dart';
import 'package:loan_archive/pages/maintabs.dart';
import 'package:loan_archive/pages/overt/login.dart';
import 'package:loan_archive/utils/layout.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: AppColors.theme,
      ),
      home: new MyHomePage(),
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: const Color(0xFF363F68),
      body: new Image(
      alignment: Alignment.center,
      image: new AssetImage("res/drawable/icon_start.png"),
      width: Layout.percent(181.0),
      height: Layout.percent(51.0),
    ),
    );
  }

  @override
  void didChangeDependencies() {
    Layout.init(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    var _duration = new Duration(seconds: 2);
    new Future.delayed(_duration, () => _toPage());
  }

  void _toPage() {
    UserStore.getUser().then((u) {
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) {
        return u != null && u.logined ? new MainTabsPage() : new LoginPage();
      }));
    });
  }
}

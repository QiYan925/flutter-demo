import 'package:flutter/material.dart';
import 'package:loan_archive/tools.dart';
import 'package:loan_archive/pages/main/home.dart';
import 'package:loan_archive/pages/main/service.dart';
import 'package:loan_archive/pages/main/me.dart';
import 'package:loan_archive/pages/overt/login.dart';
import 'package:loan_archive/pages/service/message.dart';
import 'package:loan_archive/pages/service/search.dart';

var _routers = <String, WidgetBuilder>{
  AppPage.LOGIN: (BuildContext context) => new LoginPage(),
  AppPage.SEARCH: (BuildContext context) => new SearchPage(),
  AppPage.MESSAGE: (BuildContext context) => new MessagePage(),
};

class _Page {
  final IconData icon;
  final String name;

  _Page({this.icon, this.name});
}

class MainTabsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<MainTabsPage>
    with SingleTickerProviderStateMixin {
  List<_Page> _appBar;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _appBar = <_Page>[
      new _Page(icon: Icons.home, name: AppStrings.home),
      new _Page(icon: Icons.favorite, name: AppStrings.service),
      new _Page(icon: Icons.person, name: AppStrings.me),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        routes: _routers,
        home: new Scaffold(
          body: new IndexedStack(children: <Widget>[
            new HomePage(),
            new ServicePage(),
            new MePage()
          ], index: _index),
          bottomNavigationBar: new BottomNavigationBar(
            items: _appBar.map((_Page page) {
              return new BottomNavigationBarItem(
                  icon: new Icon(page.icon),
                  title: new Text(page.name),
                  backgroundColor: Colors.white);
            }).toList(),
            currentIndex: _index,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class AppPage {
  static const MAIN = '/main';
  static const LOGIN = '/overt/login';
  static const SEARCH = '/overt/search';
  static const MESSAGE = '/overt/message';
}

class AppStrings {
  static const home = "首页";
  static const service = "服务";
  static const me = "我的";
  static const search = "搜索";
  static const message = "消息";
  static const login = "登录";
  static const register = "注册";
  static const forget_psw = "忘记密码";
}

class AppDimens {
  static const h1 = 24.0;
  static const h2 = 20.0;
  static const h3 = 17.0;
  static const h4 = 14.0;
  static const h5 = 12.0;
  static const bothSideSpacing = 16.0;
  static const bothTbSpacing = 4.0;
  static const clipRect_2 = 2.0;
  static const clipRect_30 = 30.0;
  static const dividerHeight = 1.0;
}

class AppColors {
  static const theme = const MaterialColor(_colorPrimary, const <int, Color>{
    50: const Color(0xFFE3F2FD),
    100: const Color(0xFFBBDEFB),
    200: const Color(0xFF90CAF9),
    300: const Color(0xFF64B5F6),
    400: const Color(0xFF42A5F5),
    500: const Color(_colorPrimary),
    600: const Color(0xFF1E88E5),
    700: const Color(0xFF1976D2),
    800: const Color(0xFF1565C0),
    900: const Color(0xFF0D47A1),
  });

  static const _colorPrimary = 0XFF3399FF;

  static const title = const Color(0xFF333333);
  static const subTitle = const Color(0xFF666666);
  static const ignoreTitle = const Color(0xFF999999);
  static const dividerColor = const Color(0XFFDFDFDF);
  static const toastBgColor = const Color(0x3F000000);
}

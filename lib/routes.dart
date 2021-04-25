import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/app_wrapper.dart';
import 'package:tiptop_v2/UI/pages/language_select_page.dart';
import 'package:tiptop_v2/UI/pages/orders_page.dart';
import 'package:tiptop_v2/UI/pages/privacy_page.dart';
import 'package:tiptop_v2/UI/pages/profile/about_page.dart';
import 'package:tiptop_v2/UI/pages/profile/profile_page.dart';
import 'package:tiptop_v2/UI/pages/walkthrough_page.dart';

final routes = <String, WidgetBuilder>{
  AboutPage.routeName: (BuildContext context) => AboutPage(),
  PrivacyPage.routeName: (BuildContext context) => PrivacyPage(),
  LanguageSelectPage.routeName: (BuildContext context) => LanguageSelectPage(),
  WalkthroughPage.routeName: (BuildContext context) => WalkthroughPage(),
  AppWrapper.routeName: (BuildContext context) => AppWrapper(),
  OrdersPage.routeName: (BuildContext context) => OrdersPage(),
  ProfilePage.routeName: (BuildContext context) => ProfilePage()
};

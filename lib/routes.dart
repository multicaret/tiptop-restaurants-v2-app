import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/app_wrapper.dart';
import 'package:tiptop_v2/UI/pages/language_select_page.dart';
import 'package:tiptop_v2/UI/pages/order_details_page.dart';
import 'package:tiptop_v2/UI/pages/orders_page.dart';
import 'package:tiptop_v2/UI/pages/profile/contact_us_page.dart';
import 'package:tiptop_v2/UI/pages/profile/customer_service.dart';
import 'package:tiptop_v2/UI/pages/profile/edit_restaurant_page.dart';
import 'package:tiptop_v2/UI/pages/profile/privacy_page.dart';
import 'package:tiptop_v2/UI/pages/profile/about_page.dart';
import 'package:tiptop_v2/UI/pages/profile_page.dart';
import 'package:tiptop_v2/UI/pages/login_page.dart';

final routes = <String, WidgetBuilder>{
  AboutPage.routeName: (BuildContext context) => AboutPage(),
  PrivacyPage.routeName: (BuildContext context) => PrivacyPage(),
  LanguageSelectPage.routeName: (BuildContext context) => LanguageSelectPage(),
  WalkthroughPage.routeName: (BuildContext context) => WalkthroughPage(),
  AppWrapper.routeName: (BuildContext context) => AppWrapper(),
  OrdersPage.routeName: (BuildContext context) => OrdersPage(),
  ProfilePage.routeName: (BuildContext context) => ProfilePage(),
  EditRestaurantPage.routeName: (BuildContext context) => EditRestaurantPage(),
  ContactUsPage.routeName: (BuildContext context) => ContactUsPage(),
  CustomerService.routeName: (BuildContext context) => CustomerService(),
  OrderDetailsPage.routeName: (BuildContext context) => OrderDetailsPage(),
};

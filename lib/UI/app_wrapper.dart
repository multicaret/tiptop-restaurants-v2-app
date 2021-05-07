import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/pages/drivers_page.dart';
import 'package:tiptop_v2/UI/pages/restaurant_menu_page.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/orders_fab.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';

class AppWrapper extends StatefulWidget {
  static const routeName = '/app-wrapper';

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  final CupertinoTabController _cupertinoTabController = CupertinoTabController();
  int currentTabIndex = 0;

  List<GlobalKey<NavigatorState>> _tabNavKeys = List.generate(_getCupertinoTabsList().length, (i) => GlobalKey<NavigatorState>());

  GlobalKey<NavigatorState> currentNavigatorKey() {
    return _tabNavKeys[_cupertinoTabController.index];
  }

  void onTabItemTapped(int index) {
    if (_tabNavKeys[index].currentState != null && currentTabIndex == index) {
      _tabNavKeys[index].currentState.popUntil((r) => r.isFirst);
    }
    _cupertinoTabController.index = index;
    currentTabIndex = index;
  }

  List<BottomNavigationBarItem> _getCupertinoTabBarItems(bool isRTL) {
    List<Map<String, dynamic>> _cupertinoTabsList = _getCupertinoTabsList();
    double tabWidth = MediaQuery.of(context).size.width / _cupertinoTabsList.length;

    return List.generate(_cupertinoTabsList.length, (i) {
      int tabWithEndPaddingIndex = (_cupertinoTabsList.length / 2).ceil() - 1;
      int tabWithStartPaddingIndex = (_cupertinoTabsList.length / 2).ceil() + 1 - 1;

      return BottomNavigationBarItem(
        backgroundColor: AppColors.primary,
        icon: Padding(
          padding: i == tabWithEndPaddingIndex
              ? isRTL
                  ? EdgeInsets.only(left: tabWidth / 4)
                  : EdgeInsets.only(right: tabWidth / 4)
              : i == tabWithStartPaddingIndex
                  ? isRTL
                      ? EdgeInsets.only(right: tabWidth / 4)
                      : EdgeInsets.only(left: tabWidth / 4)
                  : EdgeInsets.all(0),
          child: Icon(
            _cupertinoTabsList[i]['icon'],
          ),
        ),
      );
    });
  }

  static List<Map<String, dynamic>> _getCupertinoTabsList() {
    return [
      {
        'title': 'Menu',
        'page': RestaurantMenuPage(),
        'icon': LineAwesomeIcons.utensils,
      },
      {
        'title': 'Drivers',
        'page': DriversPage(),
        'icon': LineAwesomeIcons.motorcycle,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Platform.isAndroid ? !await currentNavigatorKey().currentState.maybePop() : null;
      },
      child: Stack(
        children: [
          Consumer<AppProvider>(
            builder: (c, appProvider, _) => CupertinoTabScaffold(
              backgroundColor: AppColors.white,
              controller: _cupertinoTabController,
              tabBar: CupertinoTabBar(
                // onTap: (index) => onTabItemTapped(index, homeProvider),
                currentIndex: currentTabIndex,
                backgroundColor: AppColors.primary,
                activeColor: AppColors.secondary,
                inactiveColor: AppColors.white.withOpacity(0.5),
                items: _getCupertinoTabBarItems(appProvider.isRTL),
              ),
              tabBuilder: (BuildContext context, int index) {
                return CupertinoTabView(
                  navigatorKey: _tabNavKeys[index],
                  builder: (BuildContext context) {
                    return _getCupertinoTabsList()[index]['page'];
                  },
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (context) => AppScaffold(),
                    );
                  },
                );
              },
            ),
          ),
          OrdersFAB(),
        ],
      ),
    );
  }
}

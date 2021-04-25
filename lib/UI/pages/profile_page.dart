import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/pages/language_select_page.dart';
import 'package:tiptop_v2/UI/pages/profile/contact_us_page.dart';
import 'package:tiptop_v2/UI/pages/profile/customer_service.dart';
import 'package:tiptop_v2/UI/pages/profile/privacy_page.dart';
import 'package:tiptop_v2/UI/pages/profile/about_page.dart';
import 'package:tiptop_v2/UI/pages/profile/edit_restaurant_page.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/profile_setting_item.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/profile";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AppProvider appProvider;

  final List<Map<String, dynamic>> profileItems = [
    {
      'title': "Edit Restaurant Profile",
      'icon': FontAwesomeIcons.userEdit,
      'route': EditRestaurantPage.routeName,
    },
    {
      'title': "About App",
      'icon': FontAwesomeIcons.infoCircle,
      'route': AboutPage.routeName,
    },
    {
      'title': "Privacy Policy",
      'icon': FontAwesomeIcons.userLock,
      'route': PrivacyPage.routeName,
    },
    {
      'title': "Change Language",
      'icon': FontAwesomeIcons.globe,
      'route': LanguageSelectPage.routeName,
    },
    {
      'title': "Contact Us",
      'icon': FontAwesomeIcons.phoneAlt,
      'route': ContactUsPage.routeName,
    },
    {
      'title': "Customer Service",
      'icon': FontAwesomeIcons.headphones,
      'route': CustomerService.routeName,
    },
  ];

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);

    return AppScaffold(
      hasCurve: false,
      appBar: AppBar(
        title: Text(
          Translations.of(context).get('Profile'),
        ),
      ),
      body: Column(
        children: [
          ..._getProfileSettingItems(context, profileItems),
          const SizedBox(height: 30),
          ProfileSettingItem(
            title: 'Logout',
            icon: FontAwesomeIcons.doorOpen,
            hasTrailing: false,
          ),
          const SizedBox(height: 50),
          ProfileSettingItem(
            title: 'Version',
            icon: FontAwesomeIcons.mobileAlt,
            trailing: Text(
              '1.0.0',
              style: AppTextStyles.body50,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getProfileSettingItems(BuildContext context, List<Map<String, dynamic>> _items) {
    return List.generate(
      _items.length,
      (i) => ProfileSettingItem(
        icon: _items[i]['icon'],
        title: _items[i]['title'],
        route: _items[i]['route'],
      ),
    );
  }
}

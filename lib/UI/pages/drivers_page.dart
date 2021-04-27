import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tiptop_v2/UI/pages/profile_page.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/utils/styles/app_icons.dart';

class DriversPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasCurve: true,
      appBar: AppBar(
        title: Text(Translations.of(context).get('Drivers')),
        actions: [
          IconButton(
            icon: AppIcons.iconSPrimary(LineAwesomeIcons.user_circle),
            onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(ProfilePage.routeName),
          ),
        ],
      ),
      body: Center(child: Text("Coming Soon!")),
    );
  }
}

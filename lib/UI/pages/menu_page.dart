import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/i18n/translations.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasCurve: true,
      appBar: AppBar(
        title: Text(Translations.of(context).get('Menu')),
      ),
      body: Center(child: Text("Menu Page")),
    );
  }
}

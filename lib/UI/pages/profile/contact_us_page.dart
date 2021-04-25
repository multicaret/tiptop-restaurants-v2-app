import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/i18n/translations.dart';

class ContactUsPage extends StatefulWidget {
  static const routeName = '/contact-us';
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasCurve: true,
      appBar: AppBar(
        title: Text(Translations.of(context).get("Contact Us")),
      ),
    );
  }
}

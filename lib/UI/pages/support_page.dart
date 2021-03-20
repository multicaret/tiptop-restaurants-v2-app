import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/app_scaffold.dart';

class SupportPage extends StatelessWidget {
  static const routeName = '/support';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Text('Support Page'),
      ),
    );
  }
}

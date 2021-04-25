import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasCurve: false,
      body: Center(child: Text("Orders Page")),
    );
  }
}

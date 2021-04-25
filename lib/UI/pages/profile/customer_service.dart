import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/i18n/translations.dart';

class CustomerService extends StatefulWidget {
  static const routeName = '/customer-service';
  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasCurve: true,
      appBar: AppBar(
        title: Text(Translations.of(context).get("Customer Service")),
      ),
    );
  }
}

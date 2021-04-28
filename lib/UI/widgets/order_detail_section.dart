import 'package:flutter/material.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class OrderDetailSection extends StatelessWidget {
  final String title;
  final List<Widget> child;

  const OrderDetailSection({
    this.title,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Text(
            Translations.of(context).get(title),
            style: AppTextStyles.h3Primary,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: child,
        ),
        SizedBox(height: 15),
      ],
    );
  }
}

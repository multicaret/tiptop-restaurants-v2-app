import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/pages/order_details_page.dart';
import 'package:tiptop_v2/models/order.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class TableRowItem extends StatelessWidget {
  final String value;
  final Order order;
  final Function call;

  TableRowItem({
    this.call,
    this.value,
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    return TableRowInkWell(
      onTap: () async {
        var orderStatusChanged = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OrderDetailsPage(order: order);
              },
            ));
        if(orderStatusChanged)  call();
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: screenHorizontalPadding, right: screenHorizontalPadding, top: 10, bottom: 10),
          child: Text(
            value,
            style: AppTextStyles.bodyTable,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/pages/order_show_page.dart';
import 'package:tiptop_v2/models/order.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class TableRowItem extends StatelessWidget {
  final String orderStatus;
  final String value;
  final Order order;

  TableRowItem({
    this.orderStatus,
    this.value,
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    return TableRowInkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderShowPage(orderStatus: orderStatus, order: order),
          )),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 8, top: 10, bottom: 10),
          child: Text(
            value,
            style: AppTextStyles.bodyTable,
          ),
        ),
      ),
    );
  }
}

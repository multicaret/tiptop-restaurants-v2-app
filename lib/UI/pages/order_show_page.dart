import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/order_product_list_item.dart';
import 'package:tiptop_v2/models/models.dart';
import 'package:tiptop_v2/models/product.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class OrderShowPage extends StatefulWidget {
  static const routeName = "/show-order";

  final int orderStatus;

  OrderShowPage({this.orderStatus});

  @override
  _OrderShowPageState createState() => _OrderShowPageState();
}

class _OrderShowPageState extends State<OrderShowPage> {
  //change values to order details from API
  List<Map<String, dynamic>> orderDetails = [
    {'title': 'Order Id', 'value': '#123456'},
    {'title': 'Delivery Type', 'value': 'TipTop Delivery'},
    {'title': 'Payment Method', 'value': 'Cash'},
    {'title': 'Customer Name', 'value': 'TEST NAME TIPTOP'},
    {'title': 'Customer Address', 'value': 'Address'},
  ];

  AppProvider appProvider;

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    print(widget.orderStatus.toString());
    return AppScaffold(
      hasCurve: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "Delivery Date & Time",
                  style: AppTextStyles.subtitle50,
                ),
                SizedBox(height: 10),
                Text('2021-03-12  16:25', style: AppTextStyles.h2Secondary)
              ],
            ),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    "Order Information",
                    style: AppTextStyles.h2,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    orderDetails.length,
                    (i) => Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: appProvider.isRTL ? screenHorizontalPadding : 7,
                        left: appProvider.isRTL ? 7 : screenHorizontalPadding,
                      ),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border)), color: AppColors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(orderDetails[i]['title']),
                          Text(orderDetails[i]['value']),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    "Items",
                    style: AppTextStyles.h2,
                  ),
                ),
                OrderProductListItem(
                  quantity: "2",
                  product: Product(
                    title: "Salami",
                    unitText: "Item Price",
                    price: DoubleRawStringFormatted(formatted: "3500 IQD"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

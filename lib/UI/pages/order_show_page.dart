import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/widgets/UI/dialogs/text_field_dialog.dart';
import 'package:tiptop_v2/UI/widgets/order_detail_section.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/order_product_list_item.dart';
import 'package:tiptop_v2/UI/widgets/payment_summary.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/models/models.dart';
import 'package:tiptop_v2/models/product.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_buttons.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_icons.dart';
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
  List<Map<String, dynamic>> dummyOrderDetails = [
    {'title': 'Order Id', 'value': '#123456'},
    {'title': 'Delivery Type', 'value': 'TipTop Delivery'},
    {'title': 'Payment Method', 'value': 'Cash'},
    {'title': 'Customer Name', 'value': 'TEST NAME TIPTOP'},
    {'title': 'Customer Address', 'value': 'Address'},
  ];

  //change values to order products from API
  List<Product> dummyOrderProducts = [
    Product(
      title: "Salami",
      unitText: "Item Price",
      price: DoubleRawStringFormatted(formatted: "3500 IQD"),
    ),
    Product(
      title: "Magnum",
      unitText: "Item Price",
      price: DoubleRawStringFormatted(formatted: "1500 IQD"),
    ),
  ];

  //change values to order payment info from API
  List<PaymentSummaryTotal> dummyTotals = [
    PaymentSummaryTotal(
      title: "Item Total",
      value: "7000 IQD",
    ),
    PaymentSummaryTotal(
      title: "Discount Amount",
      value: "0 IQD",
    ),
    PaymentSummaryTotal(
      title: "Delivery Fee",
      value: "66 IQD",
    ),
    PaymentSummaryTotal(
      isGrandTotal: true,
      title: "Total",
      value: "7066 IQD",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    print(widget.orderStatus.toString());
    return AppScaffold(
      hasCurve: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SizedBox(height: 15),
                Text(Translations.of(context).get("Delivery Date & Time"), style: AppTextStyles.subtitle50),
                SizedBox(height: 10),
                Text('2021-03-12  16:25', style: AppTextStyles.h2Secondary)
              ],
            ),
            SizedBox(height: 15),
            OrderDetailSection(
              title: "Order Information",
              child: List.generate(
                dummyOrderDetails.length,
                (i) => Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    right: appProvider.isRTL ? screenHorizontalPadding : 7,
                    left: appProvider.isRTL ? 7 : screenHorizontalPadding,
                  ),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                    color: AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Translations.of(context).get(dummyOrderDetails[i]['title'])),
                      Text(dummyOrderDetails[i]['value']),
                    ],
                  ),
                ),
              ),
            ),
            OrderDetailSection(
              title: "Items",
              child: [
                Flex(
                  direction: Axis.vertical,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dummyOrderProducts.length,
                        itemBuilder: (context, i) {
                          return OrderProductListItem(
                            productOptions: ['Option 1', 'Option 2'],
                            quantity: "2",
                            product: dummyOrderProducts[i],
                          );
                        }),
                  ],
                ),
              ],
            ),
            OrderDetailSection(
              title: "Payment Information",
              child: [PaymentSummary(totals: dummyTotals)],
            ),
            if (widget.orderStatus == 2)
              Padding(
                padding: const EdgeInsets.only(right: 17, left: 17, bottom: 17),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButtons.dynamic(
                        bgColor: AppColors.success,
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => TextFieldDialog(
                            textFieldLabel: 'Estimated time to prepare',
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppIcons.iconWhite(FontAwesomeIcons.check),
                            SizedBox(width: 10),
                            Text(Translations.of(context).get("Approve")),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppButtons.dynamic(
                        bgColor: AppColors.danger,
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppIcons.iconWhite(FontAwesomeIcons.times),
                            SizedBox(width: 10),
                            Text(Translations.of(context).get("Reject")),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.orderStatus == 10)
              Padding(
                padding: const EdgeInsets.only(right: 17, left: 17, bottom: 17),
                child: AppButtons.dynamic(
                  bgColor: AppColors.success,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcons.iconWhite(FontAwesomeIcons.check),
                      SizedBox(width: 10),
                      Text(Translations.of(context).get("Ready")),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

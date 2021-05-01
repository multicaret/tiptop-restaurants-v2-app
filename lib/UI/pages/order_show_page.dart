import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiptop_v2/UI/widgets/UI/dialogs/text_field_dialog.dart';
import 'package:tiptop_v2/UI/widgets/UI/section_title.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/order_product_list_item.dart';
import 'package:tiptop_v2/UI/widgets/payment_summary.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/models/models.dart';
import 'package:tiptop_v2/models/order.dart';
import 'package:tiptop_v2/models/product.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_buttons.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_icons.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class OrderShowPage extends StatefulWidget {
  static const routeName = "/show-order";

  final int orderStatus;
  final Order order;
  final Product product;

  OrderShowPage({
    @required this.orderStatus,
    this.order,
    this.product,
  });

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
      // value : widget.product.price,
      value: "7000 IQD",
    ),
    PaymentSummaryTotal(
      title: "Discount Amount",
      // value : widget.product.discountedPrice,
      value: "0 IQD",
    ),
    PaymentSummaryTotal(
      title: "Delivery Fee",
      // value: widget.order.deliveryFee,
      value: "66 IQD",
    ),
    PaymentSummaryTotal(
      isGrandTotal: true,
      title: "Total",
      // value: widget.order.grandTotal,
      value: "7066 IQD",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    print(widget.orderStatus.toString());
    return AppScaffold(
      hasCurve: false,
      appBar: AppBar(
        title: Text(Translations.of(context).get('Order Details')),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                Text(Translations.of(context).get("Delivery Date & Time"), style: AppTextStyles.subtitle50),
                const SizedBox(height: 10),
                Text('2021-03-12  16:25', style: AppTextStyles.h2)
                // Text(widget.order.completedAt.toString(), style: AppTextStyles.h2)
              ],
            ),
            SectionTitle("Order Information"),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                dummyOrderDetails.length,
                (i) => Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: screenHorizontalPadding, vertical: 15),
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
            SectionTitle("Items"),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
            SectionTitle("Payment Information"),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [PaymentSummary(totals: dummyTotals)],
            ),
            SizedBox(height: 15),
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

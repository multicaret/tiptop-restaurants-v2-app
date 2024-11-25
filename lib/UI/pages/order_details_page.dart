import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_loader.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/UI/dialogs/text_field_dialog.dart';
import 'package:tiptop_v2/UI/widgets/UI/fixed_bottom_action.dart';
import 'package:tiptop_v2/UI/widgets/UI/section_title.dart';
import 'package:tiptop_v2/UI/widgets/order_product_list_item.dart';
import 'package:tiptop_v2/UI/widgets/payment_summary.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/models/enums.dart';
import 'package:tiptop_v2/models/models.dart';
import 'package:tiptop_v2/models/order.dart';
import 'package:tiptop_v2/models/product.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/providers/orders_provider.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_buttons.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_icons.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class OrderDetailsPage extends StatefulWidget {
  static const routeName = "/show-order";

  final Order order;
  final Product product;

  OrderDetailsPage({
    this.order,
    this.product,
  });

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  List<PaymentSummaryTotal> orderTotals = [];
  List<Map<String, dynamic>> orderDetails = [];
  OrdersProvider ordersProvider;
  AppProvider appProvider;
  bool _isInit = true;
  bool _isLoading = false;
  List<Map<String, dynamic>> _orderStatusList = [
    {'title': 'New', 'value': OrderStatus.NEW},
    {'title': 'Preparing', 'value': OrderStatus.PREPARING},
    {'title': 'Ready', 'value': OrderStatus.READY},
    {'title': 'Delivered', 'value': OrderStatus.DELIVERED},
    {'title': 'Cancelled', 'value': OrderStatus.CANCELLED},
  ];


  @override
  void didChangeDependencies() {
    if (_isInit) {
      ordersProvider = Provider.of<OrdersProvider>(context);
      appProvider = Provider.of<AppProvider>(context);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void setOrderDetails() {
    orderDetails = [
      {'title': 'Order Id', 'value': widget.order.referenceCode.toString()},
      {'title': 'Delivery Type', 'value': widget.order.deliveryType},
      {'title': 'Payment Method', 'value': widget.order.paymentMethod.title},
      {'title': 'Customer Name', 'value': widget.order.user.name},
      {'title': 'Customer Address', 'value': widget.order.address != null ? widget.order.address.address1 : "Address Not found"},
    ];

    orderTotals = [
      PaymentSummaryTotal(
        title: "Item Total",
        value: widget.order.cart == null ? "0" : widget.order.cart.total.formatted,
      ),
      PaymentSummaryTotal(
        title: "Discount Amount",
        value: widget.order.couponDiscountAmount.formatted,
      ),
      PaymentSummaryTotal(
        title: "Delivery Fee",
        value: widget.order.deliveryFee.raw == 0 ? Translations.of(context).get("Free") : widget.order.deliveryFee.formatted,
      ),
      PaymentSummaryTotal(
        isGrandTotal: true,
        title: "Total",
        value: widget.order.grandTotal.formatted,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(widget.order.status);
    setOrderDetails();
    return AppScaffold(
      hasCurve: false,
      appBar: AppBar(
        title: Text(Translations.of(context).get('Order Details')),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child:  _isLoading
                  ? AppLoader() : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(Translations.of(context).get("Delivery Date & Time"), style: AppTextStyles.subtitle50),
                      const SizedBox(height: 10),
                      Text(widget.order.completedAt.formatted, style: AppTextStyles.h2)
                    ],
                  ),
                  SectionTitle("Order Information"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      orderDetails.length,
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
                            Text(Translations.of(context).get(orderDetails[i]['title'])),
                            const SizedBox(width: 12),
                            Expanded(child: Text(orderDetails[i]['value'], textAlign: TextAlign.end)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SectionTitle("Items"),
                  widget.order.cart == null
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: screenHorizontalPadding, vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border(
                              bottom: BorderSide(width: 1, color: AppColors.border),
                            ),
                          ),
                          child: Text("Cart is empty!!"),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flex(
                              direction: Axis.vertical,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.order.cart.cartProducts.length,
                                  itemBuilder: (context, i) {
                                    var cartProduct = widget.order.cart.cartProducts[i];
                                    return OrderProductListItem(
                                      productOptions: cartProduct.product.options,
                                      quantity: cartProduct.quantity.toString(),
                                      product: cartProduct.product,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                  SectionTitle("Payment Information"),
                  PaymentSummary(totals: orderTotals),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (widget.order.status == OrderStatus.NEW)
            FixedBottomAction(
              child: Row(
                children: [
                  Expanded(
                    child: AppButtons.dynamic(
                      bgColor: AppColors.success,
                      onPressed: () async{
                        var estimatedTime = await showDialog(
                          context: context,
                          builder: (context) => TextFieldDialog(
                            textFieldLabel: 'Estimated time to prepare',
                          ),
                        );
                        if(estimatedTime != false) {
                          setState(() {_isLoading = true;});
                          await ordersProvider.changeOrderStatus(
                              appProvider,
                              appProvider.restaurantId,
                              widget.order.id,
                              _orderStatusList[1]["value"]
                          );
                          Navigator.of(context).pop(true);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppIcons.iconWhite(FontAwesomeIcons.check),
                          const SizedBox(width: 10),
                          Text(Translations.of(context).get("Approve")),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButtons.dynamic(
                      bgColor: AppColors.danger,
                      onPressed: () async {
                        setState(() {_isLoading = true;});
                        await ordersProvider.changeOrderStatus(
                            appProvider,
                            appProvider.restaurantId,
                            widget.order.id,
                            _orderStatusList[4]["value"]
                        );
                        Navigator.of(context).pop(true);
                         },
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
          if (widget.order.status == OrderStatus.PREPARING)
            FixedBottomAction(
              child: AppButtons.dynamic(
                bgColor: AppColors.success,
                onPressed: () async{
                  setState(() {_isLoading = true;});
                  await ordersProvider.changeOrderStatus(
                      appProvider,
                      appProvider.restaurantId,
                      widget.order.id,
                      _orderStatusList[2]["value"]
                  );
                  Navigator.of(context).pop(true);
                },
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
    );
  }
}

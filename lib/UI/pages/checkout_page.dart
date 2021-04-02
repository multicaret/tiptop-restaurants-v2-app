import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/app_wrapper.dart';
import 'package:tiptop_v2/UI/widgets/UI/dialogs/confirm_alert_dialog.dart';
import 'package:tiptop_v2/UI/widgets/address/address_select_button.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_loader.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/UI/dialogs/order_confirmed_dialog.dart';
import 'package:tiptop_v2/UI/widgets/UI/input/app_text_field.dart';
import 'package:tiptop_v2/UI/widgets/UI/input/radio_select_items.dart';
import 'package:tiptop_v2/UI/widgets/order_button.dart';
import 'package:tiptop_v2/UI/widgets/payment_summary.dart';
import 'package:tiptop_v2/UI/widgets/UI/section_title.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/models/order.dart';
import 'package:tiptop_v2/providers/addresses_provider.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/providers/cart_provider.dart';
import 'package:tiptop_v2/providers/home_provider.dart';
import 'package:tiptop_v2/providers/orders_provider.dart';
import 'package:tiptop_v2/utils/helper.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_icon.dart';

class CheckoutPage extends StatefulWidget {
  static const routeName = '/checkout-page';

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _isInit = true;
  bool _isLoading = false;
  bool _isLoadingOrderSubmit = false;

  CartProvider cartProvider;
  OrdersProvider ordersProvider;
  AppProvider appProvider;
  HomeProvider homeProvider;
  AddressesProvider addressesProvider;

  CheckoutData checkoutData;
  List<Map<String, String>> totals = [];
  Order submittedOrder;

  String notes;
  int selectedPaymentMethodId;

  String couponValue;
  TextEditingController controller = TextEditingController();
  bool isCouponSubmitted = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _createOrderAndGetCheckoutData() async {
    setState(() => _isLoading = true);
    await ordersProvider.createOrderAndGetCheckoutData(appProvider, homeProvider);
    checkoutData = ordersProvider.checkoutData;
    totals = [
      {
        "title": "Total",
        "value": checkoutData.total.formatted,
      },
      {
        "title": "Delivery Fee",
        "value": checkoutData.deliveryFee.formatted,
      },
      {
        "title": "Grand Total",
        "value": checkoutData.grandTotal.formatted,
      },
    ];
    selectedPaymentMethodId = checkoutData.paymentMethods[0].id;
    setState(() => _isLoading = false);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      cartProvider = Provider.of<CartProvider>(context);
      appProvider = Provider.of<AppProvider>(context);
      homeProvider = Provider.of<HomeProvider>(context);
      ordersProvider = Provider.of<OrdersProvider>(context);
      addressesProvider = Provider.of<AddressesProvider>(context);
      _createOrderAndGetCheckoutData();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasOverlayLoader: _isLoadingOrderSubmit,
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: _isLoading
          ? AppLoader()
          : Form(
            key: _formKey,
            child: Column(
              children: [
                AddressSelectButton(isDisabled: true),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(17),
                          color: AppColors.white,
                          child: AppTextField(
                            labelText: 'Notes',
                            maxLines: 3,
                            hintText: Translations.of(context).get('You can write your order notes here'),
                            fit: true,
                            onSaved: (value) {
                              notes = value;
                            },
                          ),
                        ),
                        SectionTitle('Payment Methods'),
                        RadioSelectItems(
                          items: checkoutData.paymentMethods
                              .map((method) => {'id': method.id, 'title': method.title, 'logo': method.logo})
                              .toList(),
                          selectedId: selectedPaymentMethodId,
                          action: (value) => setState(() => selectedPaymentMethodId = value),
                          isRTL: appProvider.isRTL,
                        ),
                        SectionTitle('Promotions'),
                        Material(
                          color: AppColors.white,
                          child: InkWell(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                top: 17,
                                bottom: 17,
                                right: appProvider.isRTL ? 17 : 12,
                                left: appProvider.isRTL ? 12 : 17,
                              ),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: AppColors.border)),
                              ),
                              child: !isCouponSubmitted
                                  ? InkWell(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 36,
                                            height: 30,
                                            child: AppIcon.iconXsSecondary(FontAwesomeIcons.plus),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 5)],
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(Translations.of(context).get('Add Coupon')),
                                        ],
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(couponValue),
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => ConfirmAlertDialog(
                                                title: 'Are you sure you want to delete the coupon?',
                                              ),
                                            ).then((response) => {
                                                  if (response != null && response)
                                                    setState(() {
                                                      isCouponSubmitted = false;
                                                    }),
                                                });
                                          },
                                          child: Container(
                                            width: 36,
                                            height: 30,
                                            child: AppIcon.iconXsSecondary(FontAwesomeIcons.trash),
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 5)],
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                            onTap: !isCouponSubmitted
                                ? () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ConfirmAlertDialog(
                                        hasTextField: true,
                                        textFieldHint: 'Enter Promo Code',
                                        controller: controller,
                                      ),
                                    ).then((response) => {
                                          if (response != null && response)
                                            setState(() {
                                              couponValue = controller.text.toString();
                                              isCouponSubmitted = true;
                                              controller.clear();
                                            }),
                                        });
                                  }
                                : null,
                          ),
                        ),
                        SectionTitle('Payment Summary'),
                        PaymentSummary(
                          totals: totals,
                          isRTL: appProvider.isRTL,
                        ),
                      ],
                    ),
                  ),
                ),
                OrderButton(
                  cartProvider: cartProvider,
                  isRTL: appProvider.isRTL,
                  submitAction: _submitOrder,
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _submitOrder() async {
    _formKey.currentState.save();
    try {
      setState(() => _isLoadingOrderSubmit = true);
      await ordersProvider.submitOrder(
        appProvider,
        homeProvider,
        cartProvider,
        addressesProvider,
        paymentMethodId: selectedPaymentMethodId,
        notes: notes,
      );
      submittedOrder = ordersProvider.submittedOrder;
      setState(() => _isLoadingOrderSubmit = false);
      showDialog(
        context: context,
        builder: (context) => OrderConfirmedDialog(
          isLargeOrder: submittedOrder.cart.productsCount >= 10,
        ),
      ).then((_) {
        Navigator.of(context, rootNavigator: true).pushReplacementNamed(AppWrapper.routeName);
      });
    } catch (e) {
      setState(() => _isLoadingOrderSubmit = false);
      showToast(msg: 'An error occurred while submitting your order!');
      throw e;
    }
  }
}

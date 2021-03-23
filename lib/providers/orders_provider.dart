import 'package:flutter/material.dart';
import 'package:tiptop_v2/models/order.dart';
import 'package:tiptop_v2/utils/http_exception.dart';

import 'app_provider.dart';
import 'cart_provider.dart';
import 'home_provider.dart';

class OrdersProvider with ChangeNotifier {
  SubmitOrderResponse submitOrderResponse;
  Order submittedOrder;
  PreviousOrdersResponseData previousOrdersResponseData;
  List<Order> previousOrders = [];

  CreateCheckoutResponse createCheckoutResponse;
  CheckoutData checkoutData;

  Future<void> createOrderAndGetCheckoutData(AppProvider appProvider, HomeProvider homeProvider) async {
    final endpoint = 'orders/create';
    Map<String, String> body = {
      'chain_id': '${homeProvider.chainId}',
      'branch_id': '${homeProvider.branchId}',
    };
    final responseData = await appProvider.get(
      endpoint: endpoint,
      body: body,
      withToken: true,
    );

    if (responseData == null) {
      return;
    }

    createCheckoutResponse = CreateCheckoutResponse.fromJson(responseData);

    if (createCheckoutResponse.checkoutData == null || createCheckoutResponse.status != 200) {
      throw HttpException(title: 'Error', message: createCheckoutResponse.message);
    }

    checkoutData = createCheckoutResponse.checkoutData;
    notifyListeners();
  }

  Future<void> submitOrder(
    AppProvider appProvider,
    HomeProvider homeProvider,
    CartProvider cartProvider, {
    @required int paymentMethodId,
    @required String notes,
  }) async {
    if (cartProvider.noCart) {
      print('No current cart!');
      return false;
    }

    Map<String, dynamic> body = {
      'branch_id': homeProvider.branchId,
      'chain_id': homeProvider.chainId,
      'cart_id': cartProvider.cart.id,
      'payment_method_id': paymentMethodId,
      'address_id': 1,
      'notes': notes,
    };

    print('Order submit request body:');
    print(body);

    final endpoint = 'orders';
    final responseData = await appProvider.post(
      endpoint: endpoint,
      body: body,
      withToken: true,
    );

    submitOrderResponse = SubmitOrderResponse.fromJson(responseData);
    if (submitOrderResponse.submittedOrder == null || submitOrderResponse.status != 200) {
      throw HttpException(title: 'Error', message: submitOrderResponse.message);
    }

    submittedOrder = submitOrderResponse.submittedOrder;
    notifyListeners();
  }

  Future<dynamic> fetchAndSetPreviousOrders(AppProvider appProvider) async {
    final endpoint = 'orders';
    final responseData = await appProvider.get(
      endpoint: endpoint,
      withToken: true,
    );
    // print(responseData);
    previousOrdersResponseData = PreviousOrdersResponseData.fromJson(responseData);

    if (responseData == 401) {
      return 401;
    }

    if (previousOrdersResponseData.previousOrders == null || previousOrdersResponseData.status != 200) {
      throw HttpException(title: 'Error', message: previousOrdersResponseData.message ?? 'Unknown');
    }

    previousOrders = previousOrdersResponseData.previousOrders;
    notifyListeners();
  }
}

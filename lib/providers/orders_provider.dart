import 'package:flutter/cupertino.dart';
import 'package:tiptop_v2/models/order.dart';

import 'app_provider.dart';

class OrdersProvider with ChangeNotifier {
  OrderData orderData;

  List<Order> orders = [];
  Map<String, int> counts;

  Future<dynamic> fetchAndSetOrders(AppProvider appProvider, int restaurantID, int orderStatus) async {
    final endpoint = 'restaurants/$restaurantID/orders';
    final body = {"status": orderStatus.toString()};
    final responseData = await appProvider.get(endpoint: endpoint, body: body, withToken: true);
    orderData = OrderData.fromJson(responseData["data"]);
    orders = orderData.orders;
    counts = orderData.counts;
    notifyListeners();
  }
}

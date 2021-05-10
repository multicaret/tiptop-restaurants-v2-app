import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/orders_status_tabs.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_loader.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/table_row_item.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/models/enums.dart';
import 'package:tiptop_v2/models/order.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/providers/orders_provider.dart';
import 'package:tiptop_v2/providers/restaurants_provider.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Map<String, dynamic>> _orderStatusList = [
    {'title': 'New', 'value': OrderStatus.NEW},
    {'title': 'Preparing', 'value': OrderStatus.PREPARING},
    {'title': 'Ready', 'value': OrderStatus.READY},
    {'title': 'Delivered', 'value': OrderStatus.DELIVERED},
    {'title': 'Cancelled', 'value': OrderStatus.CANCELLED},
  ];

  final List<String> _tableColumnTitles = ['Order', 'Date', 'Customer', 'Type'];

  TabController tabController;

  bool _isInit = true;
  bool _isLoadingOrders = false;
  bool _isLoadingOrdersInit = true;

  OrdersProvider ordersProvider;
  AppProvider appProvider;
  RestaurantsProvider restaurantsProvider;

  OrderStatus ordersStatus;
  int restaurantId;
  int currentTabIndex = 0;

  List<Order> orders = [];
  Map<String, int> counts;

  Future<void> _fetchAndSetOrders(OrderStatus ordersStatus) async {
    setState(() => _isLoadingOrders = true);
    await ordersProvider.fetchAndSetOrders(appProvider, appProvider.restaurantId, ordersStatus);
    restaurantId = restaurantsProvider.restaurant.id;
    orders = ordersProvider.orders;
    counts = ordersProvider.counts;
    setState(() {
      _isLoadingOrders = false;
      _isLoadingOrdersInit = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      ordersProvider = Provider.of<OrdersProvider>(context);
      appProvider = Provider.of<AppProvider>(context);
      restaurantsProvider = Provider.of<RestaurantsProvider>(context);
      _fetchAndSetOrders(_orderStatusList[0]['value']);
      ordersStatus = _orderStatusList[0]["value"];
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: currentTabIndex,
      length: _orderStatusList.length,
      child: AppScaffold(
        hasCurve: false,
        appBar: AppBar(
          title: Text(Translations.of(context).get('Orders')),
        ),
        body: _isLoadingOrdersInit
            ? AppLoader()
            : Column(
                children: [
                  OrdersStatusTabs(
                    onTap: (index) {
                      ordersStatus = _orderStatusList[index]["value"];
                      _fetchAndSetOrders(ordersStatus);
                    },
                    tabs: List.generate(_orderStatusList.length, (i) {
                      return Tab(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  color: i == 0 ? AppColors.danger : AppColors.secondary,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Text(
                                counts[restaurantOrderStatusValues.reverse[_orderStatusList[i]["value"]]].toString(),
                                style: AppTextStyles.subtitleXs,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(Translations.of(context).get(_orderStatusList[i]["title"])),
                          ],
                        ),
                      );
                    }),
                    tabController: tabController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        _tableColumnTitles.length,
                        (i) => Text(
                          Translations.of(context).get(_tableColumnTitles[i]),
                          style: AppTextStyles.bodyBold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _isLoadingOrders
                        ? AppLoader()
                        : TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: tabController,
                            children: List.generate(_orderStatusList.length, (i) {
                              return orders.length == 0
                                  ? Center(
                                      child: Text(
                                          Translations.of(context).get("No Orders Currently")
                                      ),
                                    )
                                  : SingleChildScrollView(
                                      child: Table(
                                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                          columnWidths: const <int, TableColumnWidth>{
                                            0: FixedColumnWidth(10),
                                            1: FixedColumnWidth(40),
                                            2: FixedColumnWidth(30),
                                            3: FixedColumnWidth(5),
                                          },
                                          children: List.generate(orders.length, (j) {
                                            var order = orders[j];
                                            return TableRow(
                                              decoration: BoxDecoration(color: j.isEven ? AppColors.shadow : AppColors.bg),
                                              children: [
                                                TableRowItem(
                                                  call: () => _fetchAndSetOrders(ordersStatus),
                                                  value: order.referenceCode.toString(),
                                                  order: order,
                                                ),
                                                TableRowItem(
                                                  call: () => _fetchAndSetOrders(ordersStatus),
                                                  value: order.completedAt.formatted,
                                                  order: order,
                                                ),
                                                TableRowItem(
                                                  call: () => _fetchAndSetOrders(ordersStatus),
                                                  value: order.user.name,
                                                  order: order,
                                                ),
                                                TableRowItem(
                                                  call: () => _fetchAndSetOrders(ordersStatus),
                                                  value: order.deliveryType,
                                                  order: order,
                                                ),
                                              ],
                                            );
                                          })
                                      ),
                                    );
                            }),
                          ),
                  )
                ],
              ),
      ),
    );
  }
}

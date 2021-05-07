import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/orders_status_tabs.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_loader.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/table_row_item.dart';
import 'package:tiptop_v2/i18n/translations.dart';
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
    {'title': 'New', 'value': 2},
    {'title': 'Preparing', 'value': 10},
    {'title': 'Ready', 'value': 12},
    {'title': 'Delivered', 'value': 20},
    {'title': 'Cancelled', 'value': 0},
  ];

  final List<String> _tableColumnTitles = ['Order', 'Date', 'Customer', 'Type'];

  TabController tabController;

  bool _isInit = true;
  bool _isLoadingOrders = false;
  bool _isLoadingOrdersInit = true;

  OrdersProvider ordersProvider;
  AppProvider appProvider;
  RestaurantsProvider restaurantsProvider;

  int ordersStatus;
  int restaurantId;
  int currentTabIndex = 0;

  List<Order> orders = [];
  Map<String, int> counts;

  Future<void> _fetchAndSetOrders(int ordersStatus) async {
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
      getOrderStatus(0);
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
                      getOrderStatus(index);
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
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Text(
                                counts[_orderStatusList[i]["value"]].toString(),
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
                                      child: Text(Translations.of(context).get("No Orders Currently")),
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
                                                  value: order.id.toString(),
                                                  order: order,
                                                ),
                                                TableRowItem(
                                                  value: order.completedAt.formatted,
                                                  order: order,
                                                ),
                                                TableRowItem(
                                                  value: order.user.name,
                                                  order: order,
                                                ),
                                                TableRowItem(
                                                  value: order.deliveryType,
                                                  order: order,
                                                ),
                                              ],
                                            );
                                          })),
                                    );
                            }),
                          ),
                  )
                ],
              ),
      ),
    );
  }

  void getOrderStatus(int tabIndex) {
    switch (tabIndex) {
      case 0:
        ordersStatus = _orderStatusList[0]["value"];
        break;
      case 1:
        ordersStatus = _orderStatusList[1]["value"];
        break;
      case 2:
        ordersStatus = _orderStatusList[2]["value"];
        break;
      case 3:
        ordersStatus = _orderStatusList[3]["value"];
        break;
      case 4:
        ordersStatus = _orderStatusList[4]["value"];
        break;
      default:
        ordersStatus = _orderStatusList[0]["value"];
    }
  }
}

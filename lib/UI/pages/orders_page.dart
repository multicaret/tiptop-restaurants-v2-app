import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/orders_status_tabs.dart';
import 'package:tiptop_v2/UI/pages/order_show_page.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_loader.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/circle_icon.dart';
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
    {'title': 'Canceled', 'value': 0},
  ];

  final List<String> _tableColumnTitles = ['Order', 'Date', 'Customer', 'Type'];

  final List<String> _dummyRowData = ['1234567', '2021-03-12 16:25', 'TEST NAME TIPTOP', 'TipTop Delivery'];

  TabController tabController;

  bool _isInit = true;
  bool _isLoadingOrders;

  OrdersProvider ordersProvider;
  AppProvider appProvider;
  RestaurantsProvider restaurantsProvider;
  int restaurantId;
  List<Order> orders = [];
  int currentTabIndex = 0;
  int ordersStatus;

  Future<void> _fetchAndSetOrders(int ordersStatus) async {
    setState(() => _isLoadingOrders = true);
    await ordersProvider.fetchAndSetOrders(appProvider, appProvider.restaurantId, ordersStatus);
    restaurantId = restaurantsProvider.restaurant.id;
    orders = ordersProvider.orders;
    setState(() => _isLoadingOrders = false);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      ordersProvider = Provider.of<OrdersProvider>(context);
      appProvider = Provider.of<AppProvider>(context);
      restaurantsProvider = Provider.of<RestaurantsProvider>(context);
      _fetchAndSetOrders(_orderStatusList[0]["value"]);
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
        body: _isLoadingOrders
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
                            if (i < 3)
                              CircleIcon(
                                iconText: orders.length != 0 ? orders.length.toString() : "0",
                                bgColor: i == 0 ? AppColors.danger : AppColors.secondary,
                                iconTextStyle: AppTextStyles.subtitleXs,
                              ),
                            SizedBox(width: 5),
                            Text(
                              Translations.of(context).get(_orderStatusList[i]["title"]),
                            ),
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
                        (i) => Text(Translations.of(context).get(_tableColumnTitles[i]), style: AppTextStyles.bodyBold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: orders.length == 0
                        ? Center(child: Text("No Orders Found!"))
                        : TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: tabController,
                            children: List.generate(_orderStatusList.length, (i) {
                              return SingleChildScrollView(
                                child: Table(defaultVerticalAlignment: TableCellVerticalAlignment.middle, columnWidths: const <int, TableColumnWidth>{
                                  0: FixedColumnWidth(25),
                                  1: FixedColumnWidth(30),
                                  2: FixedColumnWidth(30),
                                  3: FixedColumnWidth(5),
                                }, children: [
                                  TableRow(
                                    children: List.generate(
                                      orders.length,
                                      (j) => TableRowInkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => OrderShowPage(orderStatus: _orderStatusList[i]["value"]),
                                            )),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10, right: 8, top: 10, bottom: 10),
                                            child: Text(
                                              _orderStatusList[i]["title"],
                                              style: AppTextStyles.bodyTable,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
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
        ordersStatus = 2;
        break;
      case 1:
        ordersStatus = 10;
        break;
      case 2:
        ordersStatus = 12;
        break;
      case 3:
        ordersStatus = 20;
        break;
      case 4:
        ordersStatus = 0;
        break;
      default:
        ordersStatus = 2;
    }
  }
}

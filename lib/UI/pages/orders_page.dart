import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/orders_status_tabs.dart';
import 'package:tiptop_v2/UI/widgets/UI/app_scaffold.dart';
import 'package:tiptop_v2/UI/widgets/circle_icon.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Map<String, dynamic>> orderStatus = [
    {'title': 'New', 'value': 2},
    {'title': 'Preparing', 'value': 10},
    {'title': 'Ready', 'value': 12},
    {'title': 'Delivered', 'value': 20},
    {'title': 'Canceled', 'value': 0},
  ];

  final List<String> _tableColumnTitles = ['Order', 'Date', 'Customer', 'Type'];

  final List<String> _dummyRowData = ['1234567', '2021-03-12 16:25', 'TEST NAME TIPTOP', 'TipTop Delivery'];

  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: orderStatus.length,
      child: AppScaffold(
        hasCurve: false,
        appBar: AppBar(
          title: Text(Translations.of(context).get('Orders')),
        ),
        body: Column(
          children: [
            OrdersStatusTabs(
              tabs: List.generate(orderStatus.length, (i) {
                return Tab(
                  child: Row(
                    children: [
                      if (i < 3)
                        CircleIcon(
                          //change to number of orders from API
                          iconText: "0",
                          bgColor: i == 0 ? AppColors.danger : AppColors.secondary,
                          iconTextStyle: AppTextStyles.subtitleXs,
                        ),
                      SizedBox(width: 5),
                      Text(
                        Translations.of(context).get(orderStatus[i]["title"]),
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
              child: TabBarView(
                controller: tabController,
                children: List.generate(orderStatus.length, (i) {
                  return SingleChildScrollView(
                    child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(25),
                          1: FixedColumnWidth(30),
                          2: FixedColumnWidth(30),
                          3: FixedColumnWidth(5),
                        },
                        children: List.generate(
                          //change to orders list from API depending on the status
                          _dummyRowData.length * 3,
                          (i) => TableRow(
                              decoration: BoxDecoration(color: i.isEven ? AppColors.shadow : AppColors.bg),
                              children: List.generate(
                                _dummyRowData.length,
                                (j) => Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 8, top: 10, bottom: 10),
                                  child: Text(
                                    _dummyRowData[j],
                                    style: AppTextStyles.bodyTable,
                                  ),
                                ),
                              )),
                        )),
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

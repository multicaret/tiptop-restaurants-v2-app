import 'package:flutter/material.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class OrdersStatusTabs extends StatelessWidget {
  final List<Widget> tabs;
  final TabController tabController;
  final Widget child;
  final Function onTap;

  const OrdersStatusTabs({
    @required this.tabs,
    @required this.tabController,
    this.child,
    this.onTap,
  });

  static double _parentsTabHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: _parentsTabHeight,
      color: AppColors.primary,
      child: TabBar(
        indicatorPadding: const EdgeInsets.only(top: 6, left: 6, right: 6),
        isScrollable: true,
        controller: tabController,
        labelStyle: AppTextStyles.subtitle,
        unselectedLabelStyle: AppTextStyles.subtitleWhite,
        unselectedLabelColor: AppColors.white,
        labelColor: AppColors.primary,
        labelPadding: const EdgeInsets.symmetric(horizontal: 15),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          color: AppColors.bg,
        ),
        indicatorColor: AppColors.white,
        tabs: tabs,
        onTap: onTap,
      ),
    );
  }
}

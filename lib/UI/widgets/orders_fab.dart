import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tiptop_v2/UI/pages/orders_page.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';

class OrdersFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(OrdersPage.routeName),
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: Platform.isIOS ? 30 : 5),
                height: 75,
                width: 75,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                  boxShadow: [
                    const BoxShadow(blurRadius: 10, color: AppColors.shadowDark),
                  ],
                ),
                child: Icon(
                  LineAwesomeIcons.th_list,
                  size: 50,
                  color: AppColors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/models/order.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_icons.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

import 'address/address_icon.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final bool isDisabled;

  const OrderItem({
    @required this.order,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: screenHorizontalPadding, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border),
        ),
        color: isDisabled ? AppColors.white : Colors.transparent,
      ),
      width: double.infinity,
      child: Consumer<AppProvider>(
        child: Row(
          children: [
            AddressIcon(
              icon: order.address.kind.icon,
              isAsset: false,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.completedAt.formatted,
                  style: AppTextStyles.body50,
                ),
                const SizedBox(height: 5),
                Text(order.address.kind.title)
              ],
            )
          ],
        ),
        builder: (c, appProvider, addressIconAndOrderDate) => Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  addressIconAndOrderDate,
                  Container(
                    height: 33,
                    width: 110,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [const BoxShadow(blurRadius: 6, color: AppColors.shadowDark)],
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 33,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(appProvider.isRTL ? 0 : 8),
                              bottomLeft: Radius.circular(appProvider.isRTL ? 0 : 8),
                              topRight: Radius.circular(appProvider.isRTL ? 8 : 0),
                              bottomRight: Radius.circular(appProvider.isRTL ? 8 : 0),
                            ),
                          ),
                          child: AppIcons.icon(LineAwesomeIcons.shopping_cart),
                        ),
                        Expanded(
                          child: Html(
                            data: """${order.grandTotal.formatted}""",
                            shrinkWrap: true,
                            style: {
                              "body": Style(
                                color: AppColors.white,
                                fontSize: order.grandTotal.formatted.length > 7 ? FontSize(10) : FontSize(12),
                                lineHeight: LineHeight(1),
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (!isDisabled) const SizedBox(width: 10),
            if (!isDisabled) AppIcons.iconSecondary(appProvider.isRTL ? FontAwesomeIcons.angleLeft : FontAwesomeIcons.angleRight),
          ],
        ),
      ),
    );
  }
}

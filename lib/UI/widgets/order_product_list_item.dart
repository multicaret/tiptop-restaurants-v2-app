import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiptop_v2/UI/widgets/circle_icon.dart';
import 'package:tiptop_v2/UI/widgets/formatted_prices.dart';
import 'package:tiptop_v2/i18n/translations.dart';
import 'package:tiptop_v2/models/product.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class OrderProductListItem extends StatelessWidget {
  final Product product;
  final String quantity;
  final List<String> productOptions;

  OrderProductListItem({
    @required this.product,
    this.quantity,
    this.productOptions,
  });

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: screenHorizontalPadding, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: AppColors.border),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleIcon(
            iconText: quantity,
            iconTextStyle: AppTextStyles.subtitleSecondaryBold,
            size: 25,
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title, style: AppTextStyles.bodyBold),
                SizedBox(height: 10),
                Container(
                  height: 20,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productOptions.length,
                      itemBuilder: (context, i) {
                        return Text('${productOptions[i]}, ', style: AppTextStyles.subtitleXs50);
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (product.unitText != null)
                  Padding(
                    padding: appProvider.isRTL ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
                    child: Text(Translations.of(context).get(product.unitText), style: AppTextStyles.subtitleXs50),
                  ),
                const SizedBox(height: 5),
                FormattedPrices(
                  price: product.price,
                  discountedPrice: product.discountedPrice,
                  isEndAligned: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

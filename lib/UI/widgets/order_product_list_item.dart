import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiptop_v2/UI/widgets/formatted_prices.dart';
import 'package:tiptop_v2/models/product.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class OrderProductListItem extends StatelessWidget {
  final Product product;
  final String quantity;
  final List<ProductOption> productOptions;

  OrderProductListItem({
    @required this.product,
    this.quantity,
    this.productOptions,
  });

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: productListItemThumbnailSize,
            height: productListItemThumbnailSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border, width: 1.5),
              image: DecorationImage(
                image: CachedNetworkImageProvider(product.media.coverThumbnail),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title),
                  const SizedBox(height: 10),
                  if (product.unitText != null) Text(product.unitText, style: AppTextStyles.subtitleXs50),
                  FormattedPrices(
                    price: product.price,
                    discountedPrice: product.discountedPrice,
                  ),
                  Container(
                    height: 20,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: productOptions.length,
                        itemBuilder: (context, i) {
                          return Text('${productOptions[i]}, ', style: AppTextStyles.subtitleXs);
                        }),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.bg,
            ),
            padding: const EdgeInsets.all(10),
            child: Text('$quantity'),
          )
        ],
      ),
    );
  }
}

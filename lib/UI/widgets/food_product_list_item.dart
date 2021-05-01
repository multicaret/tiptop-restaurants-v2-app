import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiptop_v2/UI/widgets/UI/dialogs/text_field_dialog.dart';
import 'package:tiptop_v2/models/product.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/providers/restaurants_provider.dart';
import 'package:tiptop_v2/utils/constants.dart';
import 'package:tiptop_v2/utils/helper.dart';
import 'package:tiptop_v2/utils/styles/app_colors.dart';
import 'package:tiptop_v2/utils/styles/app_text_styles.dart';

class FoodProductListItem extends StatefulWidget {
  final Product product;
  final int restaurantId;
  final int chainId;
  final bool productStatus;
  final Function onToggle;
  final Function onEditPrice;
  final Function toggleSwitch;
  final AppProvider appProvider;
  final RestaurantsProvider restaurantsProvider;

  FoodProductListItem({
    @required this.product,
    @required this.restaurantId,
    @required this.chainId,
    this.productStatus,
    this.onToggle,
    this.onEditPrice,
    this.toggleSwitch,
    this.appProvider,
    this.restaurantsProvider,
  });

  @override
  _FoodProductListItemState createState() => _FoodProductListItemState();
}

class _FoodProductListItemState extends State<FoodProductListItem> {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Container(
        height: listItemHeight,
        padding: const EdgeInsets.symmetric(horizontal: screenHorizontalPadding, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.border),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.title, style: AppTextStyles.bodyBold),
                  const SizedBox(height: 10),
                  if (widget.product.excerpt != null && widget.product.excerpt.formatted != null)
                    Expanded(
                      child: Text(
                        widget.product.excerpt.raw,
                        style: AppTextStyles.subtitle50,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.only(bottom: 8),
                        icon: Icon(FontAwesomeIcons.pen, size: 15, color: AppColors.primary50),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => TextFieldDialog(
                            textFieldLabel: 'Enter Price',
                            keyboardType: TextInputType.number,
                          ),
                        ).then((price) {
                          if (price is String && price.isNotEmpty) {
                            widget.restaurantsProvider.editProductPrice(
                              widget.appProvider,
                              widget.restaurantId,
                              widget.product.id,
                              price,
                            );
                          }
                          setState(() {
                            widget.product.price.raw = double.parse(price);
                          });
                        }),
                      ),
                      Expanded(
                        child: Text(
                          priceAndCurrency(
                            widget.product.price.raw,
                            widget.appProvider.authUser.currency,
                          ),
                          style: AppTextStyles.subtitleSecondaryBold,
                        ),
                      ),
                      Switch(
                        value: widget.product.isActive,
                        onChanged: (value) {
                          widget.restaurantsProvider.toggleProductStatus(
                            widget.appProvider,
                            widget.restaurantId,
                            widget.product.id,
                            value,
                          );
                          setState(() {
                            widget.product.isActive = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 0.5, color: AppColors.border),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.product.media.coverThumbnail,
                  fit: BoxFit.cover,
                  width: listItemThumbnailSize,
                  height: listItemThumbnailSize,
                  placeholder: (_, __) => SpinKitFadingCircle(color: AppColors.secondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

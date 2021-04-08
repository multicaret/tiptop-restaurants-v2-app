import 'package:flutter/material.dart';
import 'package:tiptop_v2/models/cart.dart';
import 'package:tiptop_v2/models/product.dart';
import 'package:tiptop_v2/providers/app_provider.dart';
import 'package:tiptop_v2/providers/home_provider.dart';
import 'package:tiptop_v2/utils/helper.dart';
import 'package:tiptop_v2/utils/http_exception.dart';

class CartProvider with ChangeNotifier {
  Cart marketCart;
  Cart foodCart;

  bool isLoadingAdjustCartQuantityRequest = false;
  bool isLoadingClearCartRequest = false;

  void setMarketCart(Cart _marketCart) {
    print(
        'setting market cart${_marketCart == null ? ' (null)' : ', market cart id: ${_marketCart.id}'}, products count: ${_marketCart.products.length}');
    marketCart = _marketCart;
    clearRequestedMoreThanAvailableQuantity();
  }

  void setFoodCart(Cart _foodCart) {
    print('setting cart${_foodCart == null ? ' (null)' : ', marketCart id: ${_foodCart.id}'}, products count: ${_foodCart.products.length}');
    foodCart = _foodCart;
    clearRequestedMoreThanAvailableQuantity();
  }

  bool get noMarketCart =>
      marketCart == null || marketCart.id == null || marketCart.total.raw == null || marketCart.total.raw == 0.0 || marketCart.productsCount == 0;

  bool get noFoodCart =>
      foodCart == null || foodCart.id == null || foodCart.total.raw == null || foodCart.total.raw == 0.0 || foodCart.productsCount == 0;

  int getProductQuantity(int productId) {
    if (marketCart != null && marketCart.products.length != 0) {
      CartProduct cartProduct = marketCart.products.firstWhere((cartProduct) => cartProduct.product.id == productId, orElse: () => null);
      return cartProduct == null ? 0 : cartProduct.quantity;
    } else {
      return 0;
    }
  }

  Map<int, bool> requestedMoreThanAvailableQuantity = {};
  Map<int, bool> isLoadingAdjustMarketProductQuantityRequest = {};

  Future<int> adjustMarketProductQuantity({
    @required AppProvider appProvider,
    @required bool isAdding,
    @required Product product,
  }) async {
    if (marketCart == null || marketCart.id == null) {
      print('No marketCart');
      showToast(msg: 'An Error Occurred! Logging out...');
      appProvider.logout(clearSelectedAddress: true);
      return 401;
    }

    if (HomeProvider.branchId == null || HomeProvider.chainId == null) {
      print('Cannot find branch id and/or chain id!');
      return null;
    }

    final endpoint = 'carts/${marketCart.id}/products/adjust-quantity';
    Map<String, dynamic> body = {
      'product_id': product.id,
      'chain_id': HomeProvider.chainId,
      'branch_id': HomeProvider.branchId,
      'is_adding': isAdding,
    };

    isLoadingAdjustCartQuantityRequest = true;
    isLoadingAdjustMarketProductQuantityRequest[product.id] = true;
    requestedMoreThanAvailableQuantity[product.id] = false;
    notifyListeners();

    final responseData = await appProvider.post(
      endpoint: endpoint,
      body: body,
      withToken: true,
      overrideStatusCheck: true,
    );
    print('adjust market cart product quantity response data');
    print(responseData);

    if (responseData == 401) {
      return 401;
    }
    CartData cartData = CartData.fromJson(responseData["data"]);

    if (responseData["data"] != null && responseData["status"] == 422) {
      showToast(msg: 'There are only ${cartData.availableQuantity} available ${product.title}');
      requestedMoreThanAvailableQuantity[product.id] = true;
      isLoadingAdjustCartQuantityRequest = false;
      isLoadingAdjustMarketProductQuantityRequest[product.id] = false;
      notifyListeners();
      return null;
    }

    if (responseData["data"] == null || responseData["status"] != 200) {
      isLoadingAdjustCartQuantityRequest = false;
      isLoadingAdjustMarketProductQuantityRequest[product.id] = false;
      notifyListeners();
      throw HttpException(title: 'Http Exception Error', message: getHttpExceptionMessage(responseData));
    }

    isLoadingAdjustCartQuantityRequest = false;
    isLoadingAdjustMarketProductQuantityRequest[product.id] = false;
    marketCart = cartData.cart;
    notifyListeners();

    return getProductQuantity(product.id);
  }

/*
  Future<int> addRemoveProduct({
    @required BuildContext context,
    @required AppProvider appProvider,
    @required bool isAdding,
    @required Product product,
  }) async {
    print('branch and chain ids from add remove products request:');
    print('${HomeProvider.branchId}, ${HomeProvider.chainId}');

    if (marketCart == null || marketCart.id == null) {
      print('No marketCart');
      showToast(msg: 'An Error Occurred! Logging out...');
      appProvider.logout(clearSelectedAddress: true);
      return null;
    }

    final endpoint = 'carts/${marketCart.id}/products/adjust-quantity';
    Map<String, dynamic> body = {
      'product_id': product.id,
      'chain_id': HomeProvider.chainId,
      'branch_id': HomeProvider.branchId,
      'is_adding': isAdding,
    };

    isLoadingAddRemoveRequest = true;

    requestedMoreThanAvailableQuantity[product.id] = false;
    List<CartProduct> _oldCartProducts = marketCartProducts;
    int oldProductQuantity = getProductQuantity(product.id);
    if (!isAdding && oldProductQuantity == 0) {
      return 0;
    }

    int requestedProductQuantity = isAdding
        ? oldProductQuantity + 1
        : oldProductQuantity == 1
            ? 0
            : oldProductQuantity - 1;

    if (!isAdding && oldProductQuantity == 1) {
      marketCartProducts = marketCartProducts.where((cartProduct) => cartProduct.product.id != product.id).toList();
      notifyListeners();
    } else if (oldProductQuantity == 0) {
      CartProduct _newTempCartProduct = CartProduct(
        product: product,
        quantity: requestedProductQuantity,
      );
      marketCartProducts.add(_newTempCartProduct);
      notifyListeners();
    } else {
      int requestedCartProductIndex = marketCartProducts.indexWhere((cartProduct) => cartProduct.product.id == product.id);
      marketCartProducts[requestedCartProductIndex].quantity = requestedProductQuantity;
      notifyListeners();
    }

    final responseData = await appProvider.post(
      endpoint: endpoint,
      body: body,
      withToken: true,
    );

    isLoadingAddRemoveRequest = false;
    if (responseData == 401) {
      //Sending authenticated request without logging in!
      marketCartProducts = _oldCartProducts;
      notifyListeners();
      showToast(msg: 'You need to log in first!');
      Navigator.of(context, rootNavigator: true).pushReplacementNamed(WalkthroughPage.routeName);
      return null;
    }

    addRemoveProductDataResponse = AddRemoveProductDataResponse.fromJson(responseData);

    if (addRemoveProductDataResponse.status == 422) {
      requestedMoreThanAvailableQuantity[product.id] = true;
      int productAvailableQuantity = addRemoveProductDataResponse.cartData.availableQuantity;
      int requestedCartProductIndex = marketCartProducts.indexWhere((cartProduct) => cartProduct.product.id == product.id);
      marketCartProducts[requestedCartProductIndex].quantity = productAvailableQuantity;
      notifyListeners();
      showToast(msg: 'There are only $productAvailableQuantity available ${product.title}');
      return productAvailableQuantity;
    }

    if (addRemoveProductDataResponse.cartData == null || addRemoveProductDataResponse.status != 200) {
      marketCartProducts = _oldCartProducts;
      notifyListeners();
      throw HttpException(title: 'Http Exception Error', message: addRemoveProductDataResponse.message);
    }

    marketCart = addRemoveProductDataResponse.cartData.cart;
    notifyListeners();

    return getProductQuantity(product.id);
  }

  void clearRequestedMoreThanAvailableQuantity() {
    if (marketCart != null && marketCart.products != null && marketCart.products.length > 0) {
      marketCart.products.forEach((cartProduct) => requestedMoreThanAvailableQuantity[cartProduct.product.id] = false);
    }
  }

  Future<void> clearCart(AppProvider appProvider) async {
    final endpoint = 'carts/${marketCart.id}/delete';
    clearRequestedMoreThanAvailableQuantity();
    isLoadingClearCartRequest = true;
    notifyListeners();

    Map<String, dynamic> body = {
      'branch_id': HomeProvider.branchId,
      'chain_id': HomeProvider.chainId,
    };

    try {
      await appProvider.post(
        endpoint: endpoint,
        body: body,
        withToken: true,
      );

      isLoadingClearCartRequest = false;
      notifyListeners();
    } catch (e) {
      isLoadingClearCartRequest = true;
      notifyListeners();
      throw e;
    }
  }
}

import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  // HomeData marketHomeData;
  // // List<Category> marketCategories = [];
  // Currency marketCurrency;
  //
  // HomeData foodHomeData;
  // Currency foodCurrency;
  //
  // static int branchId;
  // static int chainId;
  //
  // bool categorySelected = false;
  // int selectedParentCategoryId;
  //
  // bool isLoadingHomeData = false;
  //
  // bool marketHomeDataRequestError = false;
  // bool marketNoBranchFound = false;
  // String marketNoAvailabilityMessage = '';
  //
  // bool foodNoRestaurantFound = false;
  // bool foodHomeDataRequestError = false;
  // String foodNoAvailabilityMessage = '';
  //
  // static double marketBranchLat;
  // static double marketBranchLong;
  //
  // LocalStorage storageActions = LocalStorage.getActions();
  // bool isLocationPermissionGranted = false;
  //
  // AppChannel selectedChannel = AppProvider.appDefaultChannel;
  //
  // bool get channelIsMarket => selectedChannel == AppChannel.MARKET;
  //
  // void setSelectedChannel(AppChannel _channel) {
  //   selectedChannel = _channel;
  //   print('Selected channel: $selectedChannel');
  //   notifyListeners();
  // }
  //
  // void setIsLoadingHomeData(bool _value) {
  //   isLoadingHomeData = _value;
  //   notifyListeners();
  // }
  //
  // EstimatedArrivalTime getEstimateArrivalTime() {
  //   if (channelIsMarket) {
  //     return marketHomeData == null ? null : marketHomeData.estimatedArrivalTime;
  //   } else {
  //     return foodHomeData == null ? null : foodHomeData.estimatedArrivalTime;
  //   }
  // }
  //
  // Future<void> fetchAndSetHomeData(
  //   BuildContext context,
  //   AppProvider appProvider,
  // ) async {
  //   final endpoint = 'home';
  //   isLoadingHomeData = true;
  //   notifyListeners();
  //   // CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
  //   // RestaurantsProvider restaurantsProvider = Provider.of<RestaurantsProvider>(context, listen: false);
  //
  //   if (AppProvider.latitude == null || AppProvider.longitude == null) {
  //     print('Lat/Long not found!');
  //     bool isGranted = await getLocationPermissionStatus();
  //     if (!isGranted) {
  //       Navigator.of(context, rootNavigator: true).pushReplacementNamed(LocationPermissionPage.routeName);
  //     } else {
  //       await updateLocationAndStoreIt();
  //     }
  //   }
  //
  //   final body = {
  //     'latitude': '${AppProvider.latitude}',
  //     'longitude': '${AppProvider.longitude}',
  //     'channel': appChannelValues.reverse[selectedChannel],
  //     // 'selected_address_id': AddressesProvider.selectedAddressId == null ? '' : '${AddressesProvider.selectedAddressId}',
  //   };
  //
  //   marketHomeDataRequestError = false;
  //   foodHomeDataRequestError = false;
  //   marketNoBranchFound = false;
  //   foodNoRestaurantFound = false;
  //   try {
  //     final responseData = await appProvider.get(
  //       endpoint: endpoint,
  //       body: body,
  //       withToken: appProvider.isAuth,
  //     );
  //
  //     // setHomeData(cartProvider, restaurantsProvider, responseData["data"]);
  //     isLoadingHomeData = false;
  //     notifyListeners();
  //   } catch (e) {
  //     if (channelIsMarket) {
  //       print('An error happened in market home data request');
  //       marketHomeDataRequestError = true;
  //       // throw e;
  //     } else {
  //       print('An error happened in food home data request');
  //       foodHomeDataRequestError = true;
  //       // throw e;
  //     }
  //     isLoadingHomeData = false;
  //     notifyListeners();
  //   }
  // }

  // void setHomeData(CartProvider cartProvider, RestaurantsProvider restaurantsProvider, data) {
  //   if (channelIsMarket) {
  //     print('Setting market home data...');
  //     marketHomeData = HomeData.fromJson(data);
  //     marketCurrency = marketHomeData.currentCurrency;
  //     if (marketHomeData.branch == null) {
  //       marketNoBranchFound = true;
  //       marketNoAvailabilityMessage = marketHomeData != null && marketHomeData.noAvailabilityMessage != null ? marketHomeData.noAvailabilityMessage : '';
  //       print('marketNoAvailabilityMessage');
  //       print(marketNoAvailabilityMessage);
  //     } else {
  //       branchId = marketHomeData.branch.id;
  //       if (marketHomeData.branch.chain != null) {
  //         chainId = marketHomeData.branch.chain.id;
  //       }
  //       marketBranchLat = marketHomeData.branch.latitude;
  //       marketBranchLong = marketHomeData.branch.longitude;
  //     }
  //
  //     final _marketCategories = marketHomeData.categories;
  //     marketCategories = _marketCategories.where((parentCategory) {
  //       bool atLeastOneChildHasProducts = false;
  //       if (parentCategory.hasChildren) {
  //         final childCategories = parentCategory.childCategories;
  //         childCategories.forEach((child) {
  //           if (child.products.length > 0) {
  //             atLeastOneChildHasProducts = true;
  //             return;
  //           }
  //         });
  //       }
  //       return parentCategory.hasChildren && atLeastOneChildHasProducts;
  //     }).toList();
  //
  //     if (marketHomeData.cart != null) {
  //       cartProvider.setMarketCart(marketHomeData.cart);
  //     }
  //   } else {
  //     print('Setting food home data...');
  //     foodHomeData = HomeData.fromJson(data);
  //     foodCurrency = foodHomeData.currentCurrency;
  //     if (foodHomeData.restaurants.length == 0) {
  //       foodNoRestaurantFound = true;
  //       foodNoAvailabilityMessage = foodHomeData != null && foodHomeData.noAvailabilityMessage != null ? foodHomeData.noAvailabilityMessage : '';
  //     } else {
  //       restaurantsProvider.setRestaurantData(foodHomeData);
  //     }
  //
  //     if (foodHomeData.cart != null) {
  //       cartProvider.setFoodCart(foodHomeData.cart);
  //     }
  //   }
  // }
}

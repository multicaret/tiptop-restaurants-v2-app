import 'package:tiptop_v2/models/user.dart';

import 'address.dart';
import 'cart.dart';
import 'enums.dart';
import 'models.dart';

class OrderResponse {
  OrderResponse({
    this.data,
    this.errors,
    this.message,
    this.status,
  });

  OrderData data;
  List<dynamic> errors;
  String message;
  int status;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        data: OrderData.fromJson(json["data"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "message": message,
        "status": status,
      };
}

class OrderData {
  OrderData({
    this.orders,
    this.counts,
  });

  List<Order> orders;
  Map<String, int> counts;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        counts: Map.from(json["counts"]).map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "counts": Map.from(counts).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class CheckoutData {
  CheckoutData({
    this.paymentMethods,
    this.deliveryFee,
    this.total,
    this.grandTotal,
  });

  List<PaymentMethod> paymentMethods;
  DoubleRawStringFormatted deliveryFee;
  DoubleRawStringFormatted total;
  DoubleRawStringFormatted grandTotal;

  factory CheckoutData.fromJson(Map<String, dynamic> json) => CheckoutData(
        paymentMethods: List<PaymentMethod>.from(json["paymentMethods"].map((x) => PaymentMethod.fromJson(x))),
        deliveryFee: DoubleRawStringFormatted.fromJson(json["deliveryFee"]),
        total: DoubleRawStringFormatted.fromJson(json["total"]),
        grandTotal: DoubleRawStringFormatted.fromJson(json["grandTotal"]),
      );

  Map<String, dynamic> toJson() => {
        "paymentMethods": List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
        "deliveryFee": deliveryFee,
        "total": total,
        "grandTotal": grandTotal,
      };
}

class PaymentMethod {
  PaymentMethod({
    this.id,
    this.title,
    this.description,
    this.instructions,
    this.logo,
  });

  int id;
  String title;
  dynamic description;
  dynamic instructions;
  String logo;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        instructions: json["instructions"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "instructions": instructions,
        "logo": logo,
      };
}

class SubmitOrderResponse {
  SubmitOrderResponse({
    this.submittedOrder,
    this.errors,
    this.message,
    this.status,
  });

  Order submittedOrder;
  String errors;
  String message;
  int status;

  factory SubmitOrderResponse.fromJson(Map<String, dynamic> json) => SubmitOrderResponse(
        submittedOrder: json["data"] == null ? null : Order.fromJson(json["data"]),
        errors: json["errors"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": submittedOrder.toJson(),
        "errors": errors,
        "message": message,
        "status": status,
      };
}

class PreviousOrdersResponseData {
  PreviousOrdersResponseData({
    this.previousOrders,
    this.errors,
    this.message,
    this.status,
  });

  List<Order> previousOrders;
  dynamic errors;
  String message;
  int status;

  factory PreviousOrdersResponseData.fromJson(Map<String, dynamic> json) => PreviousOrdersResponseData(
        previousOrders: json["data"] == null ? null : List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
        errors: json["errors"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": previousOrders == null ? null : List<dynamic>.from(previousOrders.map((x) => x.toJson())),
        "errors": errors,
        "message": message,
        "status": status,
      };
}

class Order {
  Order({
    this.id,
    this.referenceCode,
    this.address,
    this.completedAt,
    this.couponCode,
    this.deliveryType,
    this.couponDiscountAmount,
    this.totalAfterCouponDiscount,
    this.deliveryFee,
    this.grandTotal,
    this.orderRating,
    this.status,
    this.cart,
    this.user,
    this.paymentMethod,
  });

  int id;
  int referenceCode;
  Address address;
  EdAt completedAt;
  String couponCode;
  String deliveryType;
  DoubleRawStringFormatted couponDiscountAmount;
  DoubleRawStringFormatted totalAfterCouponDiscount;
  DoubleRawStringFormatted deliveryFee;
  DoubleRawStringFormatted grandTotal;
  OrderRating orderRating;
  OrderStatus status;
  User user;
  Cart cart;
  PaymentMethod paymentMethod;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        referenceCode: json["referenceCode"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        completedAt: EdAt.fromJson(json["completedAt"]),
        couponCode: json["couponCode"],
        couponDiscountAmount: json["couponDiscountAmount"] == null ? null : DoubleRawStringFormatted.fromJson(json["couponDiscountAmount"]),
        totalAfterCouponDiscount:
            json["totalAfterCouponDiscount"] == null ? null : DoubleRawStringFormatted.fromJson(json["totalAfterCouponDiscount"]),
        deliveryFee: DoubleRawStringFormatted.fromJson(json["deliveryFee"]),
        deliveryType: json["deliveryType"],
        grandTotal: DoubleRawStringFormatted.fromJson(json["grandTotal"]),
        orderRating: OrderRating.fromJson(json["rating"]),
        status: json["status"] == null ? null : restaurantOrderStatusValues.map[json["status"].toString()],
        user: User.fromJson(json["user"]),
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
        paymentMethod: PaymentMethod.fromJson(json["paymentMethod"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address.toJson(),
        "completedAt": completedAt.toJson(),
        "deliveryFee": deliveryFee.toJson(),
        "grandTotal": grandTotal.toJson(),
        "rating": orderRating.toJson(),
        "cart": cart.toJson(),
        "paymentMethod": paymentMethod.toJson(),
      };
}

class OrderRating {
  OrderRating({
    this.branchHasBeenRated,
    this.branchRatingValue,
    this.driverHasBeenRated,
    this.driverRatingValue,
    this.ratingComment,
    this.hasGoodFoodQualityRating,
    this.hasGoodPackagingQualityRating,
    this.hasGoodOrderAccuracyRating,
    this.ratingIssue,
  });

  bool branchHasBeenRated;
  double branchRatingValue;
  bool driverHasBeenRated;
  double driverRatingValue;
  String ratingComment;
  bool hasGoodFoodQualityRating;
  bool hasGoodPackagingQualityRating;
  bool hasGoodOrderAccuracyRating;
  MarketOrderRatingAvailableIssue ratingIssue;

  factory OrderRating.fromJson(Map<String, dynamic> json) => OrderRating(
        branchHasBeenRated: json["branchHasBeenRated"],
        branchRatingValue: json["branchRatingValue"].toDouble(),
        driverHasBeenRated: json["driverHasBeenRated"],
        driverRatingValue: json["driverRatingValue"].toDouble(),
        ratingComment: json["ratingComment"],
        hasGoodFoodQualityRating: json["hasGoodFoodQualityRating"],
        hasGoodPackagingQualityRating: json["hasGoodPackagingQualityRating"],
        hasGoodOrderAccuracyRating: json["hasGoodOrderAccuracyRating"],
        ratingIssue: MarketOrderRatingAvailableIssue.fromJson(json["ratingIssue"]),
      );

  Map<String, dynamic> toJson() => {
        "branchHasBeenRated": branchHasBeenRated,
        "branchRatingValue": branchRatingValue,
        "driverHasBeenRated": driverHasBeenRated,
        "driverRatingValue": driverRatingValue,
        "ratingComment": ratingComment,
        "hasGoodFoodQualityRating": hasGoodFoodQualityRating,
        "hasGoodPackagingQualityRating": hasGoodPackagingQualityRating,
        "hasGoodOrderAccuracyRating": hasGoodOrderAccuracyRating,
        "ratingIssue": ratingIssue.toJson(),
      };
}

class MarketOrderRatingAvailableIssue {
  MarketOrderRatingAvailableIssue({
    this.id,
    this.title,
  });

  int id;
  String title;

  factory MarketOrderRatingAvailableIssue.fromJson(Map<String, dynamic> json) => MarketOrderRatingAvailableIssue(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class FoodOrderRatingFactors {
  FoodOrderRatingFactors({
    this.key,
    this.label,
  });

  String key;
  String label;

  factory FoodOrderRatingFactors.fromJson(Map<String, dynamic> json) => FoodOrderRatingFactors(
        key: json["key"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "label": label,
      };
}

class CouponValidationResponseData {
  CouponValidationResponseData({
    this.discountedAmount,
    this.deliveryFee,
    this.totalBefore,
    this.totalAfter,
    this.grandTotal,
  });

  DoubleRawStringFormatted discountedAmount;
  DoubleRawStringFormatted deliveryFee;
  DoubleRawStringFormatted totalBefore;
  DoubleRawStringFormatted totalAfter;
  DoubleRawStringFormatted grandTotal;

  factory CouponValidationResponseData.fromJson(Map<String, dynamic> json) => CouponValidationResponseData(
        discountedAmount: DoubleRawStringFormatted.fromJson(json["discountedAmount"]),
        deliveryFee: DoubleRawStringFormatted.fromJson(json["deliveryFee"]),
        totalBefore: DoubleRawStringFormatted.fromJson(json["totalBefore"]),
        totalAfter: DoubleRawStringFormatted.fromJson(json["totalAfter"]),
        grandTotal: DoubleRawStringFormatted.fromJson(json["grandTotal"]),
      );
}

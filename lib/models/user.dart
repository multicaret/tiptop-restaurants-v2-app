import 'models.dart';

class AuthRequestData {
  User user;
  String accessToken;
  Approval isApproved;
  Approval isSuspended;

  AuthRequestData({
    this.user,
    this.accessToken,
    this.isApproved,
    this.isSuspended,
  });

  factory AuthRequestData.fromJson(Map<String, dynamic> json) => AuthRequestData(
        user: User.fromJson(json["user"]),
        accessToken: json["accessToken"],
        isApproved: json["isApproved"] == null ? null : Approval.fromJson(json["isApproved"]),
        isSuspended: json["isSuspended"] == null ? null : Approval.fromJson(json["isSuspended"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "accessToken": accessToken,
        "isApproved": isApproved.toJson(),
        "isSuspended": isSuspended.toJson(),
      };
}

class Approval {
  bool enabled;
  String message;

  Approval({
    this.enabled,
    this.message,
  });

  factory Approval.fromJson(Map<String, dynamic> json) => Approval(
        enabled: json["enabled"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "message": message,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.first,
    this.last,
    this.username,
    this.email,
    this.phone,
    this.phoneCode,
    this.phoneInternational,
    this.bio,
    this.dob,
    this.gender,
    this.avatar,
    this.cover,
    this.rating,
    this.views,
    this.status,
    this.approvedAt,
    this.phoneVerifiedAt,
    this.suspendedAt,
    this.createdAt,
    this.updatedAt,
    this.settings,
    this.currency,
    this.country,
    this.region,
    this.city,
  });

  int id;
  String name;
  String first;
  String last;
  String username;
  String email;
  dynamic phone;
  dynamic phoneCode;
  String phoneInternational;
  StringRawStringFormatted bio;
  dynamic dob;
  String gender;
  String avatar;
  String cover;
  Rating rating;
  StringRawStringFormatted views;
  int status;
  EdAt approvedAt;
  EdAt phoneVerifiedAt;
  EdAt suspendedAt;
  EdAt createdAt;
  EdAt updatedAt;
  Settings settings;
  Currency currency;
  Country country;
  Region region;
  City city;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        first: json["first"],
        last: json["last"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        phoneCode: json["phoneCode"],
        phoneInternational: json["phoneInternational"],
        bio: StringRawStringFormatted.fromJson(json["bio"]),
        dob: json["dob"],
        gender: json["gender"],
        avatar: json["avatar"],
        cover: json["cover"],
        rating: Rating.fromJson(json["rating"]),
        views: StringRawStringFormatted.fromJson(json["views"]),
        status: json["status"],
        approvedAt: EdAt.fromJson(json["approvedAt"]),
        phoneVerifiedAt: json["phoneVerifiedAt"] == null ? null : EdAt.fromJson(json["phoneVerifiedAt"]),
        suspendedAt: EdAt.fromJson(json["suspendedAt"]),
        createdAt: EdAt.fromJson(json["createdAt"]),
        updatedAt: EdAt.fromJson(json["updatedAt"]),
        settings: Settings.fromJson(json["settings"]),
        currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
        region: json["region"] == null ? null : Region.fromJson(json["region"]),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first": first,
        "last": last,
        "username": username,
        "email": email,
        "phone": phone,
        "phoneCode": phoneCode,
        "phoneInternational": phoneInternational,
        "bio": bio.toJson(),
        "dob": dob,
        "gender": gender,
        "avatar": avatar,
        "cover": cover,
        "rating": rating.toJson(),
        "views": views.toJson(),
        "status": status,
        "approvedAt": approvedAt.toJson(),
        "verifiedAt": phoneVerifiedAt.toJson(),
        "suspendedAt": suspendedAt.toJson(),
        "createdAt": createdAt.toJson(),
        "updatedAt": updatedAt.toJson(),
        "settings": settings.toJson(),
        "currency": currency == null ? null : currency.toJson(),
        "country": country == null ? null : country.toJson(),
        "region": region == null ? null : region.toJson(),
        "city": city == null ? null : city.toJson(),
      };
}

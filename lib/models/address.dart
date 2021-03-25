import 'models.dart';

class CreateAddressResponseData {
  CreateAddressResponseData({
    this.createAddressData,
    this.errors,
    this.message,
    this.status,
  });

  CreateAddressData createAddressData;
  String errors;
  String message;
  int status;

  factory CreateAddressResponseData.fromJson(Map<String, dynamic> json) => CreateAddressResponseData(
        createAddressData: json["data"] == null ? null : CreateAddressData.fromJson(json["data"]),
        errors: json["errors"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": createAddressData.toJson(),
        "errors": errors,
        "message": message,
        "status": status,
      };
}

class CreateAddressData {
  CreateAddressData({
    this.regions,
    this.cities,
    this.selectedRegion,
    this.selectedCity,
  });

  List<Region> regions;
  List<City> cities;
  Region selectedRegion;
  City selectedCity;

  factory CreateAddressData.fromJson(Map<String, dynamic> json) => CreateAddressData(
        regions: List<Region>.from(json["regions"].map((x) => Region.fromJson(x))),
        cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
        selectedRegion: Region.fromJson(json["selectedRegion"]),
        selectedCity: City.fromJson(json["selectedCity"]),
      );

  Map<String, dynamic> toJson() => {
        "regions": List<dynamic>.from(regions.map((x) => x.toJson())),
        "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
        "selectedRegion": selectedRegion.toJson(),
        "selectedCity": selectedCity.toJson(),
      };
}

class AddressesResponseData {
  AddressesResponseData({
    this.addressesData,
    this.errors,
    this.message,
    this.status,
  });

  AddressesData addressesData;
  String errors;
  String message;
  int status;

  factory AddressesResponseData.fromJson(Map<String, dynamic> json) => AddressesResponseData(
        addressesData: json["data"] == null ? null : AddressesData.fromJson(json["data"]),
        errors: json["errors"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": addressesData.toJson(),
        "errors": errors,
        "message": message,
        "status": status,
      };
}

class AddressesData {
  AddressesData({
    this.addresses,
    this.kinds,
  });

  List<Address> addresses;
  List<Kind> kinds;

  factory AddressesData.fromJson(Map<String, dynamic> json) => AddressesData(
        addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
        kinds: List<Kind>.from(json["addresses"].map((x) => Kind.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "kinds": List<dynamic>.from(kinds.map((x) => x.toJson())),
      };
}

class Kind {
  Kind({
    this.id,
    this.title,
    this.icon,
  });

  int id;
  String title;
  String icon;

  factory Kind.fromJson(Map<String, dynamic> json) => Kind(
        id: json["id"],
        title: json["title"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon": icon,
      };
}

class Address {
  Address({
    this.id,
    this.country,
    this.region,
    this.city,
    this.alias,
    this.name,
    this.address1,
    this.latitude,
    this.longitude,
    this.notes,
    this.kind,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  Country country;
  Region region;
  City city;
  String alias;
  dynamic name;
  String address1;
  double latitude;
  double longitude;
  StringRawStringFormatted notes;
  Kind kind;
  EdAt createdAt;
  EdAt updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        country: Country.fromJson(json["country"]),
        region: Region.fromJson(json["region"]),
        city: City.fromJson(json["city"]),
        alias: json["alias"],
        name: json["name"],
        address1: json["address1"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        notes: StringRawStringFormatted.fromJson(json["notes"]),
        kind: Kind.fromJson(json["kind"]),
        createdAt: EdAt.fromJson(json["createdAt"]),
        updatedAt: EdAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country.toJson(),
        "region": region.toJson(),
        "city": city.toJson(),
        "alias": alias,
        "name": name,
        "address1": address1,
        "latitude": latitude,
        "longitude": longitude,
        "notes": notes.toJson(),
        "kind": kind.toJson(),
        "createdAt": createdAt.toJson(),
        "updatedAt": updatedAt.toJson(),
      };
}
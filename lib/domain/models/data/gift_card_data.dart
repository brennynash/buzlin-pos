import 'package:admin_desktop/domain/models/data/shop_data.dart';

import 'translation.dart';

class GiftCardData {
  int? id;
  int? shopId;
  int? active;
  int? price;
  String? time;
  ShopData? shop;
  Translation? translation;
  List<Translation>? translations;


  GiftCardData({
    this.id,
    this.shopId,
    this.active,
    this.price,
    this.time,
    this.shop,
    this.translation,
    this.translations
  });

  factory GiftCardData.fromJson(Map<String, dynamic> json) => GiftCardData(
    id: json["id"],
    shopId: json["shop_id"],
    active: json["active"],
    price: json["price"],
    time: json["time"],
    shop: ShopData.fromJson(json["shop"]),
    translation: Translation.fromJson(json["translation"]),
    translations: json["translations"] != null ? List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    if(active != null)
      "active": active,
    if(price != null)
      "price": price,
    if(time != null)
      "time": time,
    if(shop != null)
      "shop": shop?.toJson(),
    if(translation != null)
      "translation": translation?.toJson(),
    if(translations != null)
      "translations": List<dynamic>.from(translations!.map((x) => x.toJson())),
  };
  GiftCardData copyWith({
    int? id,
    int? shopId,
    int? active,
    int? price,
    String? time,
    ShopData? shop,
    Translation? translation,
    List<Translation>? translations,
  }) {
    return GiftCardData(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      active: active ?? this.active,
      price: price ?? this.price,
      time: time ?? this.time,
      shop: shop ?? this.shop,
      translation: translation ?? this.translation,
      translations: translations ?? this.translations,
    );
  }
}


class LatLong {
  dynamic latitude;
  dynamic longitude;

  LatLong({
    required this.latitude,
    required this.longitude,
  });

  factory LatLong.fromJson(Map<String, dynamic> json) => LatLong(
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

import '../models.dart';


class Location {
  int? id;
  int? shopId;
  int? regionId;
  int? countryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  ShopRegion? region;
  CountryData? country;
  CityData? city;
  Area? area;
  int? cityId;

  Location({
    this.id,
    this.shopId,
    this.regionId,
    this.countryId,
    this.createdAt,
    this.updatedAt,
    this.region,
    this.country,
    this.city,
    this.area,
    this.cityId,
  });

  Location copyWith({
    int? id,
    int? shopId,
    int? regionId,
    int? countryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    ShopRegion? region,
    CountryData? country,
    CityData? city,
    Area? area,
    int? cityId,
  }) =>
      Location(
        id: id ?? this.id,
        shopId: shopId ?? this.shopId,
        regionId: regionId ?? this.regionId,
        countryId: countryId ?? this.countryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        region: region ?? this.region,
        country: country ?? this.country,
        city: city ?? this.city,
        area: area ?? this.area,
        cityId: cityId ?? this.cityId,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        shopId: json["shop_id"],
        regionId: json["region_id"],
        countryId: json["country_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        region:
            json["region"] == null ? null : ShopRegion.fromJson(json["region"]),
        country: json["country"] == null
            ? null
            : CountryData.fromJson(json["country"]),
        area: json["area"] == null ? null : Area.fromJson(json["area"]),
        city: json["city"] == null ? null : CityData.fromJson(json["city"]),
        cityId: json["city_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "region_id": regionId,
        "country_id": countryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "region": region?.toJson(),
        "country": country?.toJson(),
        "city": city?.toJson(),
        "area": area,
        "city_id": cityId,
      };
}

class ShopRegion {
  int? id;
  bool? active;
  Translation? translation;

  ShopRegion({
    this.id,
    this.active,
    this.translation,
  });

  ShopRegion copyWith({
    int? id,
    bool? active,
    Translation? translation,
  }) =>
      ShopRegion(
        id: id ?? this.id,
        active: active ?? this.active,
        translation: translation ?? this.translation,
      );

  factory ShopRegion.fromJson(Map<String, dynamic> json) => ShopRegion(
        id: json["id"],
        active: json["active"],
        translation: json["translation"] == null
            ? null
            : Translation.fromJson(json["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "translation": translation?.toJson(),
      };
}

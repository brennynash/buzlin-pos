import '../models.dart';

class DeliveryPointsData {
  int? id;
  bool? active;
  int? regionId;
  int? countryId;
  int? cityId;
  int? areaId;
  num? price;
  num? fittingRooms;
  Translation? translation;
  Region? region;
  Area? country;
  Area? city;
  Area? area;
  Address? address;
  LocationData? location;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<WorkingDay>? workingDays;
  String? img;


  DeliveryPointsData({
    this.id,
    this.active,
    this.regionId,
    this.countryId,
    this.cityId,
    this.areaId,
    this.price,
    this.fittingRooms,
    this.translation,
    this.region,
    this.country,
    this.city,
    this.area,
    this.address,
    this.location,
    this.workingDays,
    this.createdAt,
    this.updatedAt,
    this.img
  });

  DeliveryPointsData copyWith({
    int? id,
    bool? active,
    int? regionId,
    int? countryId,
    int? cityId,
    int? areaId,
    int? price,
    int? fittingRooms,
    Translation? translation,
    Region? region,
    Area? country,
    Area? city,
    Area? area,
    Address? address,
    LocationData? location,
    List<WorkingDay>? workingDays,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? img,
  }) =>
      DeliveryPointsData(
        id: id ?? this.id,
        active: active ?? this.active,
        regionId: regionId ?? this.regionId,
        countryId: countryId ?? this.countryId,
        cityId: cityId ?? this.cityId,
        areaId: areaId ?? this.areaId,
        price: price ?? this.price,
        fittingRooms: fittingRooms ?? this.fittingRooms,
        translation: translation ?? this.translation,
        region: region ?? this.region,
        country: country ?? this.country,
        city: city ?? this.city,
        area: area ?? this.area,
        address: address ?? this.address,
        location: location ?? this.location,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        workingDays: workingDays ?? this.workingDays,
        img:  img ?? this.img
      );

  factory DeliveryPointsData.fromJson(Map<String, dynamic> json) => DeliveryPointsData(
    id: json["id"],
    active: json["active"],
    regionId: json["region_id"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    areaId: json["area_id"],
    price: json["price"],
    fittingRooms: json["fitting_rooms"],
    translation: json["translation"] == null
        ? null
        : Translation.fromJson(json["translation"]),
    region: json["region"] == null ? null : Region.fromJson(json["region"]),
    country:
    json["country"] == null ? null : Area.fromJson(json["country"]),
    city: json["city"] == null ? null : Area.fromJson(json["city"]),
    area: json["area"] == null ? null : Area.fromJson(json["area"]),
    address: json["address"] == null
        ? null
        : Address.fromJson( (json["address"] as Map).isNotEmpty
        ? (json["address"] as Map).values.first
        : null ),
    location: json["location"] == null
        ? null
        : LocationData.fromJson(json["location"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    workingDays: json["working_days"] == null ? [] : List<WorkingDay>.from(json["working_days"]!.map((x) => WorkingDay.fromJson(x))),
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "active": active,
    "region_id": regionId,
    "country_id": countryId,
    "city_id": cityId,
    "area_id": areaId,
    "price": price,
    "fitting_rooms": fittingRooms,
    "translation": translation?.toJson(),
    "region": region?.toJson(),
    "country": country?.toJson(),
    "city": city?.toJson(),
    "area": area?.toJson(),
    "address": address?.toJson(),
    "location": location?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "working_days": workingDays == null ? [] : List<dynamic>.from(workingDays!.map((x) => x.toJson())),

  };
}

class Address {
  String? address;

  Address({
    this.address,
  });

  Address copyWith({
    String? address,
  }) =>
      Address(
        address: address ?? this.address,
      );

  factory Address.fromJson(String address) {
    return Address(
      address: address,
    );
  }

  Map<String, dynamic> toJson() => {
    "address": address,
  };
}

class Area {
  int? id;
  bool? active;
  int? regionId;
  int? countryId;
  int? cityId;
  Translation? translation;
  String? img;

  Area({
    this.id,
    this.active,
    this.regionId,
    this.countryId,
    this.cityId,
    this.translation,
    this.img,
  });

  Area copyWith({
    int? id,
    bool? active,
    int? regionId,
    int? countryId,
    int? cityId,
    Translation? translation,
    String? img,
  }) =>
      Area(
        id: id ?? this.id,
        active: active ?? this.active,
        regionId: regionId ?? this.regionId,
        countryId: countryId ?? this.countryId,
        cityId: cityId ?? this.cityId,
        translation: translation ?? this.translation,
        img: img ?? this.img,
      );

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    id: json["id"],
    active: json["active"],
    regionId: json["region_id"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    translation: json["translation"] == null
        ? null
        : Translation.fromJson(json["translation"]),
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "active": active,
    "region_id": regionId,
    "country_id": countryId,
    "city_id": cityId,
    "translation": translation?.toJson(),
    "img": img,
  };
}

class Region {
  int? id;
  bool? active;
  Translation? translation;

  Region({
    this.id,
    this.active,
    this.translation,
  });

  Region copyWith({
    int? id,
    bool? active,
    Translation? translation,
  }) =>
      Region(
        id: id ?? this.id,
        active: active ?? this.active,
        translation: translation ?? this.translation,
      );

  factory Region.fromJson(Map<String, dynamic> json) => Region(
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

class WorkingDay {
  int? id;
  String? day;
  String? from;
  String? to;
  int? deliveryPointId;
  bool? disabled;
  DateTime? createdAt;
  DateTime? updatedAt;

  WorkingDay({
    this.id,
    this.day,
    this.from,
    this.to,
    this.deliveryPointId,
    this.disabled,
    this.createdAt,
    this.updatedAt,
  });

  WorkingDay copyWith({
    int? id,
    String? day,
    String? from,
    String? to,
    int? deliveryPointId,
    bool? disabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      WorkingDay(
        id: id ?? this.id,
        day: day ?? this.day,
        from: from ?? this.from,
        to: to ?? this.to,
        deliveryPointId: deliveryPointId ?? this.deliveryPointId,
        disabled: disabled ?? this.disabled,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory WorkingDay.fromJson(Map<String, dynamic> json) =>
      WorkingDay(
        id: json["id"],
        day: json["day"],
        from: json["from"],
        to: json["to"],
        deliveryPointId: json["delivery_point_id"],
        disabled: json["disabled"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(
            json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(
            json["updated_at"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "day": day,
        "from": from,
        "to": to,
        "delivery_point_id": deliveryPointId,
        "disabled": disabled,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

// class Links {
//   String? first;
//   String? last;
//   dynamic prev;
//   String? next;
//
//   Links({
//     this.first,
//     this.last,
//     this.prev,
//     this.next,
//   });
//
//   Links copyWith({
//     String? first,
//     String? last,
//     dynamic prev,
//     String? next,
//   }) =>
//       Links(
//         first: first ?? this.first,
//         last: last ?? this.last,
//         prev: prev ?? this.prev,
//         next: next ?? this.next,
//       );
//
//   factory Links.fromJson(Map<String, dynamic> json) => Links(
//     first: json["first"],
//     last: json["last"],
//     prev: json["prev"],
//     next: json["next"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "first": first,
//     "last": last,
//     "prev": prev,
//     "next": next,
//   };
// }
//
// class Meta {
//   List<Link>? links;
//   String? path;
//   int? total;
//
//   Meta({
//     this.links,
//     this.path,
//     this.total,
//   });
//
//   Meta copyWith({
//     int? currentPage,
//     int? from,
//     int? lastPage,
//     List<Link>? links,
//     String? path,
//     int? perPage,
//     int? to,
//     int? total,
//   }) =>
//       Meta(
//         links: links ?? this.links,
//         path: path ?? this.path,
//         total: total ?? this.total,
//       );
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//     links: json["links"] == null
//         ? []
//         : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//     path: json["path"],
//     total: json["total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "links": links == null
//         ? []
//         : List<dynamic>.from(links!.map((x) => x.toJson())),
//     "path": path,
//     "total": total,
//   };
// }
//
// class Link {
//   String? url;
//   String? label;
//   bool? active;
//
//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });
//
//   Link copyWith({
//     String? url,
//     String? label,
//     bool? active,
//   }) =>
//       Link(
//         url: url ?? this.url,
//         label: label ?? this.label,
//         active: active ?? this.active,
//       );
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//     url: json["url"],
//     label: json["label"],
//     active: json["active"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "label": label,
//     "active": active,
//   };
// }

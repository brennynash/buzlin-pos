import '../data/galleries.dart';

class ShopGalleriesResponse {
  int? id;
  bool? active;
  int? shopId;
  List<Galleries>? galleries;

  ShopGalleriesResponse({
    this.id,
    this.active,
    this.shopId,
    this.galleries,
  });

  ShopGalleriesResponse copyWith({
    int? id,
    bool? active,
    int? shopId,
    List<Galleries>? galleries,
  }) =>
      ShopGalleriesResponse(
        id: id ?? this.id,
        active: active ?? this.active,
        shopId: shopId ?? this.shopId,
        galleries: galleries ?? this.galleries,
      );

  factory ShopGalleriesResponse.fromJson(Map<String, dynamic> json) => ShopGalleriesResponse(
    id: json["id"],
    active: json["active"],
    shopId: json["shop_id"],
    galleries: json["galleries"] == null ? [] : List<Galleries>.from(json["galleries"]!.map((x) => Galleries.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "active": active,
    "shop_id": shopId,
    "galleries": galleries == null ? [] : List<dynamic>.from(galleries!.map((x) => x.toJson())),
  };
}


import 'dart:convert';
import 'package:admin_desktop/domain/models/response/response.dart';
import '../data/gift_card_data.dart';

GiftCardResponse giftCardResponseFromJson(String str) => GiftCardResponse.fromJson(json.decode(str));

String giftCardResponseToJson(GiftCardResponse data) => json.encode(data.toJson());

class GiftCardResponse {
  List<GiftCardData> data;
  Links links;
  Meta? meta;

  GiftCardResponse({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory GiftCardResponse.fromJson(Map<String, dynamic> json) => GiftCardResponse(
    data: List<GiftCardData>.from(json["data"].map((x) => GiftCardData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta?.toJson(),
  };
}




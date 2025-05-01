// To parse this JSON data, do
//
//     final userGiftCardResponse = userGiftCardResponseFromJson(jsonString);

import 'dart:convert';

import '../data/meta.dart';
import '../data/user_gift_card_data.dart';

UserGiftCardResponse userGiftCardResponseFromJson(String str) => UserGiftCardResponse.fromJson(json.decode(str));

String userGiftCardResponseToJson(UserGiftCardResponse data) => json.encode(data.toJson());

class UserGiftCardResponse {
  List<UserGiftCardData>? data;
  Links links;
  Meta? meta;

  UserGiftCardResponse({
    required this.data,
    required this.links,
     required this.meta,
  });

  factory UserGiftCardResponse.fromJson(Map<String, dynamic> json) => UserGiftCardResponse(
    data: List<UserGiftCardData>.from(json["data"].map((x) => UserGiftCardData.fromJson(x))),
    links: Links.fromJson(json["links"]),
     meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    if(data != null)
      "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links.toJson(),
     "meta": meta?.toJson(),
  };
}


class Links {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}



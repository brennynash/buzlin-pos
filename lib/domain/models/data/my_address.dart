import 'location_data.dart';

class MyAddress {
  int? id;
  int? userId;
  bool? active;
  LocationData? location;
  String? firstname;
  String? lastname;
  String? phone;
  String? zipcode;
  String? streetHouseNumber;
  String? additionalDetails;
  DateTime? createdAt;
  DateTime? updatedAt;

  MyAddress({
    this.id,
    this.userId,
    this.active,
    this.location,
    this.firstname,
    this.lastname,
    this.phone,
    this.zipcode,
    this.streetHouseNumber,
    this.additionalDetails,
    this.createdAt,
    this.updatedAt,
  });

  MyAddress copyWith({
    int? id,
    int? userId,
    bool? active,
    LocationData? location,
    String? firstname,
    String? lastname,
    String? phone,
    String? zipcode,
    String? streetHouseNumber,
    String? additionalDetails,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      MyAddress(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        active: active ?? this.active,
        location: location ?? this.location,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        phone: phone ?? this.phone,
        zipcode: zipcode ?? this.zipcode,
        streetHouseNumber: streetHouseNumber ?? this.streetHouseNumber,
        additionalDetails: additionalDetails ?? this.additionalDetails,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory MyAddress.fromJson(Map<String, dynamic> json) => MyAddress(
        id: json["id"],
        userId: json["user_id"],
        active: json["active"],
        location: json["location"] == null
            ? null
            : LocationData.fromJson(json["location"]),
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        zipcode: json["zipcode"].toString(),
        streetHouseNumber: json["street_house_number"].toString(),
        additionalDetails: json["additional_details"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "active": active,
        "location": location?.toJson(),
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "zipcode": zipcode,
        "street_house_number": streetHouseNumber,
        "additional_details": additionalDetails,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

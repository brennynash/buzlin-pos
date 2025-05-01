import 'dart:convert';
import 'delivery_points_data.dart';
import 'location_data.dart';

class AddressData {
  AddressData({
    String? zipCode,
    String? homeNumber,
    String? phoneNumber,
    String? details,
    String? city,
    DeliveryPointsData? deliveryPrice,
    LocationData? location,
    int? id,
    String? title,
    String? address,
    bool? isDefault,
    bool? active,
  }) {
    _zipCode = zipCode;
    _homeNumber = homeNumber;
    _phoneNumber = phoneNumber;
    _details = details;
    _city = city;
    _deliveryPrice = deliveryPrice;
    _id = id;
    _title = title;
    _address = address;
    _location = location;
    _default = isDefault;
    _active = active;
  }

  AddressData.fromJson(dynamic json) {
    if(json.runtimeType==String){
      json=jsonDecode(json);
    }
    _zipCode = json['zipCode'];
    _homeNumber = json['homeNumber'];
    _phoneNumber = json['phoneNumber'];
    _details = json['details'];
    _city = json['city'];
    _deliveryPrice = json['deliveryPrice'];
    _title = json['title'];
    _address = json['address'];
    _location = json['location'] != null
        ? LocationData.fromJson(json['location'])
        : null;
    _default = json['default'];
    _active = json['active'];
  }
  String? _zipCode;
  String? _homeNumber;
  String? _phoneNumber;
  String? _details;
  String? _city;
  DeliveryPointsData? _deliveryPrice;
  int? _id;
  String? _title;
  String? _address;
  LocationData? _location;
  bool? _default;
  bool? _active;

  AddressData copyWith({
    String? zipCode,
    String? homeNumber,
    String? phoneNumber,
    String? details,
    String? city,
    DeliveryPointsData? deliveryPrice,
    int? id,
    String? title,
    String? address,
    LocationData? location,
    bool? isDefault,
    bool? active,
  }) =>
      AddressData(
        zipCode: zipCode ?? _zipCode,
        homeNumber: homeNumber ?? _homeNumber,
        id: id ?? _id,
        phoneNumber: phoneNumber ?? _phoneNumber,
        details: details ?? _details,
        city: city ?? _city,
        deliveryPrice: deliveryPrice ?? _deliveryPrice,
        title: title ?? _title,
        address: address ?? _address,
        location: location ?? _location,
        isDefault: isDefault ?? _default,
        active: active ?? _active,
      );

  int? get id => _id;

  String? get title => _title;
  String? get zipCode => _zipCode;
  String? get homeNumber => _homeNumber;
  String? get phoneNumber => _phoneNumber;
  String? get details => _details;
  String? get city => _city;
  DeliveryPointsData? get deliveryPointsData => _deliveryPrice;
  String? get address => _address;

  LocationData? get location => _location;

  bool? get isDefault => _default;

  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['zipCode'] = _id;
    map['homeNumber'] = _homeNumber;
    map['phoneNumber'] = _phoneNumber;
    map['details'] = _details;
    map['city'] = _city;
    map['delivery_price'] = _deliveryPrice;
    map['title'] = _title;
    map['address'] = _address;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['default'] = _default;
    map['active'] = _active;
    return map;
  }
}

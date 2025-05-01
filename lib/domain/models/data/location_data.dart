import 'dart:convert';

import 'package:admin_desktop/app_constants.dart';


class LocationData {
  LocationData({double? latitude, double? longitude, String? address}) {
    _latitude = latitude;
    _longitude = longitude;
    _address = address;
  }

  LocationData.fromJson(dynamic json) {
    if(json.runtimeType==String){
      json=jsonDecode(json);
    }
    final lat = json['latitude'];
    final lon = json['longitude'];
    final address = json['address'];
    if (lat != null) {
      _latitude = double.tryParse(lat.toString());
    }
    if (lon != null) {
      _longitude = double.tryParse(lon.toString());
    }
    if (address != null) {
      _address = address.toString();
    }



}

double? _latitude;
double? _longitude;
String? _address;

LocationData copyWith({double? latitude, double? longitude, String? address}) =>
    LocationData(
      latitude: latitude ?? _latitude,
      longitude: longitude ?? _longitude,
      address: address ?? _address,
    );

double? get latitude => _latitude;

double? get longitude => _longitude;

String? get address => _address;

Map<String, dynamic> toJson() {
  final map = <String, dynamic>{};
  map['latitude'] = _latitude ?? AppConstants.demoLatitude;
  map['longitude'] = _longitude ?? AppConstants.demoLongitude;
  map['address'] = _address ?? "Chilanzar";
  return map;
}}

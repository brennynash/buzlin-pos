import '../data/brand_data.dart';
import '../data/meta.dart';

class BrandsPaginateResponse {
  BrandsPaginateResponse({List<Brand>? data, Meta? meta}) {
    _data = data;
    _meta = meta;
  }

  BrandsPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Brand.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<Brand>? _data;
  Meta? _meta;

  BrandsPaginateResponse copyWith({List<Brand>? data, Meta? meta}) =>
      BrandsPaginateResponse(data: data ?? _data, meta: meta ?? _meta);

  List<Brand>? get data => _data;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}

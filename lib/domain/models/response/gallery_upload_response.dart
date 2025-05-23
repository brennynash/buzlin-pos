import '../data/image_data.dart';

class GalleryUploadResponse {
  GalleryUploadResponse({
    String? timestamp,
    bool? status,
    String? message,
    ImageData? imageData,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _imageData = imageData;
  }

  GalleryUploadResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _imageData = json['data'] != null ? ImageData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  ImageData? _imageData;

  GalleryUploadResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    ImageData? imageData,
  }) =>
      GalleryUploadResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        imageData: imageData ?? _imageData,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  ImageData? get imageData => _imageData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    if (_imageData != null) {
      map['data'] = _imageData?.toJson();
    }
    return map;
  }
}


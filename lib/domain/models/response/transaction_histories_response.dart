import '../data/meta.dart';
import '../data/transaction_data.dart';
import '../data/user_data.dart';

class TransactionPaginationResponse {
  TransactionPaginationResponse({
    List<TransactionModel>? data,
    Meta? meta,
  }) {
    _data = data;
    _meta = meta;
  }

  TransactionPaginationResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TransactionModel.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<TransactionModel>? _data;
  Meta? _meta;

  TransactionPaginationResponse copyWith({
    List<TransactionModel>? data,
    Meta? meta,
  }) =>
      TransactionPaginationResponse(
        data: data ?? _data,
        meta: meta ?? _meta,
      );

  List<TransactionModel>? get data => _data;
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

class TransactionModel {
  TransactionModel({
    int? id,
    String? uuid,
    String? walletUuid,
    int? transactionId,
    String? type,
    num? price,
    String? note,
    String? status,
    String? statusDescription,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserData? author,
    UserData? user,
    TransactionData? transactionData
  }) {
    _id = id;
    _uuid = uuid;
    _walletUuid = walletUuid;
    _transactionId = transactionId;
    _type = type;
    _price = price;
    _note = note;
    _status = status;
    _statusDescription = statusDescription;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _author = author;
    _user = user;
    _transactionData = transactionData;
  }

  TransactionModel.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _walletUuid = json['wallet_uuid'];
    _transactionId = json['transaction_id'];
    _type = json['type'];
    _price = json['price'];
    _note = json['note'];
    _status = json['status'];
    _statusDescription = json['status_description'];
    _createdAt = json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"])?.toLocal();
    _updatedAt = json["updated_at"] == null
        ? null
        : DateTime.tryParse(json["updated_at"])?.toLocal();
    _author =
        json['author'] != null ? UserData.fromJson(json['author']) : null;
    _user = json['user'] != null ? UserData.fromJson(json['user']) : null;

    _transactionData = json['transaction'] != null ? TransactionData.fromJson(json['transaction']) : null;
  }

  int? _id;
  String? _uuid;
  String? _walletUuid;
  int? _transactionId;
  String? _type;
  num? _price;
  String? _note;
  String? _status;
  String? _statusDescription;
  DateTime? _createdAt;
  DateTime? _updatedAt;
  UserData? _author;
  UserData? _user;
  TransactionData? _transactionData;

  TransactionModel copyWith({
    int? id,
    String? uuid,
    String? walletUuid,
    int? transactionId,
    String? type,
    num? price,
    String? note,
    String? status,
    String? statusDescription,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserData? author,
    UserData? user,
    TransactionData? transactionData,
  }) =>
      TransactionModel(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        walletUuid: walletUuid ?? _walletUuid,
        transactionId: transactionId ?? _transactionId,
        type: type ?? _type,
        price: price ?? _price,
        note: note ?? _note,
        status: status ?? _status,
        statusDescription: statusDescription ?? _statusDescription,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        author: author ?? _author,
        user: user ?? _user,
        transactionData: transactionData ?? _transactionData,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  String? get walletUuid => _walletUuid;

  int? get transactionId => _transactionId;

  String? get type => _type;

  num? get price => _price;

  String? get note => _note;

  String? get status => _status;

  String? get statusDescription => _statusDescription;

  DateTime? get createdAt => _createdAt;

  DateTime? get updatedAt => _updatedAt;

  UserData? get author => _author;

  UserData? get user => _user;

  TransactionData? get transactionData => _transactionData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['wallet_uuid'] = _walletUuid;
    map['transaction_id'] = _transactionId;
    map['type'] = _type;
    map['price'] = _price;
    map['note'] = _note;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_author != null) {
      map['author'] = _author?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

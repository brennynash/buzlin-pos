

import '../models.dart';

class OrderData {
  int? id;
  int? userId;
  int? deliverymanId;
  int? addressId;
  int? deliveryPriceId;
  int? currencyId;
  num? serviceFee;
  String? status;
  double? totalPrice;
  num? deliveryFee;
  double? totalTax;
  num? originPrice;
  num? totalDiscount;
  int? rate;
  int? type;
  DateTime? deliveryDate;
  String? deliveryType;
  DateTime? createdAt;
  DateTime? updatedAt;
  CouponData? coupon;
  UserData? deliveryman;
  CurrencyData? currency;
  UserData? user;
  List<Stocks>? details;
  String? trackName;
  String? trackId;
  String? trackUrl;
  Transaction? transaction;
  List<PointHistory>? pointHistories;
  List<dynamic>? orderRefunds;
  List<Galleries>? galleries;
  MyAddress? myAddress;
  DeliveryPointsData? deliveryPoint;
  DeliveryPointsData? deliveryPrice;
  String? note;
  ShopData? shop;
  List<NotesData>? notes;
  OrderData({
    this.id,
    this.userId,
    this.deliverymanId,
    this.addressId,
    this.deliveryPriceId,
    this.currencyId,
    this.serviceFee,
    this.status,
    this.totalPrice,
    this.deliveryFee,
    this.totalTax,
    this.originPrice,
    this.rate,
    this.totalDiscount,
    this.deliveryDate,
    this.deliveryType,
    this.createdAt,
    this.updatedAt,
    this.coupon,
    this.deliveryman,
    this.currency,
    this.user,
    this.details,
    this.transaction,
    this.pointHistories,
    this.orderRefunds,
    this.galleries,
    this.myAddress,
    this.deliveryPoint,
    this.note,
    this.deliveryPrice,
    this.shop,
    this.trackName,
    this.trackId,
    this.trackUrl,
    this.notes,
    this.type
  });

  OrderData copyWith({
    int? id,
    int? userId,
    int? deliverymanId,
    int? addressId,
    int? deliveryPriceId,
    int? currencyId,
    num? serviceFee,
    String? status,
    double? totalPrice,
    String? note,
    double? deliveryFee,
    double? totalTax,
    num? originPrice,
    num? totalDiscount,
    int? rate,
    DateTime? deliveryDate,
    String? deliveryType,
    DateTime? createdAt,
    DateTime? updatedAt,
    CouponData? coupon,
    UserData? deliveryman,
    CurrencyData? currency,
    UserData? user,
    List<Stocks>? details,
    Transaction? transaction,
    List<PointHistory>? pointHistories,
    List<dynamic>? orderRefunds,
    List<Galleries>? galleries,
    MyAddress? myAddress,
    DeliveryPointsData? deliveryPoint,
    DeliveryPointsData? deliveryPrice,
    ShopData? shop,
    String? trackName,
    String? trackId,
    String? trackUrl,
    List<NotesData>? notes,
    int? type,
  }) =>
      OrderData(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          deliverymanId: deliverymanId ?? this.deliverymanId,
          addressId: addressId ?? this.addressId,
          note: note ?? this.note,
          deliveryPriceId: deliveryPriceId ?? this.deliveryPriceId,
          currencyId: currencyId ?? this.currencyId,
          serviceFee: serviceFee ?? this.serviceFee,
          totalDiscount: totalDiscount ?? this.totalDiscount,
          status: status ?? this.status,
          totalPrice: totalPrice ?? this.totalPrice,
          deliveryFee: deliveryFee ?? this.deliveryFee,
          totalTax: totalTax ?? this.totalTax,
          originPrice: originPrice ?? this.originPrice,
          rate: rate ?? this.rate,
          deliveryDate: deliveryDate ?? this.deliveryDate,
          deliveryType: deliveryType ?? this.deliveryType,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          coupon: coupon ?? this.coupon,
          deliveryman: deliveryman ?? this.deliveryman,
          currency: currency ?? this.currency,
          user: user ?? this.user,
          details: details ?? this.details,
          transaction: transaction ?? this.transaction,
          pointHistories: pointHistories ?? this.pointHistories,
          orderRefunds: orderRefunds ?? this.orderRefunds,
          galleries: galleries ?? this.galleries,
          myAddress: myAddress ?? this.myAddress,
          deliveryPoint: deliveryPoint ?? this.deliveryPoint,
          deliveryPrice: deliveryPrice ?? this.deliveryPrice,
          shop: shop ?? this.shop,
          trackName: trackName ?? this.trackName,
          trackId: trackId ?? this.trackId,
          trackUrl: trackUrl ?? this.trackUrl,
          notes:  notes ?? this.notes,
          type: type ?? this.type
      );

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
      id: json["id"],
      userId: json["user_id"],
      deliverymanId: json["deliveryman_id"],
      addressId: json["address_id"],
      deliveryPriceId: json["delivery_price_id"],
      currencyId: json["currency_id"],
      serviceFee: json["service_fee"],
      status: json["status"],
      note: json["note"],
      totalDiscount: json["total_discount"],
      totalPrice: json["total_price"]?.toDouble(),
      deliveryFee: json["delivery_fee"],
      totalTax: json["tax"]?.toDouble(),
      originPrice: json["origin_price"],
      rate: json["rate"],
      trackName: json['track_name'],
      trackId: json['track_id'],
      trackUrl: json['track_url'],
      shop: json['shop'] == null ? null : ShopData.fromJson(json['shop']),
      deliveryDate: json["delivery_date"] == null
          ? null
          : DateTime.parse(json["delivery_date"]),
      deliveryType: json["delivery_type"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      coupon: json["coupon"]==null? null:CouponData.fromJson(json["coupon"]),
      deliveryman: json["deliveryman"] == null
          ? null
          : UserData.fromJson(json["deliveryman"]),
      currency: json["currency"] == null
          ? null
          : CurrencyData.fromJson(json["currency"]),
      user: json["user"] == null ? null : UserData.fromJson(json["user"]),
      details: json["details"] == null
          ? []
          : List<Stocks>.from(
          json["details"]!.map((x) => Stocks.fromJson(x))),
      transaction: json["transaction"] == null
          ? null
          : Transaction.fromJson(json["transaction"]),
      pointHistories: json["point_histories"] == null
          ? []
          : List<PointHistory>.from(
          json["point_histories"]!.map((x) => PointHistory.fromJson(x))),
      orderRefunds: json["order_refunds"] == null
          ? []
          : List<dynamic>.from(json["order_refunds"]!.map((x) => x)),
      galleries: json["galleries"] == null
          ? []
          : List<Galleries>.from(json["galleries"]!.map((x) => x)),
      myAddress: json['my_address'] != null
          ? MyAddress.fromJson(json['my_address'])
          : json['address'] != null
          ? MyAddress.fromJson(json['address'])
          : null,
      deliveryPoint: json["delivery_point"] == null
          ? null
          : DeliveryPointsData.fromJson(json["delivery_point"]),
      deliveryPrice: json["delivery_price"] == null
          ? null
          : DeliveryPointsData.fromJson(json["delivery_price"]),
      notes: json["notes"] == null
          ? []
          : List<NotesData>.from(
          json["notes"]!.map((x) => NotesData.fromJson(x))),
      type: json['type']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "deliveryman_id": deliverymanId,
    "address_id": addressId,
    "delivery_price_id": deliveryPriceId,
    "currency_id": currencyId,
    "service_fee": serviceFee,
    "status": status,
    "total_price": totalPrice,
    "delivery_fee": deliveryFee,
    "tax": totalTax,
    "origin_price": originPrice,
    "rate": rate,
    "note": note,
    "total_discount": totalDiscount,
    "delivery_date": deliveryDate?.toIso8601String(),
    "delivery_type": deliveryType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "coupon": coupon,
    "deliveryman": deliveryman?.toJson(),
    "currency": currency?.toJson(),
    "user": user?.toJson(),
    "details": details == null
        ? []
        : List<dynamic>.from(details!.map((x) => x.toJson())),
    "transaction": transaction?.toJson(),
    "point_histories": pointHistories == null
        ? []
        : List<dynamic>.from(pointHistories!.map((x) => x.toJson())),
    "order_refunds": orderRefunds == null
        ? []
        : List<dynamic>.from(orderRefunds!.map((x) => x)),
    "galleries": galleries == null
        ? []
        : List<dynamic>.from(galleries!.map((x) => x)),
    "my_address": myAddress?.toJson(),
    "delivery_point": deliveryPoint?.toJson(),
    "delivery_price": deliveryPrice?.toJson(),
    "shop": shop?.toJson(),
    "track_name": trackName,
    "track_id": trackId,
    "track_url": trackUrl,
    'type': type,
    'notes': notes == null
        ? []
        : List<dynamic>.from(notes!.map((x) => x)),
  };
}

class PointHistory {
  int? id;
  dynamic type;
  double? price;
  dynamic value;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  PointHistory({
    this.id,
    this.type,
    this.price,
    this.value,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  PointHistory copyWith({
    int? id,
    dynamic type,
    double? price,
    dynamic value,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      PointHistory(
        id: id ?? this.id,
        type: type ?? this.type,
        price: price ?? this.price,
        value: value ?? this.value,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PointHistory.fromJson(Map<String, dynamic> json) => PointHistory(
    id: json["id"],
    type: json["type"],
    price: json["price"]?.toDouble(),
    value: json["value"],
    active: json["active"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "price": price,
    "value": value,
    "active": active,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Transaction {
  Transaction({
    int? id,
    int? payableId,
    num? price,
    String? paymentTrxId,
    String? note,
    DateTime? performTime,
    String? status,
    String? statusDescription,
    String? createdAt,
    String? updatedAt,
    PaymentData? paymentSystem,
  }) {
    _id = id;
    _payableId = payableId;
    _price = price;
    _paymentTrxId = paymentTrxId;
    _note = note;
    _performTime = performTime;
    _status = status;
    _statusDescription = statusDescription;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _paymentSystem = paymentSystem;
  }

  Transaction.fromJson(dynamic json) {
    _id = json['id'];
    _payableId = json['payable_id'];
    _price = json['price'];
    _paymentTrxId = json['payment_trx_id'];
    _note = json['note'];
    _performTime = json["perform_time"] == null
        ? null
        : DateTime.parse(json["perform_time"]);
    _status = json['status'];
    _statusDescription = json['status_description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _paymentSystem = json['payment_system'] != null
        ? PaymentData.fromJson(json['payment_system'])
        : null;
  }

  int? _id;
  int? _payableId;
  num? _price;
  String? _paymentTrxId;
  String? _note;
  DateTime? _performTime;
  String? _status;
  String? _statusDescription;
  String? _createdAt;
  String? _updatedAt;
  PaymentData? _paymentSystem;

  Transaction copyWith({
    int? id,
    int? payableId,
    num? price,
    String? paymentTrxId,
    String? note,
    DateTime? performTime,
    String? status,
    String? statusDescription,
    String? createdAt,
    String? updatedAt,
    PaymentData? paymentSystem,
  }) =>
      Transaction(
        id: id ?? _id,
        payableId: payableId ?? _payableId,
        price: price ?? _price,
        paymentTrxId: paymentTrxId ?? _paymentTrxId,
        note: note ?? _note,
        performTime: performTime ?? _performTime,
        status: status ?? _status,
        statusDescription: statusDescription ?? _statusDescription,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        paymentSystem: paymentSystem ?? _paymentSystem,
      );

  int? get id => _id;

  int? get payableId => _payableId;

  num? get price => _price;

  String? get paymentTrxId => _paymentTrxId;

  String? get note => _note;

  DateTime? get performTime => _performTime;

  String? get status => _status;

  String? get statusDescription => _statusDescription;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  PaymentData? get paymentSystem => _paymentSystem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['payable_id'] = _payableId;
    map['price'] = _price;
    map['payment_trx_id'] = _paymentTrxId;
    map['note'] = _note;
    map['perform_time'] = _performTime;
    map['status'] = _status;
    map['status_description'] = _statusDescription;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_paymentSystem != null) {
      map['payment_system'] = _paymentSystem?.toJson();
    }
    return map;
  }
}

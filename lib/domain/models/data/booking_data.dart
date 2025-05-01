import 'activity_data.dart';
import 'form_options_data.dart';
import 'service_data.dart';
import 'transaction_data.dart';
import 'user_data.dart';

class BookingData {
  int? id;
  int? totalPriceByParent;
  String? idsByParent;
  int? shopId;
  int? serviceMasterId;
  int? masterId;
  int? userId;
  int? currencyId;
  int? rate;
  DateTime? startDate;
  DateTime? endDate;
  num? price;
  num? discount;
  num? commissionFee;
  num? couponPrice;
  num? serviceFee;
  num? totalPrice;
  num? giftCartPrice;
  String? status;
  String? type;
  int? gender;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  ServiceData? serviceMaster;
  UserData? master;
  UserData? user;
  dynamic userMemberShip;
  List<ActivityData>? activities;
  List<FormOptionsData>? forms;
  List<String>? notes;
  TransactionData? transaction;

  BookingData({
    this.id,
    this.totalPriceByParent,
    this.idsByParent,
    this.shopId,
    this.giftCartPrice,
    this.serviceMasterId,
    this.masterId,
    this.userId,
    this.currencyId,
    this.couponPrice,
    this.discount,
    this.rate,
    this.startDate,
    this.endDate,
    this.price,
    this.commissionFee,
    this.serviceFee,
    this.totalPrice,
    this.status,
    this.type,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.serviceMaster,
    this.master,
    this.user,
    this.note,
    this.userMemberShip,
    this.activities,
    this.notes,
    this.forms,
    this.transaction,
  });

  BookingData copyWith({
    int? id,
    int? totalPriceByParent,
    String? idsByParent,
    int? shopId,
    int? serviceMasterId,
    int? masterId,
    int? userId,
    int? currencyId,
    int? rate,
    DateTime? startDate,
    DateTime? endDate,
    num? price,
    num? giftCartPrice,
    num? commissionFee,
    num? couponPrice,
    num? discount,
    num? serviceFee,
    num? totalPrice,
    String? status,
    String? type,
    String? note,
    int? gender,
    DateTime? createdAt,
    DateTime? updatedAt,
    ServiceData? serviceMaster,
    UserData? master,
    UserData? user,
    dynamic userMemberShip,
    List<ActivityData>? activities,
    List<FormOptionsData>? forms,
    List<String>? notes,
    TransactionData? transaction,
  }) =>
      BookingData(
        id: id ?? this.id,
        activities: activities ?? this.activities,
        totalPriceByParent: totalPriceByParent ?? this.totalPriceByParent,
        idsByParent: idsByParent ?? this.idsByParent,
        shopId: shopId ?? this.shopId,
        serviceMasterId: serviceMasterId ?? this.serviceMasterId,
        masterId: masterId ?? this.masterId,
        userId: userId ?? this.userId,
        discount: discount ?? this.discount,
        currencyId: currencyId ?? this.currencyId,
        rate: rate ?? this.rate,
        giftCartPrice: giftCartPrice ?? this.giftCartPrice,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        price: price ?? this.price,
        commissionFee: commissionFee ?? this.commissionFee,
        serviceFee: serviceFee ?? this.serviceFee,
        totalPrice: totalPrice ?? this.totalPrice,
        status: status ?? this.status,
        type: type ?? this.type,
        couponPrice: couponPrice ?? this.couponPrice,
        gender: gender ?? this.gender,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        serviceMaster: serviceMaster ?? this.serviceMaster,
        master: master ?? this.master,
        user: user ?? this.user,
        note: note ?? this.note,
        userMemberShip: userMemberShip ?? this.userMemberShip,
        notes: notes ?? this.notes,
        forms: forms ?? this.forms,
        transaction: transaction ?? this.transaction,
      );

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
    id: json["id"],
    totalPriceByParent: json["total_price_by_parent"],
    idsByParent: json["ids_by_parent"],
    shopId: json["shop_id"],
    giftCartPrice: json["gift_cart_price"],
    serviceMasterId: json["service_master_id"],
    masterId: json["master_id"],
    userId: json["user_id"],
    currencyId: json["currency_id"],
    rate: json["rate"],
    discount: json["discount"],
    startDate: json["start_date"] == null
        ? null
        : DateTime.parse(json["start_date"]),
    endDate:
    json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    price: json["price"],
    commissionFee: json["commission_fee"],
    serviceFee: json["service_fee"],
    couponPrice: json['coupon'] != null? json['coupon']["price"]: null,
    totalPrice: json["total_price"],
    status: json["status"],
    type: json["type"],
    gender: json["gender"],
    note: json["note"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    serviceMaster: json["service_master"] == null
        ? null
        : ServiceData.fromJson(json["service_master"]),
    master:
    json["master"] == null ? null : UserData.fromJson(json["master"]),
    user: json["user"] == null ? null : UserData.fromJson(json["user"]),
    transaction: json["transaction"] == null
        ? null
        : TransactionData.fromJson(json["transaction"]),
    activities: json["activities"] == null
        ? null
        : List<ActivityData>.from(
        json["activities"].map((x) => ActivityData.fromJson(x))),
    forms: json["data"] == null
        ? null
        : json["data"]["form"] == null
        ? null
        : List<FormOptionsData>.from(
        List.from(json["data"]["form"]).where((e)=> e!=null).map((x) => FormOptionsData.fromJson(x))),
    userMemberShip: json["user_member_ship"],
    notes: json["notes"] == null
        ? null
        : List<String>.from(json["notes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_price_by_parent": totalPriceByParent,
    "ids_by_parent": idsByParent,
    "shop_id": shopId,
    "service_master_id": serviceMasterId,
    "master_id": masterId,
    "user_id": userId,
    "discount": discount,
    "currency_id": currencyId,
    "rate": rate,
    "coupon_price": couponPrice,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "price": price,
    "commission_fee": commissionFee,
    "service_fee": serviceFee,
    "total_price": totalPrice,
    "status": status,
    "type": type,
    "note": note,
    "gift_cart_price": giftCartPrice,
    "gender": gender,
    "notes": notes,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "service_master": serviceMaster?.toJson(),
    "master": master?.toJson(),
    "user": user?.toJson(),
    "transaction": transaction?.toJson(),
    "user_member_ship": userMemberShip,
    if (activities?.isNotEmpty ?? false)
      "activities": List<dynamic>.from(activities!.map((x) => x.toJson())),
    if (forms?.isNotEmpty ?? false)
      "data": {"forms": List<dynamic>.from(forms!.map((x) => x.toJson()))},
  };
}
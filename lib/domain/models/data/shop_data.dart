import '../models.dart';

class ShopData {
  int? id;
  String? uuid;
  dynamic discountsCount;
  int? userId;
  num? tax;
  int? percentage;
  String? phone;
  bool? open;
  bool? visibility;
  bool? verify;
  String? backgroundImg;
  String? logoImg;
  // int? minAmount;
  String? status;
  String? statusNote;
  int? deliveryType;
  DeliveryTime? deliveryTime;
  String? inviteLink;
  LocationData? latLong;
  int? rCount;
  double? rAvg;
  int? rSum;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? productsCount;
  Translation? translation;
  List<Translation>? translations;
  List<String>? locales;
  Seller? seller;
  SubscriptionData? subscription;
  dynamic bonus;
  List<Discount>? discounts;
  List<dynamic>? shopPayments;
  List<dynamic>? socials;
  List<ShopWorkingDay>? shopWorkingDays;
  List<dynamic>? shopClosedDate;
  List<Location>? locations;

  ShopData({
    this.id,
    this.uuid,
    this.discountsCount,
    this.userId,
    this.tax,
    this.percentage,
    this.phone,
    this.open,
    this.visibility,
    this.verify,
    this.backgroundImg,
    this.logoImg,
    this.deliveryType,
    // this.minAmount,
    this.status,
    this.statusNote,
    this.deliveryTime,
    this.inviteLink,
    this.latLong,
    this.rCount,
    this.rAvg,
    this.rSum,
    this.createdAt,
    this.updatedAt,
    this.productsCount,
    this.translation,
    this.translations,
    this.locales,
    this.seller,
    this.subscription,
    this.bonus,
    this.discounts,
    this.shopPayments,
    this.socials,
    this.shopWorkingDays,
    this.shopClosedDate,
    this.locations,
  });

  ShopData copyWith({
    int? id,
    String? uuid,
    dynamic discountsCount,
    int? userId,
    num? tax,
    int? percentage,
    String? phone,
    bool? open,
    bool? visibility,
    bool? verify,
    String? backgroundImg,
    String? logoImg,
    int? minAmount,
    String? status,
    String? statusNote,
    DeliveryTime? deliveryTime,
    String? inviteLink,
    int? deliveryType,
    LocationData? latLong,
    int? rCount,
    double? rAvg,
    int? rSum,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? productsCount,
    Translation? translation,
    List<Translation>? translations,
    List<String>? locales,
    Seller? seller,
    SubscriptionData? subscription,
    dynamic bonus,
    List<Discount>? discounts,
    List<dynamic>? shopPayments,
    List<dynamic>? socials,
    List<ShopWorkingDay>? shopWorkingDays,
    List<dynamic>? shopClosedDate,
    List<Location>? locations,
  }) =>
      ShopData(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        discountsCount: discountsCount ?? this.discountsCount,
        userId: userId ?? this.userId,
        tax: tax ?? this.tax,
        percentage: percentage ?? this.percentage,
        phone: phone ?? this.phone,
        open: open ?? this.open,
        visibility: visibility ?? this.visibility,
        verify: verify ?? this.verify,
        backgroundImg: backgroundImg ?? this.backgroundImg,
        logoImg: logoImg ?? this.logoImg,
        // minAmount: minAmount ?? this.minAmount,
        status: status ?? this.status,
        statusNote: statusNote ?? this.statusNote,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        inviteLink: inviteLink ?? this.inviteLink,
        latLong: latLong ?? this.latLong,
        rCount: rCount ?? this.rCount,
        rAvg: rAvg ?? this.rAvg,
        rSum: rSum ?? this.rSum,
        deliveryType: deliveryType ?? this.deliveryType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        productsCount: productsCount ?? this.productsCount,
        translation: translation ?? this.translation,
        translations: translations ?? this.translations,
        locales: locales ?? this.locales,
        seller: seller ?? this.seller,
        subscription: subscription ?? this.subscription,
        bonus: bonus ?? this.bonus,
        discounts: discounts ?? this.discounts,
        shopPayments: shopPayments ?? this.shopPayments,
        socials: socials ?? this.socials,
        shopWorkingDays: shopWorkingDays ?? this.shopWorkingDays,
        shopClosedDate: shopClosedDate ?? this.shopClosedDate,
        locations: locations ?? this.locations,
      );

  factory ShopData.fromJson(Map<String, dynamic> json) {
    return ShopData(
    id: json["id"],
    uuid: json["uuid"],
    discountsCount: json["discounts_count"],
    userId: json["user_id"],
    tax: json["tax"],
    percentage: json["percentage"],
    phone: json["phone"],
    open: json["open"],
    visibility: json["visibility"],
    verify: json["verify"],
    backgroundImg: json["background_img"],
    logoImg: json["logo_img"],
    // minAmount: json["min_amount"],
    status: json["status"],
    statusNote: json["status_note"],
    deliveryTime: json["delivery_time"] == null
        ? null
        : DeliveryTime.fromJson(json["delivery_time"]),
    inviteLink: json["invite_link"],
    latLong: json["lat_long"] == null
        ? null
        : LocationData.fromJson(json["lat_long"]),
    rCount: json["r_count"],
    rAvg: json["r_avg"]?.toDouble(),
    rSum: json["r_sum"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
      deliveryType: json["delivery_type"] == null
          ? null
          : json['delivery_type'],
    productsCount: json["products_count"],
    translation: json["translation"] == null
        ? null
        : Translation.fromJson(json["translation"]),
    translations: json["translations"] == null
        ? []
        : List<Translation>.from(
        json["translations"]!.map((x) => Translation.fromJson(x))),
    locales: json["locales"] == null
        ? []
        : List<String>.from(json["locales"]!.map((x) => x)),
    seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
    subscription: json["subscription"] == null
        ? null
        : SubscriptionData?.fromJson(json["subscription"]),
    bonus: json["bonus"],
    discounts: json["discounts"] == null
        ? []
        : List<Discount>.from(
        json["discounts"]!.map((x) => Discount.fromJson(x))),
    shopPayments: json["shop_payments"] == null
        ? []
        : List<dynamic>.from(json["shop_payments"]!.map((x) => x)),
    socials: json["socials"] == null
        ? []
        : List<dynamic>.from(json["socials"]!.map((x) => x)),
    shopWorkingDays: json["shop_working_days"] == null
        ? []
        : List<ShopWorkingDay>.from(json["shop_working_days"]!
        .map((x) => ShopWorkingDay.fromJson(x))),
    shopClosedDate: json["shop_closed_date"] == null
        ? []
        : List<dynamic>.from(json["shop_closed_date"]!.map((x) => x)),
    locations: json["locations"] == null
        ? []
        : List<Location>.from(
        json["locations"]!.map((x) => Location.fromJson(x))),
  );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "discounts_count": discountsCount,
    "user_id": userId,
    "tax": tax,
    "percentage": percentage,
    "phone": phone,
    "open": open,
    "visibility": visibility,
    "verify": verify,
    "background_img": backgroundImg,
    "logo_img": logoImg,
    // "min_amount": minAmount,
    "status": status,
    "status_note": statusNote,
    "delivery_time": deliveryTime?.toJson(),
    "invite_link": inviteLink,
    "lat_long": latLong?.toJson(),
    "r_count": rCount,
    "r_avg": rAvg,
    "r_sum": rSum,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "products_count": productsCount,
    "translation": translation?.toJson(),
    "translations": translations == null
        ? []
        : List<dynamic>.from(translations!.map((x) => x.toJson())),
    "locales":
    locales == null ? [] : List<dynamic>.from(locales!.map((x) => x)),
    "seller": seller?.toJson(),
    "subscription": subscription?.toJson(),
    "bonus": bonus,
    'delivery_type': deliveryType,
    "discounts": discounts == null
        ? []
        : List<dynamic>.from(discounts!.map((x) => x.toJson())),
    "shop_payments": shopPayments == null
        ? []
        : List<dynamic>.from(shopPayments!.map((x) => x)),
    "socials":
    socials == null ? [] : List<dynamic>.from(socials!.map((x) => x)),
    "shop_working_days": shopWorkingDays == null
        ? []
        : List<dynamic>.from(shopWorkingDays!.map((x) => x.toJson())),
    "shop_closed_date": shopClosedDate == null
        ? []
        : List<dynamic>.from(shopClosedDate!.map((x) => x)),
    "locations": locations == null
        ? []
        : List<dynamic>.from(locations!.map((x) => x.toJson())),
  };
}

class DeliveryTime {
  String? to;
  String? from;
  String? type;

  DeliveryTime({
    this.to,
    this.from,
    this.type,
  });

  DeliveryTime copyWith({
    String? to,
    String? from,
    String? type,
  }) =>
      DeliveryTime(
        to: to ?? this.to,
        from: from ?? this.from,
        type: type ?? this.type,
      );

  factory DeliveryTime.fromJson(Map<String, dynamic> json) => DeliveryTime(
    to: json["to"],
    from: json["from"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "to": to,
    "from": from,
    "type": type,
  };
}

class Discount {
  int? id;
  int? shopId;
  DateTime? end;
  bool? active;

  Discount({
    this.id,
    this.shopId,
    this.end,
    this.active,
  });

  Discount copyWith({
    int? id,
    int? shopId,
    DateTime? end,
    bool? active,
  }) =>
      Discount(
        id: id ?? this.id,
        shopId: shopId ?? this.shopId,
        end: end ?? this.end,
        active: active ?? this.active,
      );

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    id: json["id"],
    shopId: json["shop_id"],
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "end":
    "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
    "active": active,
  };
}

class Seller {
  int? id;
  String? uuid;
  String? firstname;
  String? lastname;
  bool? emptyP;
  String? email;
  String? phone;
  DateTime? birthday;
  String? gender;
  bool? active;
  String? img;
  String? myReferral;
  DateTime? emailVerifiedAt;
  DateTime? registeredAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Wallet? wallet;

  Seller({
    this.id,
    this.uuid,
    this.firstname,
    this.lastname,
    this.emptyP,
    this.email,
    this.phone,
    this.birthday,
    this.gender,
    this.active,
    this.img,
    this.myReferral,
    this.emailVerifiedAt,
    this.registeredAt,
    this.createdAt,
    this.updatedAt,
    this.wallet,
  });

  Seller copyWith({
    int? id,
    String? uuid,
    String? firstname,
    String? lastname,
    bool? emptyP,
    String? email,
    String? phone,
    DateTime? birthday,
    String? gender,
    bool? active,
    String? img,
    String? myReferral,
    DateTime? emailVerifiedAt,
    DateTime? registeredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Wallet? wallet,
  }) =>
      Seller(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        emptyP: emptyP ?? this.emptyP,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        active: active ?? this.active,
        img: img ?? this.img,
        myReferral: myReferral ?? this.myReferral,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        registeredAt: registeredAt ?? this.registeredAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        wallet: wallet ?? this.wallet,
      );

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    uuid: json["uuid"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    emptyP: json["empty_p"],
    email: json["email"],
    phone: json["phone"],
    birthday:
    json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
    gender: json["gender"],
    active: json["active"],
    img: json["img"],
    myReferral: json["my_referral"],
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
    registeredAt: json["registered_at"] == null
        ? null
        : DateTime.parse(json["registered_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "firstname": firstname,
    "lastname": lastname,
    "empty_p": emptyP,
    "email": email,
    "phone": phone,
    "birthday": birthday?.toIso8601String(),
    "gender": gender,
    "active": active,
    "img": img,
    "my_referral": myReferral,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "registered_at": registeredAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "wallet": wallet?.toJson(),
  };
}

class ShopPayment {
  int? id;
  int? shopId;
  int? status;
  String? clientId;
  String? secretId;
  PaymentShop? payment;

  ShopPayment({
    this.id,
    this.shopId,
    this.status,
    this.clientId,
    this.secretId,
    this.payment,
  });

  ShopPayment copyWith({
    int? id,
    int? shopId,
    int? status,
    String? clientId,
    String? secretId,
    PaymentShop? payment,
  }) =>
      ShopPayment(
        id: id ?? this.id,
        shopId: shopId ?? this.shopId,
        status: status ?? this.status,
        clientId: clientId ?? this.clientId,
        secretId: secretId ?? this.secretId,
        payment: payment ?? this.payment,
      );

  factory ShopPayment.fromJson(Map<String, dynamic> json) => ShopPayment(
    id: json["id"],
    shopId: json["shop_id"],
    status: json["status"],
    clientId: json["client_id"],
    secretId: json["secret_id"],
    payment: json["payment"] == null
        ? null
        : PaymentShop.fromJson(json["payment"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "status": status,
    "client_id": clientId,
    "secret_id": secretId,
    "payment": payment?.toJson(),
  };
}

class PaymentShop {
  int? id;
  String? tag;
  int? input;
  bool? active;

  PaymentShop({
    this.id,
    this.tag,
    this.input,
    this.active,
  });

  PaymentShop copyWith({
    int? id,
    String? tag,
    int? input,
    bool? active,
  }) =>
      PaymentShop(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        input: input ?? this.input,
        active: active ?? this.active,
      );

  factory PaymentShop.fromJson(Map<String, dynamic> json) => PaymentShop(
    id: json["id"],
    tag: json["tag"],
    input: json["input"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tag": tag,
    "input": input,
    "active": active,
  };
}

class ShopWorkingDay {
  int? id;
  String? day;
  String? from;
  String? to;
  bool? disabled;
  DateTime? createdAt;
  DateTime? updatedAt;

  ShopWorkingDay({
    this.id,
    this.day,
    this.from,
    this.to,
    this.disabled,
    this.createdAt,
    this.updatedAt,
  });

  ShopWorkingDay copyWith({
    int? id,
    String? day,
    String? from,
    String? to,
    bool? disabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ShopWorkingDay(
        id: id ?? this.id,
        day: day ?? this.day,
        from: from ?? this.from,
        to: to ?? this.to,
        disabled: disabled ?? this.disabled,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ShopWorkingDay.fromJson(Map<String, dynamic> json) => ShopWorkingDay(
    id: json["id"],
    day: json["day"],
    from: json["from"],
    to: json["to"],
    disabled: json["disabled"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day": day,
    "from": from,
    "to": to,
    "disabled": disabled,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}


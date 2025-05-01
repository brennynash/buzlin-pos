import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../models.dart';

class OrderBodyData {
  final String? note;
  final int userId;
  final num deliveryFee;
  final int currencyId;
  final num rate;
  final String deliveryType;
  final String? coupon;
  final AddressModel address;
  final String deliveryDate;
  final String deliveryTime;
  final BagData bagData;
  final int? pointId;
  final int? deliveryPriceId;
  final List<Stocks>? stocks;

  OrderBodyData( {
    required this.currencyId,
    required this.rate,
    required this.userId,
    required this.deliveryFee,
    required this.deliveryType,
    this.coupon,
    required this.address,
    required this.deliveryDate,
    required this.deliveryTime,
    this.note,
    required this.bagData,
    required this.pointId,
    required this.stocks,
    this.deliveryPriceId,
  });

  Map toJson() {
    Map newMap = {};

    List<BagProductData> listOfProduct = [];
    for (int i = 0; i < (stocks?.length ?? 0); i++) {
      listOfProduct.add(BagProductData(
          stockId: stocks?[i].id,
          quantity: stocks?[i].quantity,
          bonus: stocks?[i].bonus ?? false

      ));
      // for (int j = 0; j < (bagData.bagProducts?[i].carts?.length ?? 0); j++) {
      //   listOfProduct.add(BagProductData(
      //       stockId: bagData.bagProducts?[i].carts?[j].stockId,
      //       quantity: bagData.bagProducts?[i].carts?[j].quantity,
      //       parentId: bagData.bagProducts?[i].carts?[j].parentId,
      //       bonus: stocks?[i].bonus ?? false
      //   ));
      // }
    }
    newMap["currency_id"] = currencyId;
    newMap["delivery_point_id"] = pointId;
    newMap["shop_id"] =  LocalStorage.getUser()?.shop?.id ?? 0;
    if (userId != 0) newMap["user_id"] = userId;
    if (deliveryFee != 0) newMap["delivery_fee"] = deliveryFee;
    newMap["delivery_type"] = deliveryType.toLowerCase();
    if (coupon != null && (coupon?.isNotEmpty ?? false)) {
      newMap["coupon"] =  {"${LocalStorage.getShop()?.id ?? ''}": coupon};
    }
    if (note != null && (note?.isNotEmpty ?? false)) newMap["note"] = note;
    newMap["address"] = address.toJson();
    newMap["delivery_date"] = deliveryDate;
    newMap["delivery_time"] = deliveryTime;
    newMap['data'] = [
      {
        'shop_id': LocalStorage.getShop()?.id,
        'products': listOfProduct,
      }
    ];
    newMap['delivery_price_id'] = deliveryPriceId;
    return newMap;
  }
}

class AddressModel {
  final LocationData? location;
  final String? address;
  final String? zipCode;
  final String? homeNumber;
  final String? phoneNumber;
  final String? details;


  AddressModel(  {
    this.address,
    this.homeNumber,
    this.zipCode,
    this.details,
    this.phoneNumber,
    this.location,
  });

  Map toJson() {
    return {
      'location': location,
      "address": address,
      "zip_code": zipCode,
      "home_number": homeNumber,
      "phone_number": phoneNumber,
      "details": details
    };
  }

  factory AddressModel.fromJson(Map? data) {
    return AddressModel(
      location: data?['location'],
      address: data?["address"],
      phoneNumber: data?["phone_number"],
      zipCode: data?["zip_code"],
      homeNumber: data?["home_number"],
      details: data?["details"],
    );
  }
}

class ProductOrder {
  final int stockId;
  final num price;
  final int quantity;
  final num tax;
  final num discount;
  final num totalPrice;

  ProductOrder({
    required this.stockId,
    required this.price,
    required this.quantity,
    required this.tax,
    required this.discount,
    required this.totalPrice,
  });

  @override
  String toString() {
    return "{\"stock_id\":$stockId, \"price\":$price, \"qty\":$quantity, \"tax\":$tax, \"discount\":$discount, \"total_price\":$totalPrice}";
  }
}

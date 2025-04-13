import 'package:admin_desktop/infrastructure/services/utils.dart';

import '../../domain/handlers/api_result.dart';
import '../../domain/models/models.dart';
import '../../domain/models/response/orders_paginate_response.dart';
import '../../domain/models/response/single_order_response.dart';

abstract class OrdersRepository {
  Future<ApiResult<CreateOrderResponse>> createOrder(
      OrderBodyData orderBody,
      );

  Future<ApiResult<OrdersPaginateResponse>> getOrders({
    OrderStatus? status,
    int? page,
    DateTime? from,
    DateTime? to,
    String? search,
  });

  Future<ApiResult<dynamic>> updateOrderStatus({
    required OrderStatus status,
    int? orderId,
  });

  Future<ApiResult<dynamic>> updateOrderStatusKitchen({
    required OrderStatus status,
    int? orderId,
  });

  Future<ApiResult<SingleOrderResponse>> getOrderDetails({int? orderId});

  Future<ApiResult<SingleOrderResponse>> getOrderDetailsKitchen({int? orderId});

  Future<ApiResult<dynamic>> setDeliverMan({required int orderId,required int deliverymanId});

  Future<ApiResult<dynamic>> deleteOrder({required int orderId});

  Future<ApiResult<dynamic>> updateOrderStockId(
      {
        required int stockId,
        required int quantity,
        required int replaceStockId,
        required int replaceQuantity,
        required String replaceNote,
        required OrderData? order,
        required int? currencyId,
        required String? phone,
      }
    );

  Future<ApiResult> updateOrderTracking({
    required int? orderId,
    required String name,
    required String id,
    String? url,
  });

  Future<ApiResult> updateStatusNote({
    required OrderStatus status,
    required List<Notes> notes,
    int? orderId,
  });

}

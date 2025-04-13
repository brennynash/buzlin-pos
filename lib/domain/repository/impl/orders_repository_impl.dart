import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/models/response/order_status_response.dart';
import 'package:admin_desktop/domain/models/response/orders_paginate_response.dart';
import 'package:admin_desktop/domain/models/response/single_order_response.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../repository.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  @override
  Future<ApiResult<CreateOrderResponse>> createOrder(
      OrderBodyData orderBody,
      ) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      debugPrint('order create request: ${jsonEncode(orderBody.toJson())}');
      final response = await client.post(
        '/api/v1/dashboard/seller/orders',
        data: orderBody.toJson(),
      );
      return ApiResult.success(
        data: CreateOrderResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> order create failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<OrdersPaginateResponse>> getOrders({
    OrderStatus? status,
    int? page,
    DateTime? from,
    DateTime? to,
    String? search,
  }) async {
    String? statusText;
    switch (status) {
      case OrderStatus.accepted:
        statusText = 'accepted';
        break;
      case OrderStatus.ready:
        statusText = 'ready';
        break;
      case OrderStatus.onAWay:
        statusText = 'on_a_way';
        break;
      case OrderStatus.delivered:
        statusText = 'delivered';
        break;
      case OrderStatus.canceled:
        statusText = 'canceled';
        break;
      case OrderStatus.newOrder:
        statusText = 'new';
        break;
      default:
        statusText = null;
        break;
    }
    final data = {
      if (page != null) 'page': page,
      if (statusText != null) 'status': statusText,
      if (from != null)
        "date_from": from.toString().substring(0, from.toString().indexOf(" ")),
      if (to != null)
        "date_to": to.toString().substring(0, to.toString().indexOf(" ")),
      if (search != null) 'search': search,
      'perPage': to == null ? 7 : 15,
      if (LocalStorage.getUser()?.role == TrKeys.waiter)
        'empty-waiter': 1,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/orders/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrdersPaginateResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get order $status failure: $e,$s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> updateOrderStatus({
    required OrderStatus status,
    int? orderId,
  }) async {
    String? statusText;
    switch (status) {
      case OrderStatus.newOrder:
        statusText = 'new';
        break;
      case OrderStatus.accepted:
        statusText = 'accepted';
        break;
      case OrderStatus.ready:
        statusText = 'ready';
        break;
      case OrderStatus.onAWay:
        statusText = 'on_a_way';
        break;
      case OrderStatus.delivered:
        statusText = 'delivered';
        break;
      case OrderStatus.canceled:
        statusText = 'canceled';
        break;
    }

    final data = {'status': statusText};
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/seller/order/$orderId/status',
        data: data,
      );
      return const ApiResult.success(
        data: null,
      );
    } catch (e) {
      debugPrint('==> update order status failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> updateOrderStatusKitchen({
    required OrderStatus status,
    int? orderId,
  }) async {
    String? statusText;
    switch (status) {
      case OrderStatus.newOrder:
        statusText = 'new';
        break;
      case OrderStatus.accepted:
        statusText = 'accepted';
        break;
      case OrderStatus.ready:
        statusText = 'ready';
        break;
      case OrderStatus.onAWay:
        statusText = 'on_a_way';
        break;
      case OrderStatus.delivered:
        statusText = 'delivered';
        break;
      case OrderStatus.canceled:
        statusText = 'canceled';
        break;
    }

    final data = {'status': statusText};
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/cook/orders/$orderId/status/update',
        data: data,
      );
      return const ApiResult.success(
        data: null,
      );
    } catch (e) {
      debugPrint('==> update order status failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<SingleOrderResponse>> getOrderDetails({int? orderId}) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final data = {
        'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      };
      final response = await client.get(
          '/api/v1/dashboard/seller/orders/$orderId',
          queryParameters: data);
      return ApiResult.success(
        data: SingleOrderResponse.fromJson(response.data),
      );
    } catch (e,s) {
      debugPrint('==> get order details failure: $e, $s');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<SingleOrderResponse>> getOrderDetailsKitchen(
      {int? orderId}) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final data = {
        'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      };
      final response = await client
          .get('/api/v1/dashboard/cook/orders/$orderId', queryParameters: data);
      return ApiResult.success(
        data: SingleOrderResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get order details failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<dynamic>> setDeliverMan(
      {required int orderId, required int deliverymanId}) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final data = {
        'deliveryman': deliverymanId,
      };
      final response = await client.post(
          '/api/v1/dashboard/seller/order/$orderId/deliveryman',
          data: data);
      return ApiResult.success(
        data: SingleOrderResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get order details failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult> deleteOrder({required int orderId}) async {
    final data = {'ids[0]': orderId};
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/orders/delete',
        queryParameters: data,
      );
      return const ApiResult.success(
        data: null,
      );
    } catch (e) {
      debugPrint('==> update order status failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult> updateOrderStockId({
    required int stockId,
    required int quantity,
    required int replaceStockId,
    required int replaceQuantity,
    required String replaceNote,
    required OrderData? order,
    required int? currencyId,
    required String? phone,
  }) async {
    final data = {
      "products": [
        {
          "id": stockId,
          "quantity": quantity,
          "replace_stock_id": replaceStockId,
          "replace_quantity": replaceQuantity,
          "replace_note": replaceNote,
      "stock_id":stockId,
        }
      ],
      "currency_id": currencyId,
      if (phone != null) "phone": phone,
      "delivery_type": order?.deliveryType,
      if (order?.myAddress != null) "address": order?.myAddress?.toJson(),
      if (order?.deliveryPoint != null)
        "delivery_point_id": order?.deliveryPoint?.id,
    };
    debugPrint("replace order body: ${jsonEncode(data)}");
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.put(
        '/api/v1/dashboard/seller/orders/${order?.id}',
        data: data,
      );
      return ApiResult.success(data: res);
    } catch (e) {
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult> updateOrderTracking({
    required int? orderId,
    required String name,
    required String id,
    String? url,
  }) async {
    final data = {
      'track_name': name,
      'track_id': id,
      if (url != null) 'track_url': url,
    };
    debugPrint('==> update order tracking request: ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/order/$orderId/tracking',
        queryParameters: data,
      );
      return ApiResult.success(
        data: response.data,
      );
    } catch (e, s) {
      debugPrint('==> update order tracking failure: $e,$s');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult> updateStatusNote({
    required OrderStatus status,
    required List<Notes> notes,
    int? orderId,
  }) async {
    String? statusText;
    switch (status) {
      case OrderStatus.newOrder:
        statusText = 'new';
        break;
      case OrderStatus.accepted:
        statusText = 'accepted';
        break;
      case OrderStatus.ready:
        statusText = 'ready';
        break;
      case OrderStatus.onAWay:
        statusText = 'on_a_way';
        break;
      case OrderStatus.delivered:
        statusText = 'delivered';
        break;
      case OrderStatus.canceled:
        statusText = 'canceled';
        break;
    }
    final data = {
      'status': statusText,
      "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
    };
    debugPrint('===> update order status request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/order/$orderId/status',
        data: data,
      );
      return ApiResult.success(
        data: OrderStatusResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update order status failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/constants/constants.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../service_repository.dart';


class ServiceRepositoryImpl implements ServiceFacade {
  @override
  Future<ApiResult<ServiceResponse>> createService({
    required num price,
    required int pause,
    required int interval,
    required String title,
    required int categoryId,
    required List<String> images,
    String? description,
    required String type,
    required String gender,
  }) async {
    final data = {
      'title': {LocalStorage.getSystemLanguage()?.locale ?? 'en': title},
      if (description?.isNotEmpty ?? false)
        'description': {
          LocalStorage.getSystemLanguage()?.locale ?? 'en': description
        },
      'images': images,
      'price': price,
      'interval': interval,
      'type': type,
      'pause': pause,
      'category_id': categoryId,
      'gender': DropDownValues.genderList.indexOf(gender)+1,
    };
    debugPrint('===> create service request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/seller/services',
        data: data,
      );
      return ApiResult.success(data: ServiceResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> create service failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<ServiceResponse>> updateService({
    required int? id,
    required num price,
    required int pause,
    required int interval,
    required String title,
    required int categoryId,
    required List<String> images,
    String? description,
    required String type,
    required String gender,
  }) async {
    final data = {
      'title': {LocalStorage.getSystemLanguage()?.locale ?? 'en': title},
      if (description?.isNotEmpty ?? false)
        'description': {
          LocalStorage.getSystemLanguage()?.locale ?? 'en': description
        },
      'images': images,
      'price': price,
      'interval': interval,
      'type': type,
      'gender': DropDownValues.genderList.indexOf(gender)+1,
      'pause': pause,
      'category_id': categoryId,
    };
    debugPrint('===> update service request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.put(
        '/api/v1/dashboard/seller/services/$id',
        data: data,
      );
      return ApiResult.success(data: ServiceResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> update service failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<ServicePaginateResponse>> getServices({
    int? page,
    int? categoryId,
    num? priceFrom,
    num? priceTo,
    int? intervalFrom,
    int? intervalTo,
    int? pauseFrom,
    int? pauseTo,
    String? query,
    String? status,
    bool? active,
  }) async {
    final data = {
      if (page != null) 'page': page,
      if (query != null) 'search': query,
      if (status != null) 'status': status,
      if (categoryId != null) 'category_id': categoryId,
      if (priceFrom != null) 'price_from': priceFrom,
      if (priceTo != null) 'price_to': priceTo,
      if (intervalFrom != null) 'interval_from': priceFrom,
      if (intervalTo != null) 'interval_to': priceTo,
      if (pauseFrom != null) 'pause_from': pauseFrom,
      if (pauseTo != null) 'pause_to': pauseTo,
      if (active != null) 'active': active ? 1 : 0,
      'perPage': 10,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/services',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ServicePaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get services paginate failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<ServiceResponse>> fetchSingleService(int? id) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/services/$id',
      );
      return ApiResult.success(
        data: ServiceResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> fetch single services failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult> deleteService(int? id) async {
    final data = {
      'ids': [id]
    };
    debugPrint('====> delete service request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/services',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete product failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }
}

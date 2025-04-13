import 'dart:convert';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/response/brands_paginate_response.dart';
import 'package:admin_desktop/domain/models/response/single_brand_response.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../repository.dart';

class BrandsRepositoryImpl extends BrandsRepository {
  @override
  Future<ApiResult<BrandsPaginateResponse>> searchBrands(String? query) async {
    final data = {'search': query};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/brands/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: BrandsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search brands failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<BrandsPaginateResponse>> getBrands({
    bool isActive = true,
    int page = 1,
  }) async {
    final data = {
      'perPage': 10,
      'page': page,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: !isActive);
      final response = await client.get(
        isActive
            ? '/api/v1/rest/brands/paginate'
            : '/api/v1/dashboard/seller/brands/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: BrandsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get all brands failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteBrand(int? brandId) async {
    final data = {
      'ids': [brandId]
    };
    debugPrint('====> delete brand request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/brands/delete',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete brand failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<SingleBrandResponse>> addBrand({
    required String title,
    required bool active,
    String? image,
  }) async {
    final data = {'title': title, 'active': active ? 1 : 0, 'images[0]': image};
    debugPrint('====> add brand request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/seller/brands',
        queryParameters: data,
      );
      return ApiResult.success(data: SingleBrandResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> add brand failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<SingleBrandResponse>> updateBrand({
    required String title,
    required bool active,
    required int id,
    String? image,
  }) async {
    final data = {
      'title': title,
      'active': active ? 1 : 0,
      if (image != null) 'images': [image]
    };
    debugPrint('====> update brand request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.put(
        '/api/v1/dashboard/seller/brands/$id',
        queryParameters: data,
      );
      return ApiResult.success(data: SingleBrandResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> update brand failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}

import 'dart:convert';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../repository.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  @override
  Future<ApiResult<CategoriesPaginateResponse>> searchCategories(
    String? query,
  ) async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'perPage': 100,
      'type': 'main',
      "has_products": 1,
      "product_shop_id": LocalStorage.getUser()?.shop?.id ?? 0
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        LocalStorage.getUser()?.role == TrKeys.seller
            ? '/api/v1/dashboard/seller/categories/paginate'
            : '/api/v1/rest/categories/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get categories failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<UnitsPaginateResponse>> getUnits() async {
    final data = {'lang': LocalStorage.getLanguage()?.locale ?? 'en'};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/units/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: UnitsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get units paginate failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<void>> createCategory({
    required Map<String, List<String>> titlesAndDescriptions,
    required bool active,
    String? image,
    String? type,
    int? parentId,
  }) async {
    final data = {
      'title': {
        for (String locale in titlesAndDescriptions.keys)
          if (titlesAndDescriptions[locale]?.first != null)
            locale: titlesAndDescriptions[locale]?.first ?? ""
      },
      if (!titlesAndDescriptions.values.any((e)=>e.last.isEmpty))
      'description': {
        for (String locale in titlesAndDescriptions.keys)
          if (titlesAndDescriptions[locale]?.last != null)
          locale: titlesAndDescriptions[locale]?.last ?? ""
      },
      if (parentId != null) 'parent_id': parentId,
      'active': 1,
      'type': type ?? 'main',
    };
    debugPrint(
        '===> create category request ${jsonEncode(titlesAndDescriptions)}');
    debugPrint('===> create category request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.post(
        '/api/v1/dashboard/seller/categories',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> create category failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<void>> updateCategory({
    required Map<String, List<String>> titlesAndDescriptions,
    required bool active,
    required String id,
    String? image,
    String? type,
    int? parentId,
  }) async {
    final data = {
      'title': {
        for (int i = 0; i < titlesAndDescriptions.keys.length; i++)
          titlesAndDescriptions.keys.toList()[i]:
              titlesAndDescriptions[titlesAndDescriptions.keys.toList()[i]]
                      ?.first ??
                  ""
      },
      'description': {
        for (String locale in titlesAndDescriptions.keys)
          locale: titlesAndDescriptions[locale]?.last ?? ""
      },
      if (parentId != null) 'parent_id': parentId,
      'type': type ?? 'main',
      if (image != null) 'images[0]': image
    };
    debugPrint('====> update category request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.put(
        '/api/v1/dashboard/seller/categories/$id',
        queryParameters: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> update category failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<CategoriesPaginateResponse>> getCategories({
    int? page,
    String? query,
    CategoryStatus? status,
    bool? active,
    String? type,
  }) async {
    final data = {
      if (page != null) 'page': page,
      if (query != null) 'search': query,
      if (status != null) 'status': status.name,
      'perPage': 10,
      if (active ?? false) 'active': 1,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'type': type ?? 'main',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/categories/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get categories paginate failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<void>> deleteCategory(int? categoryId) async {
    final data = {
      'ids': [categoryId]
    };
    debugPrint('====> delete category request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/categories/delete',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete category failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<SingleCategoryResponse>> fetchSingleCategory(
      String? uuid) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/categories/$uuid',
      );
      return ApiResult.success(
        data: SingleCategoryResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> fetch single category failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }
}

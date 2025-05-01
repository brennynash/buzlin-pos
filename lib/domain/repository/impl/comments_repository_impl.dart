import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../repository.dart';

class CommentsRepositoryImpl extends CommentsRepository {
  @override
  Future<ApiResult<CommentsPaginateResponse>> getProductComments({
    int? page,
  }) async {
    final data = {
      'page': page,
      'perPage': 12,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'type': 'product'
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/reviews/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CommentsPaginateResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get product comments failure: $e,$s');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<ShopCommentsPaginateResponse>> getShopComments(
      {int? page}) async {
    final data = {
      'page': page,
      'perPage': 12,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/shops/${LocalStorage.getUser()?.shop?.id}/reviews',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopCommentsPaginateResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get shop comments failure: $e,$s');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }
}

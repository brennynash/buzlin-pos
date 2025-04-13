import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../../di/dependency_manager.dart';
import '../../handlers/handlers.dart';
import '../../models/models.dart';
import '../form_option_repository.dart';

class FormOptionRepositoryImpl implements FormOptionRepository {
  @override
  Future<ApiResult<SingleFormOptionsResponse>> getFormOptionsDetails(
      int? id) async {
    final data = {
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/form-options/$id',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SingleFormOptionsResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get form options details failure: $e,$s');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<FormOptionsResponse>> getFormOptions({int? page}) async {
    final data = {
      'page': page,
      'perPage': 10,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/form-options',
        queryParameters: data,
      );
      return ApiResult.success(
        data: FormOptionsResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get all form-options failure: $e,$s');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleFormOptionsResponse>> addForm({
    required String title,
    required bool required,
    required bool active,
    required String description,
    required List<QuestionData> questions,
  }) async {
    final data = {
      'title': {LocalStorage.getLanguage()?.locale ?? 'en': title},
      if (description.isNotEmpty)
        'description': {
          LocalStorage.getLanguage()?.locale ?? 'en': description
        },
      'required': required ? 1 : 0,
      'active': active ? 1 : 0,
      'data': questions.map((e) => e.toJson()).toList(),
    };
    debugPrint('====> create form-options request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/seller/form-options',
        data: data,
      );
      return ApiResult.success(
          data: SingleFormOptionsResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> create form-options failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleFormOptionsResponse>> updateForm({
    required int? id,
    required bool required,
    required bool active,
    required String title,
    required String description,
    required List<QuestionData> questions,
  }) async {
    final data = {
      'title': {LocalStorage.getLanguage()?.locale ?? 'en': title},
      if (description.isNotEmpty)
        'description': {
          LocalStorage.getLanguage()?.locale ?? 'en': description
        },
      'required': required ? 1 : 0,
      'active': active ? 1 : 0,
      'data': questions.map((e) => e.toJson()).toList(),
    };
    debugPrint('====> update form-options request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.put(
        '/api/v1/dashboard/seller/form-options/$id',
        data: data,
      );
      return ApiResult.success(
          data: SingleFormOptionsResponse.fromJson(res.data));
    } catch (e) {
      debugPrint('==> update form-options failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }

  @override
  Future<ApiResult<void>> deleteFormOption(int? id) async {
    final data = {
      'ids': [id]
    };
    debugPrint('====> delete form-options request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/form-options/delete',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete form-options failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
        status: NetworkExceptions.getDioStatus(e),
      );
    }
  }
}

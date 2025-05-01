import 'dart:convert';
import 'package:admin_desktop/domain/models/data/help_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/models/response/gallery_upload_response.dart';
import 'package:admin_desktop/domain/models/response/income_cart_response.dart';
import 'package:admin_desktop/domain/models/response/income_statistic_response.dart';
import 'package:admin_desktop/domain/models/response/mobile_translations_response.dart';
import 'package:admin_desktop/domain/models/response/sale_history_response.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../repository.dart';

class SettingsSettingsRepositoryImpl extends SettingsRepository {
  @override
  Future<ApiResult<GlobalSettingsResponse>> getGlobalSettings() async {
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get('/api/v1/rest/settings');
      debugPrint('==> get global settings response: $response');
      return ApiResult.success(
        data: GlobalSettingsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get settings failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e), status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<TranslationsResponse>> getTranslations({
    String? lang,
    int? id,
  }) async {
    final data = {'lang': lang ?? LocalStorage.getLanguage()?.locale ?? 'en'};
    try {
      final dioHttp = HttpService();
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/translations/paginate',
        queryParameters: data,
      );
      await LocalStorage.setTranslations(
        TranslationsResponse.fromJson(response.data).data,
      );
      LocalStorage.setOtherTranslations(
        translations: TranslationsResponse.fromJson(response.data).data,
        key: (id ?? LocalStorage.getLanguage()?.id).toString(),
      );
      return ApiResult.success(
        data: TranslationsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get translations failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e), status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SaleHistoryResponse>> getSaleHistory(
      int type, int page) async {
    final data = {
      'type': type == 0
          ? "deliveryman"
          : type == 1
              ? "today"
              : "history",
      "perPage": 10,
      "page": page,
      "sort": "desc",
      "column": "created_at"
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.getUser()?.role}/sales-history',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SaleHistoryResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get sale history failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e), status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<SaleCartResponse>> getSaleCart() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.getUser()?.role}/sales-cards',
      );
      return ApiResult.success(
        data: SaleCartResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get sale cart failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e), status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<IncomeStatisticResponse>> getIncomeStatistic(
      {required String type,
      required DateTime? from,
      required DateTime? to}) async {
    try {
      final data = {
        "type": type,
        "date_from": from.toString().substring(0, from.toString().indexOf(" ")),
        "date_to": to.toString().substring(0, to.toString().indexOf(" "))
      };
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
          '/api/v1/dashboard/${LocalStorage.getUser()?.role}/sales-statistic',
          queryParameters: data);
      return ApiResult.success(
        data: IncomeStatisticResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get sale statistic failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e), status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<IncomeCartResponse>> getIncomeCart(
      {required String type,
      required DateTime? from,
      required DateTime? to}) async {
    try {
      final data = {
        "type": type,
        "date_from": from.toString().substring(0, from.toString().indexOf(" ")),
        "date_to": to.toString().substring(0, to.toString().indexOf(" "))
      };
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
          '/api/v1/dashboard/${LocalStorage.getUser()?.role}/sales-main-cards',
          queryParameters: data);
      return ApiResult.success(
        data: IncomeCartResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get sale cart failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e), status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<List<IncomeChartResponse>>> getIncomeChart(
      {required String type,
      required DateTime? from,
      required DateTime? to}) async {
    try {
      final data = {
        "type": type == TrKeys.week ? TrKeys.month : type,
        "date_from": from.toString().substring(0, from.toString().indexOf(" ")),
        "date_to": to.toString().substring(0, to.toString().indexOf(" "))
      };
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
          '/api/v1/dashboard/${LocalStorage.getUser()?.role}/sales-chart',
          queryParameters: data);
      return ApiResult.success(
        data: incomeChartResponseFromJson(jsonEncode(response.data)),
      );
    } catch (e) {
      debugPrint('==> get sale cart failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e), status: NetworkExceptions.getDioStatus(e));
    }
  }

  @override
  Future<ApiResult<GalleryUploadResponse>> uploadImage(
    String filePath,
    UploadType uploadType,
  ) async {
    String type = '';
    switch (uploadType) {
      case UploadType.shopsLogo:
        type = 'shops/logo';
        break;
      case UploadType.shopsBack:
        type = 'shops/background';
        break;
      default:
        type = uploadType.name;
        break;
    }
    final data = FormData.fromMap(
      {
        'image': await MultipartFile.fromFile(filePath),
        'type': type,
      },
    );
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/galleries',
        data: data,
      );
      return ApiResult.success(
        data: GalleryUploadResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> upload image failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<LanguagesResponse>> getLanguages() async {
    try {
      final dioHttp = HttpService();
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get('/api/v1/rest/languages/active');
      if (LocalStorage.getLanguage() == null ||
          !(LanguagesResponse.fromJson(response.data)
                  .data
                  ?.map((e) => e.id)
                  .contains(LocalStorage.getLanguage()?.id) ??
              true)) {
        LanguagesResponse.fromJson(response.data).data?.forEach((element) {
          if (element.isDefault ?? false) {
            LocalStorage.setLanguageData(element);
            LocalStorage.setLangLtr(element.backward);
          }
        });
      }
      return ApiResult.success(
        data: LanguagesResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get languages failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e), status: NetworkExceptions.getDioStatus(e));
    }
  }
  @override
  Future<ApiResult<MobileTranslationsResponse>> getMobileTranslations(
      {String? lang}) async {
    final data = {'lang': lang ?? LocalStorage.getLanguage()?.locale ?? 'en'};
    try {
      final dioHttp = HttpService();
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/translations/paginate',
        queryParameters: data,
      );
      await LocalStorage.setTranslations(
          MobileTranslationsResponse.fromJson(response.data).data);
      return  ApiResult.success(data: MobileTranslationsResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> get translations failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e), status: NetworkExceptions.getDioStatus(e));
    }
  }
  @override
  Future<ApiResult<MultiGalleryUploadResponse>> uploadMultiImage(
      List<String?> filePaths,
      UploadType uploadType,
      ) async {
    String type = '';
    switch (uploadType) {
      case UploadType.shopsLogo:
        type = 'shops/logo';
        break;
      case UploadType.shopsBack:
        type = 'shops/background';
        break;
      default:
        type = uploadType.name;
        break;
    }
    final data = FormData.fromMap(
      {
        for (int i = 0; i < filePaths.length; i++)
          if (filePaths[i] != null)
            'images[$i]': await MultipartFile.fromFile(filePaths[i]!),
        'type': type,
      },
    );
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/galleries/store-many',
        data: data,
      );
      return ApiResult.success(
        data: MultiGalleryUploadResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> upload multi image failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          status: NetworkExceptions.getDioStatus(e));
    }
  }
  @override
  Future<ApiResult<HelpModel>> getFaq() async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get('/api/v1/rest/faqs/paginate');
      return ApiResult.success(
        data: HelpModel.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get faq failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }
}

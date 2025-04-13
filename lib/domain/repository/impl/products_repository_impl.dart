import 'dart:convert';
import 'package:admin_desktop/domain/di/dependency_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:admin_desktop/domain/handlers/handlers.dart';
import 'package:admin_desktop/domain/models/models.dart';
import 'package:admin_desktop/domain/models/response/product_calculate_response.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import '../repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  @override
  Future<ApiResult<ProductCalculateResponse>> getAllCalculations(
      BagData bag,
      String type, {
        int? bagIndex,
        int? deliveryPriceId,
      }) async {
    UserData? userData = LocalStorage.getUser();
    final data = {
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale,
      'shop_id': userData?.shop?.id ?? 0,
      if (bag.pickupAddress?.deliveryPoint?.id != null && type != 'delivery')
        'delivery_type': type.isEmpty ? TrKeys.delivery : type,
      if (deliveryPriceId != null && type != 'point')
        'delivery_type': type.isEmpty ? TrKeys.delivery : type,
      if (bag.coupon?.name != null) "coupon[${LocalStorage.getUser()?.shop?.id}]": bag.coupon?.name,
      if (bag.pickupAddress?.deliveryPoint?.id != null && type != 'delivery')
        'delivery_point_id': bag.pickupAddress?.deliveryPoint?.id,
      if (deliveryPriceId != null) 'delivery_price_id': deliveryPriceId,
    };
    for (int i = 0; i < (bag.bagProducts?.length ?? 0); i++) {
      data['products[$i][stock_id]'] = bag.bagProducts?[i].stockId;
      data['products[$i][quantity]'] = bag.bagProducts?[i].quantity;
      for (int j = 0; j < (bag.bagProducts?[i].carts?.length ?? 0); j++) {
        data['products[$i$j][stock_id]'] =
            bag.bagProducts?[i].carts?[j].stockId;
        data['products[$i$j][quantity]'] =
            bag.bagProducts?[i].carts?[j].quantity;
        data['products[$i$j][parent_id]'] =
            bag.bagProducts?[i].carts?[j].parentId;
      }
    }

    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/order/products/calculate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ProductCalculateResponse.fromJson(response.data),
      );
    } catch (e, s) {
      AppHelpers.stockHandler(
        e,
        bagIndex: bagIndex ?? 0,
        success: () {
          getAllCalculations(bag, type, bagIndex: bagIndex);
        },
      );
      debugPrint('==> get order calculate failure: $e,$s');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          );
    }
  }
  @override
  Future<ApiResult<Digital>> updateDigitalFile({
    required String filePath,
    required int? productId,
  }) async {
    final data = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'product_id': productId,
      'active': 1,
    });

    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/admin/digital-files',
        data: data,
      );
      return ApiResult.success(data: Digital.fromJson(res.data['data']));
    } catch (e) {
      debugPrint('==> update digital failure: $e');
      return ApiResult.failure(
          error: AppHelpers.errorHandler(e),
          );
    }
  }

  @override
  Future<ApiResult> changeActive(String uuid) async {
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/products/$uuid/active',
      );
      return ApiResult.success(data: response.data);
    } catch (e) {
      debugPrint('==> change active failure: $e');
      return ApiResult.failure(error:  AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteExtrasGroup({int? groupId}) async {
    final data = {
      'ids': [groupId]
    };
    debugPrint('====> delete extras group request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/extra/groups/delete',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete extra group failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleExtrasGroupResponse>> updateExtrasGroup({
    required String title,
    int? groupId,
  }) async {
    final data = {
      'title': {LocalStorage.getLanguage()?.locale ?? 'en': title},
      'type': 'text',
    };
    debugPrint('===> update extras group ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/seller/extra/groups/$groupId',
        data: data,
      );
      return ApiResult.success(
        data: SingleExtrasGroupResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update extra groups failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<void>> deleteProduct(int? productId) async {
    final data = {
      'ids': [productId]
    };
    debugPrint('====> delete product request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/products/delete',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete product failure: $e');
      return ApiResult.failure(error: AppHelpers.errorHandler(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteExtrasItem({
    required int extrasId,
  }) async {
    final data = {
      'ids': [extrasId]
    };
    debugPrint('====> delete extras item request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      await client.delete(
        '/api/v1/dashboard/seller/extra/values/delete',
        data: data,
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete extra item failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<CreateGroupExtrasResponse>> updateExtrasItem({
    required int extrasId,
    required int groupId,
    required String title,
  }) async {
    final data = {'value': title, 'extra_group_id': groupId};
    debugPrint('===> update extras item ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/seller/extra/values/$extrasId',
        data: data,
      );
      return ApiResult.success(
        data: CreateGroupExtrasResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update extra item failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<CreateGroupExtrasResponse>> createExtrasItem({
    required int groupId,
    required String title,
  }) async {
    final data = {'value': title, 'extra_group_id': groupId};
    debugPrint('===> create extras item ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/extra/values',
        data: data,
      );
      return ApiResult.success(
        data: CreateGroupExtrasResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create extra item failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleExtrasGroupResponse>> createExtrasGroup({
    required String title,
  }) async {
    final data = {
      'title': {LocalStorage.getLanguage()?.locale ?? 'en': title},
      'active': 1,
      'type': 'text',
    };
    debugPrint('===> create extras group ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/extra/groups',
        data: data,
      );
      return ApiResult.success(
        data: SingleExtrasGroupResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create extra groups failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<GroupExtrasResponse>> getExtras({int? groupId}) async {
    final data = {'lang': LocalStorage.getLanguage()?.locale ?? 'en'};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/extra/groups/$groupId',
        queryParameters: data,
      );
      return ApiResult.success(
        data: GroupExtrasResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get extras failure: $e,$s');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> updateStocks({
    required List<Stocks> stocks,
    required List<int> deletedStocks,
    String? uuid,
    required bool isWholeSalesPrice,
  }) async {
    final List<Map<String, dynamic>> extras = [];
    for (final stock in stocks) {
      List<int> ids = [];
      if (stock.extras != null && (stock.extras?.isNotEmpty ?? false)) {
        for (final item in stock.extras!) {
          ids.add(item.id ?? 0);
        }
      }
      ids = ids.toSet().toList();

      extras.add(
        {
          'price': stock.price,
          'quantity': stock.quantity,
          if (stock.sku?.isNotEmpty ?? false) 'sku': stock.sku,
          if (ids.isNotEmpty) 'ids': ids,
          if (stock.wholeSalePrices != null && isWholeSalesPrice)
            'whole_sales': List<dynamic>.from(
              stock.wholeSalePrices!.map((x) => x.toJson()),
            ),
          if (deletedStocks.isNotEmpty) 'delete_ids': deletedStocks
        },
      );
    }
    final data = {'extras': extras};
    debugPrint('===> update stocks request ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/products/$uuid/stocks',
        data: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update stocks fail: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> updateProduct({
    required Map<String, List<String>> titlesAndDescriptions,
    required String tax,
    required String minQty,
    required String maxQty,
    required String quantity,
    required bool active,
    bool? digital,
    int? ageLimit,
    int? categoryId,
    int? unitId,
    int? brandId,
    List<String>? images,
    List<String>? previews,
    String? uuid,
    required String interval,
    bool needAddons = false,
  }) async {
    final data = {
      'title': {
        for( int i =0; i< titlesAndDescriptions.keys.length; i++)
          titlesAndDescriptions.keys.toList()[i] : titlesAndDescriptions[titlesAndDescriptions.keys.toList()[i]]?.first ?? ""},
      'description': {
        for(String locale in titlesAndDescriptions.keys)
          locale : titlesAndDescriptions[locale]?.last ?? ""},
      'tax': num.tryParse(tax),
      'min_qty': int.tryParse(minQty),
      'max_qty': int.tryParse(maxQty),
      'active': active ? true : false,
      'quantity': int.tryParse(quantity),
      if (brandId != null) 'brand_id': brandId,
      'age_limit': ageLimit,
      'digital': digital,
      if (categoryId != null) 'category_id': categoryId,
      if (unitId != null) 'unit_id': unitId,
      'images': images,
      if (previews != null) 'previews': previews,
      if (needAddons) 'addon': 1,
      'interval': num.tryParse(interval),
    };
    debugPrint('===> update product ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/seller/products/$uuid',
        data: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update product fail: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> updateExtras({
    required List<int> extrasIds,
    String? productUuid,
  }) async {
    final data = {'extras': extrasIds};
    debugPrint('===> update extras ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/products/$productUuid/extras',
        data: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update extras failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<ExtrasGroupsResponse>> getExtrasGroups({
    bool needOnlyValid = true,
  }) async {
    final data = {'lang': LocalStorage.getLanguage()?.locale ?? 'en', "perPage": 50};
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/extra/groups',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ExtrasGroupsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get extras groups failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> createProduct({
    required Map<String, List<String>> titlesAndDescriptions,
    required String tax,
    required String minQty,
    required String maxQty,
    required String ageLimit,
    required bool active,
    required String interval,
    bool digital = false,
    int? categoryId,
    int? brandId,
    int? unitId,
    List<String>? image,
    List<String>? previews,
    LanguageData? languageData,

  }) async {
    final data = {
      'title': {
        for( int i =0; i< titlesAndDescriptions.keys.length; i++)
        titlesAndDescriptions.keys.toList()[i] : titlesAndDescriptions[titlesAndDescriptions.keys.toList()[i]]?.first ?? ""},
      'description': {
        for(String locale in titlesAndDescriptions.keys)
        locale : titlesAndDescriptions[locale]?.last ?? ""},
      'tax': num.tryParse(tax),
      'min_qty': num.tryParse(minQty),
      'max_qty': num.tryParse(maxQty),
      'age_limit': num.tryParse(ageLimit),
      'active': active ? 1 : 0,
      'digital': digital ? 1 : 0,
      'bar_code': "qrcode",
      'interval': num.tryParse(interval),
      if (categoryId != null) 'category_id': categoryId,
      if (unitId != null) 'unit_id': unitId,
      if (brandId != null) 'brand_id': brandId,
      if (image != null) 'images': image,
      if (previews != null) 'previews': previews,
    };
    debugPrint('===> create product ${jsonEncode(data)}');
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/seller/products',
        data: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create product fail: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> getProductDetails(
    String uuid,
  ) async {
    final data = {
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/$uuid',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get product details failure: $e,$s');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> getProductDetailsEdited(
    String uuid,
  ) async {
    final data = {
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/products/$uuid',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e, s) {
      debugPrint('==> get product details failure: $e,$s');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<ProductsPaginateResponse>> getProducts({
    required int page,
    int? shopId,
    int? categoryId,
    String? query,
    ProductStatus? status,
    int? brandId,
    bool? isNew,
    List<int>? brandIds,
    List<int>? categoryIds,
    List<int>? extrasId,
    num? priceTo,
    num? priceFrom,
    bool active = false,
  }) async {
    String? statusText;
    if (status != null) {
      switch (status) {
        case ProductStatus.pending:
          statusText = 'pending';
          break;
        case ProductStatus.published:
          statusText = 'published';
          break;
        case ProductStatus.unpublished:
          statusText = 'unpublished';
          break;
        default:
          statusText = 'published';
          break;
      }
    }

    final data = {
      if (query != null) 'search': query,
      'perPage': 12,
      "page": page,
      if (categoryIds != null)
        for (int i = 0; i < categoryIds.length; i++)
          'category_ids[$i]': categoryIds[i],
      if (brandIds != null)
        for (int i = 0; i < brandIds.length; i++) 'brand_ids[$i]': brandIds[i],
      if (extrasId != null)
        for (int i = 0; i < extrasId.length; i++) 'extras[$i]': extrasId[i],
      if (priceTo != null) "price_to": priceTo,
      if (priceFrom != null) 'price_from': priceFrom,
      if (categoryId != null) 'category_id': categoryId,
      if (brandId != null) 'brand_id': brandId,
      if (shopId != null) 'shop_id': shopId,
      if (isNew ?? false) "column": "created_at",
      if (isNew ?? false) 'sort': 'desc',
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      if (active) 'active': 1,
      if (statusText != null) 'status': statusText,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/products/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ProductsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get products failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<FilterResponse>> fetchFilter({
    required String type,
    List<int>? brandId,
    List<int>? categoryId,
    List<int>? extrasId,
    num? priceTo,
    num? priceFrom,
  }) async {
    final data = {
      if (categoryId != null)
        for (int i = 0; i < categoryId.length; i++)
          'category_ids[$i]': categoryId[i],
      if (brandId != null)
        for (int i = 0; i < brandId.length; i++) 'brand_ids[$i]': brandId[i],
      if (extrasId != null)
        for (int i = 0; i < extrasId.length; i++) 'extras[$i]': extrasId[i],
      if (priceTo != null) "price_to": priceTo,
      'shop_ids[0]': LocalStorage.getUser()?.shop?.id,
      if (priceFrom != null) 'price_from': priceFrom,
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'type': type,
      // 'active': true,
      // 'status': "published",
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/filter',
        queryParameters: data,
      );
      return ApiResult.success(data: FilterResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> fetch filter rest failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }

  @override
  Future<ApiResult<FilterResponse>> fetchAllFilter({
    required String type,
    List<int>? brandId,
    List<int>? categoryId,
    List<int>? extrasId,
    num? priceTo,
    num? priceFrom,
  }) async {
    final data = {
      if (categoryId != null)
        for (int i = 0; i < categoryId.length; i++)
          'category_ids[$i]': categoryId[i],
      if (brandId != null)
        for (int i = 0; i < brandId.length; i++) 'brand_ids[$i]': brandId[i],
      if (extrasId != null)
        for (int i = 0; i < extrasId.length; i++) 'extras[$i]': extrasId[i],
      if (priceTo != null) "price_to": priceTo,
      if (priceFrom != null) 'price_from': priceFrom,
      'currency_id': LocalStorage.getSelectedCurrency()?.id,
      'lang': LocalStorage.getLanguage()?.locale ?? 'en',
      'type': type,
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/seller/filter',
        queryParameters: data,
      );
      return ApiResult.success(data: FilterResponse.fromJson(response.data));
    } catch (e, s) {
      debugPrint('==> fetch filter failure: $e, $s');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }
  @override
  Future<ApiResult> updateGalleries(
      Map<String, List<String?>> galleries,
      ) async {
    final data = {
      'data': [
        for(var i in galleries.keys){
          "id": i, "images": galleries[i]
        }
      ],
    };
    try {
      final client = dioHttp.client(requireAuth: true);
      final res = await client.post(
        '/api/v1/dashboard/seller/stocks/galleries',
        data: data,
      );
      return ApiResult.success(data: res.data);
    } catch (e) {
      debugPrint('==> update galleries failure: $e');
      return ApiResult.failure(
        error: AppHelpers.errorHandler(e),
      );
    }
  }
}

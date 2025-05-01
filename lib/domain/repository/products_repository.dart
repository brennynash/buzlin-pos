import 'package:admin_desktop/infrastructure/services/utils.dart';

import '../../domain/handlers/handlers.dart';
import '../../domain/models/models.dart';
import '../../domain/models/response/product_calculate_response.dart';

abstract class ProductsRepository {

  Future<ApiResult<ProductCalculateResponse>> getAllCalculations(
      BagData bag,
      String type, {
        int? bagIndex,
        int? deliveryPriceId,
      });
  Future<ApiResult<Digital>> updateDigitalFile({
    required String filePath,
    required int? productId,
  });
  Future<ApiResult<dynamic>> changeActive(String uuid);

  Future<ApiResult<void>> deleteExtrasGroup({int? groupId});

  Future<ApiResult<SingleExtrasGroupResponse>> updateExtrasGroup({
    required String title,
    int? groupId,
  });

  Future<ApiResult<void>> deleteExtrasItem({
    required int extrasId,
  });

  Future<ApiResult<CreateGroupExtrasResponse>> updateExtrasItem({
    required int extrasId,
    required int groupId,
    required String title,
  });

  Future<ApiResult<CreateGroupExtrasResponse>> createExtrasItem({
    required int groupId,
    required String title,
  });

  Future<ApiResult<SingleExtrasGroupResponse>> createExtrasGroup({
    required String title,
  });


  Future<ApiResult<GroupExtrasResponse>> getExtras({int? groupId});

  Future<ApiResult<SingleProductResponse>> updateStocks({
    required List<Stocks> stocks,
    required List<int> deletedStocks,
    String? uuid,
    required bool isWholeSalesPrice,
  });

  Future<ApiResult<void>> deleteProduct(int? productId);

  Future<ApiResult<SingleProductResponse>> updateProduct({
    required Map<String, List<String>> titlesAndDescriptions,
    required String tax,
    required String minQty,
    required String maxQty,
    required String quantity,
    required bool active,
    required String interval,
    bool? digital,
    int? categoryId,
    int? unitId,
    int? brandId,
    int? ageLimit,
    List<String>? images,
    List<String>? previews,
    String? uuid,
    bool needAddons = false,
  });

  Future<ApiResult<SingleProductResponse>> updateExtras({
    required List<int> extrasIds,
    String? productUuid,
  });

  Future<ApiResult<ExtrasGroupsResponse>> getExtrasGroups({
    bool needOnlyValid = true,
  });

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
  });

  Future<ApiResult<SingleProductResponse>> getProductDetails(String uuid);

  Future<ApiResult<SingleProductResponse>> getProductDetailsEdited(String uuid);

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
  });

  Future<ApiResult<FilterResponse>> fetchFilter({
    required String type,
    List<int>? brandId,
    List<int>? categoryId,
    List<int>? extrasId,
    num? priceTo,
    num? priceFrom,
  });

  Future<ApiResult<FilterResponse>> fetchAllFilter({
    required String type,
    List<int>? brandId,
    List<int>? categoryId,
    List<int>? extrasId,
    num? priceTo,
    num? priceFrom,
  });
  Future<ApiResult> updateGalleries(
      Map<String, List<String?>> galleries,
      );
}

import '../../domain/handlers/handlers.dart';
import '../../domain/models/models.dart';

abstract class BrandsRepository {
  Future<ApiResult<BrandsPaginateResponse>> searchBrands(String? query);

  Future<ApiResult<BrandsPaginateResponse>> getBrands({
    bool isActive = true,
    int page = 1,
  });

  Future<ApiResult<void>> deleteBrand(int? brandId);

  Future<ApiResult<SingleBrandResponse>> addBrand({
    required String title,
    required bool active,
    String? image,
  });

  Future<ApiResult<SingleBrandResponse>> updateBrand({
    required String title,
    required bool active,
    required int id,
    String? image,
  });
}

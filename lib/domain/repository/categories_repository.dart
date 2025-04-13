import 'package:admin_desktop/infrastructure/services/utils.dart';

import '../../domain/handlers/handlers.dart';
import '../../domain/models/models.dart';

abstract class CategoriesRepository {
  Future<ApiResult<CategoriesPaginateResponse>> searchCategories(String? query);

  Future<ApiResult<UnitsPaginateResponse>> getUnits();

  Future<ApiResult<void>> createCategory({
    required Map<String, List<String>> titlesAndDescriptions,
    required bool active,
    String? image,
    String? type,
    int? parentId,
  });

  Future<ApiResult> updateCategory({
    required Map<String, List<String>> titlesAndDescriptions,
    required bool active,
    required String id,
    String? image,
    String? type,
    int? parentId,
  });

  Future<ApiResult<CategoriesPaginateResponse>> getCategories({
    int? page,
    String? query,
    CategoryStatus? status,
    bool? active,
    String? type,
  });

  Future<ApiResult<void>> deleteCategory(int? categoryId);

  Future<ApiResult<SingleCategoryResponse>> fetchSingleCategory(String? uuid);
}

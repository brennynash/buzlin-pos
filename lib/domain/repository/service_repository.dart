import '../../domain/handlers/handlers.dart';
import '../../domain/models/models.dart';


abstract class ServiceFacade {
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
  });

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
  });

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
    bool? active
  });

  Future<ApiResult<ServiceResponse>> fetchSingleService(int? id);

  Future<ApiResult> deleteService(int? id);
}

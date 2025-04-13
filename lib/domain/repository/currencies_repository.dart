import '../../domain/handlers/handlers.dart';
import '../../domain/models/models.dart';

abstract class CurrenciesRepository {
  Future<ApiResult<CurrenciesResponse>> getCurrencies();
}

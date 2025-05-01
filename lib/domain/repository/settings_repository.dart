import 'package:admin_desktop/domain/models/data/help_data.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';

import '../../domain/handlers/handlers.dart';
import '../../domain/models/models.dart';
import '../../domain/models/response/gallery_upload_response.dart';
import '../../domain/models/response/income_cart_response.dart';
import '../../domain/models/response/income_statistic_response.dart';
import '../../domain/models/response/mobile_translations_response.dart';
import '../../domain/models/response/sale_history_response.dart';


abstract class SettingsRepository {
  Future<ApiResult<GlobalSettingsResponse>> getGlobalSettings();

  Future<ApiResult<TranslationsResponse>> getTranslations(
      {String? lang, int? id});

  Future<ApiResult<SaleHistoryResponse>> getSaleHistory(int type, int page);

  Future<ApiResult<SaleCartResponse>> getSaleCart();

  Future<ApiResult<IncomeCartResponse>> getIncomeCart(
      {required String type, required DateTime? from, required DateTime? to});

  Future<ApiResult<IncomeStatisticResponse>> getIncomeStatistic(
      {required String type, required DateTime? from, required DateTime? to});

  Future<ApiResult<List<IncomeChartResponse>>> getIncomeChart(
      {required String type, required DateTime? from, required DateTime? to});

  Future<ApiResult<GalleryUploadResponse>> uploadImage(
    String filePath,
    UploadType uploadType,
  );

  Future<ApiResult<LanguagesResponse>> getLanguages();

  Future<ApiResult<MobileTranslationsResponse>> getMobileTranslations({String? lang});

  Future<ApiResult<MultiGalleryUploadResponse>> uploadMultiImage(
      List<String?> filePaths,
      UploadType uploadType,
      );
  Future<ApiResult<HelpModel>> getFaq();

}

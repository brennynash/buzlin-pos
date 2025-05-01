import '../handlers/handlers.dart';
import '../models/models.dart';

abstract class FormOptionRepository {
  Future<ApiResult<SingleFormOptionsResponse>> getFormOptionsDetails(int? id);

  Future<ApiResult<FormOptionsResponse>> getFormOptions({int? page});

  Future<ApiResult<SingleFormOptionsResponse>> addForm({
    required bool required,
    required bool active,
    required String title,
    required String description,
    required List<QuestionData> questions,
  });

  Future<ApiResult<SingleFormOptionsResponse>> updateForm({
    required int? id,
    required bool required,
    required bool active,
    required String title,
    required String description,
    required List<QuestionData> questions,
  });

  Future<ApiResult<void>> deleteFormOption(int? id);
}

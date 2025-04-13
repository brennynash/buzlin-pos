import 'package:admin_desktop/domain/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'add_brand_state.freezed.dart';

@freezed
class AddBrandState with _$AddBrandState {
  const factory AddBrandState({
    @Default('') String title,
    @Default(true) bool active,
    @Default(false) bool isLoading,
    @Default(false) bool isInitial,
    String? imageFile,
    Brand? brandData,
  }) = _AddBrandState;

  const AddBrandState._();
}

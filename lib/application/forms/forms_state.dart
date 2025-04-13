import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/models.dart';
part 'forms_state.freezed.dart';

@freezed
class FormOptionState with _$FormOptionState {
  const factory FormOptionState({
    @Default(false) bool isLoading,
    @Default([]) List<FormOptionsData> list,
    @Default(true) bool hasMore,
  }) = _FormOptionState;

  const FormOptionState._();
}

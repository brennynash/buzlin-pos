import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_desktop/domain/models/models.dart';
part 'edit_masters_state.freezed.dart';

@freezed
class EditMastersState with _$EditMastersState {
  const factory EditMastersState({
    @Default(false) bool isLoading,
    @Default(false) bool isUpdating,
    @Default(null) String? imageFile,
    @Default(0) int index,
    UserData? master,
    UserData? masterData,
  }) = _EditMastersState;

  const EditMastersState._();
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'create_category_state.dart';

class CreateCategoryNotifier extends StateNotifier<CreateCategoryState> {
  final CategoriesRepository _catalogFacade;
  final GalleryRepositoryFacade _settingsRepository;

  CreateCategoryNotifier(
    this._catalogFacade,
    this._settingsRepository,
  ) : super(CreateCategoryState(
            titleController: TextEditingController(),
            descriptionController: TextEditingController()));

  void changeActive(bool? active) {
    state = state.copyWith(active: !state.active);
  }

  void setCategory(CategoryData category) {
    state = state.copyWith(
        category: category,
        active: category.active ?? true,
        title: category.translation?.title ??
            AppHelpers.getTranslation(TrKeys.noName));
  }

  void setLanguage(LanguageData? languageData) {
    state = state.copyWith(language: languageData);
  }

  void clear() {
    state = state.copyWith(
      category: null,
      active: true,
      imageFile: null,
      isLoading: false,
    );
    setLanguage(LocalStorage.getLanguage());
  }

  void setDesc() {
    Map<String, List<String>> temp = Map.from(state.mapOfDesc);
    if (temp.containsKey(state.language?.locale)) {
      List<String> list = [state.title, state.description];
      temp.update(state.language?.locale ?? "en", (value) => list);
    } else {
      List<String> list = [state.title, state.description];
      temp[state.language?.locale ?? "en"] = list;
    }
    state = state.copyWith(
      mapOfDesc: temp,
    );
  }

  void setTitleAndDescState(String key) {
    state = state.copyWith(
        title: state.mapOfDesc[key]?.first ?? "",
        description: state.mapOfDesc[key]?.last ?? "");
    state.titleController?.text = state.mapOfDesc[key]?.first ?? "";
    state.descriptionController?.text = state.mapOfDesc[key]?.last ?? "";
  }

  Future<void> createCategory(
    BuildContext context, {
    required int? parentId,
    String? type,
    VoidCallback? created,
    VoidCallback? onError,
  }) async {
    state = state.copyWith(isLoading: true);
    String? imageUrl;
    if (state.imageFile != null) {
      final imageResponse = await _settingsRepository.uploadImage(
        state.imageFile!,
        UploadType.brands,
      );
      imageResponse.when(
        success: (data) {
          imageUrl = data.imageData?.title;
        },
        failure: (failure, status) {
          debugPrint('==> upload product image fail: $failure');
          AppHelpers.showSnackBar(
            context,
            failure,
          );
        },
      );
    }
    final response = await _catalogFacade.createCategory(
      active: state.active,
      image: imageUrl,
      titlesAndDescriptions: state.mapOfDesc,
      parentId: parentId,
      type: type,
    );
    response.when(
      success: (data) {
        state = state.copyWith(isLoading: false);
        created?.call();
      },
      failure: (failure, status) {
        debugPrint('===> create product fail $failure');
        state = state.copyWith(isLoading: false);
        AppHelpers.showSnackBar(context, failure);
        onError?.call();
      },
    );
  }

  void setActive(bool? value) {
    state = state.copyWith(active: !state.active);
    debugPrint('===> set active ${state.active}');
  }

  void setTitle(String value) {
    state = state.copyWith(title: value.trim());
  }

  void setDescription(String value) {
    state = state.copyWith(description: value.trim());
  }

  void setImageFile(String? file) {
    state = state.copyWith(imageFile: file);
  }
}

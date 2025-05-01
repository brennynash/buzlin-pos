import 'package:admin_desktop/infrastructure/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/models.dart';
import '../../domain/repository/repository.dart';
import 'edit_category_state.dart';

class EditCategoryNotifier extends StateNotifier<EditCategoryState> {
  final CategoriesRepository _catalogRepository;
  final GalleryRepositoryFacade _galleryRepository;

  EditCategoryNotifier(this._catalogRepository, this._galleryRepository)
      : super(EditCategoryState(titleController: TextEditingController(), descriptionController: TextEditingController()));

  void changeActive(bool? active) {
    state = state.copyWith(active: !state.active);
  }

  Future<void> updateCategory(
    BuildContext context, {
    required int? parentId,
    String? type,
    CategoryData? category,
    VoidCallback? updated,
    VoidCallback? failed,
  }) async {
    state = state.copyWith(isUpdate: true, isLoading: true);
    String? imageUrl;
    if (state.imageFile != null) {
      final imageResponse = await _galleryRepository.uploadImage(
        state.imageFile!,
        UploadType.products,
      );
      imageResponse.when(
        success: (data) {
          imageUrl = data.imageData?.title;
        },
        failure: (failure, status) {
          debugPrint('==> upload category image fail: $failure');
        },
      );
    }
    final response = await _catalogRepository.updateCategory(
      titlesAndDescriptions: state.mapOfDesc,
      active: state.active,
      id: state.category?.uuid ?? "0",
      image: imageUrl,
      parentId: parentId,
      type: type ?? state.category?.type,
    );
    response.when(
      success: (data) {
        state = state.copyWith(imageFile: null);
        state = state.copyWith(isUpdate: false, isLoading: false);
        updated?.call();
      },
      failure: (fail, status) {
        state = state.copyWith(isUpdate: false,  isLoading: false);
        // AppHelperss.showCheckTopSnackBar(context,
        //     text: fail, type: SnackBarType.error);

        debugPrint('===> category update fail $fail');
        failed?.call();
      },
    );
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

  void deleteImage(String value) {
    List<String> list = List.from(state.images);
    list.remove(value);
    List<Galleries> urls = List.from(state.listOfUrls);
    urls.removeWhere((element) => element.path == value);
    state = state.copyWith(images: list, listOfUrls: urls);
  }

  void setLanguage(LanguageData? languageData) {
    state = state.copyWith(language: languageData);
  }

  void setDesc(){
    Map<String, List<String>> temp = Map.from(state.mapOfDesc);
    if(temp.containsKey(state.language?.locale)){
      List<String> list = [state.title, state.description];
      temp.update(state.language?.locale ?? "en", (value) => list);
    }else{
      List<String> list = [state.title, state.description];
      temp[state.language?.locale ?? "en"] = list;
    }
    state = state.copyWith(mapOfDesc: temp,);
  }

  void setTitleAndDescState(String key){
    state = state.copyWith(title: state.mapOfDesc[key]?.first ?? "", description: state.mapOfDesc[key]?.last ?? "");
    state.titleController?.text = state.mapOfDesc[key]?.first ?? "";
    state.descriptionController?.text = state.mapOfDesc[key]?.last ?? "";
  }



  Future<void> setCategoryDetails(
      CategoryData? category, ValueChanged<CategoryData?> onSuccess) async {
    state = state.copyWith(
        category: category,
        title: category?.translation?.title ?? '',
        active: category?.active ?? false,
        listOfUrls: state.listOfUrls,
        images: []);
    showCategory(onSuccess);
  }

  showCategory(ValueChanged<CategoryData?> onSuccess) async {
    state = state.copyWith(isLoading: true);
    final res =
        await _catalogRepository.fetchSingleCategory(state.category?.uuid);
    res.when(success: (data) {
      state.titleController?.text = data.data?.translation?.title ?? "";
      state.descriptionController?.text = data.data?.translation?.description ?? "";
      if(data.data?.translations != null){
        Map<String, List<String>> temp = Map.from(state.mapOfDesc);
        var items = data.data?.translations;
        for(int i = 0; i < data.data!.translations!.length; i++){
          temp[items?[i].locale ?? "en"] = [items?[i].title ?? '', items?[i].description ?? ''];
        }
        state = state.copyWith(mapOfDesc: temp);
      }
      state = state.copyWith(category: data.data, isLoading: false);
      onSuccess.call(data.data);
    }, failure: (error, statusCode) {
      state = state.copyWith(isLoading: false);
      debugPrint("show category fail ==> $error");
    });
  }
}
